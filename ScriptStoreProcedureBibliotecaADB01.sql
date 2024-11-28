use bibliotecaadb;


DELIMITER $$
DROP PROCEDURE IF EXISTS sp_insertar_revista$$
CREATE PROCEDURE sp_insertar_revista(
    IN p_tipo_material_id INT,
    IN p_titulo VARCHAR(200),
    IN p_año_publicacion INT,
    IN p_editorial VARCHAR(100),
    IN p_ubicacion_fisica VARCHAR(50),
    IN p_estado VARCHAR(15),
    IN p_cantidad_total INT,
    IN p_cantidad_disponible INT,
    IN p_descripcion TEXT,
    IN p_fecha_adquisicion DATE,
    IN p_codigo_barras VARCHAR(50),
    IN p_idioma VARCHAR(30),
    IN p_ISSN VARCHAR(20),
    IN p_volumen VARCHAR(20),
    IN p_numero VARCHAR(20),
    IN p_fecha_publicacion DATE,
    IN p_periodicidad VARCHAR(20),
    IN p_tema_principal VARCHAR(100),
    OUT p_material_id INT,
    OUT p_error INT,
    OUT p_mensaje_error VARCHAR(255)
)
sp: BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET p_error = 1;
        GET DIAGNOSTICS CONDITION 1 p_mensaje_error = MESSAGE_TEXT;
        ROLLBACK;
    END;

    DECLARE EXIT HANDLER FOR SQLWARNING
    BEGIN
        SET p_error = 1;
        GET DIAGNOSTICS CONDITION 1 p_mensaje_error = MESSAGE_TEXT;
        ROLLBACK;
    END;

    -- Validaciones de entrada
    IF p_tipo_material_id IS NULL OR p_titulo IS NULL OR p_año_publicacion IS NULL OR 
       p_editorial IS NULL OR p_ubicacion_fisica IS NULL OR p_estado IS NULL OR
       p_cantidad_total IS NULL OR p_cantidad_disponible IS NULL OR 
       p_descripcion IS NULL OR p_fecha_adquisicion IS NULL OR p_codigo_barras IS NULL OR 
       p_idioma IS NULL OR p_ISSN IS NULL OR p_volumen IS NULL OR 
       p_numero IS NULL OR p_fecha_publicacion IS NULL OR p_periodicidad IS NULL OR 
       p_tema_principal IS NULL THEN
        SET p_error = 1;
        SET p_mensaje_error = 'Todos los campos son obligatorios.';
        LEAVE sp;
    END IF;

    -- Validación lógica: cantidad total >= cantidad disponible
    IF p_cantidad_total < p_cantidad_disponible THEN
        SET p_error = 1;
        SET p_mensaje_error = 'La cantidad total no puede ser menor que la cantidad disponible.';
        LEAVE sp;
    END IF;

    -- Validar duplicados: código de barras único
    IF EXISTS (SELECT 1 FROM material WHERE codigo_barras = p_codigo_barras) THEN
        SET p_error = 1;
        SET p_mensaje_error = 'El código de barras ya existe.';
        LEAVE sp;
    END IF;

    -- Validar duplicados: ISSN único
    IF EXISTS (SELECT 1 FROM revista WHERE ISSN = p_ISSN) THEN
        SET p_error = 1;
        SET p_mensaje_error = 'El ISSN ya existe.';
        LEAVE sp;
    END IF;

    -- Iniciar transacción
    START TRANSACTION;

    -- Insertar en la tabla material
    INSERT INTO material (tipo_material_id, titulo, año_publicacion, editorial, ubicacion_fisica, estado, cantidad_total, cantidad_disponible, descripcion, fecha_adquisicion, codigo_barras, idioma)
    VALUES (p_tipo_material_id, p_titulo, p_año_publicacion, p_editorial, p_ubicacion_fisica, p_estado, p_cantidad_total, p_cantidad_disponible, p_descripcion, p_fecha_adquisicion, p_codigo_barras, p_idioma);

    SET p_material_id = LAST_INSERT_ID();

    -- Insertar en la tabla revista
    INSERT INTO revista (material_id, ISSN, volumen, numero, fecha_publicacion, periodicidad, tema_principal)
    VALUES (p_material_id, p_ISSN, p_volumen, p_numero, p_fecha_publicacion, p_periodicidad, p_tema_principal);

    -- Confirmar transacción
    COMMIT;

    -- Configurar valores de éxito
    SET p_error = 0;
    SET p_mensaje_error = NULL;
END$$
DELIMITER ;


DELIMITER $$
DROP PROCEDURE IF EXISTS sp_actualizar_revista$$
CREATE PROCEDURE sp_actualizar_revista(
    IN p_material_id INT,
    IN p_tipo_material_id INT,
    IN p_titulo VARCHAR(200),
    IN p_año_publicacion INT,
    IN p_editorial VARCHAR(100),
    IN p_ubicacion_fisica VARCHAR(50),
    IN p_estado VARCHAR(15),
    IN p_cantidad_total INT,
    IN p_cantidad_disponible INT,
    IN p_descripcion TEXT,
    IN p_fecha_adquisicion DATE,
    IN p_codigo_barras VARCHAR(50),
    IN p_idioma VARCHAR(30),
    IN p_ISSN VARCHAR(20),
    IN p_volumen VARCHAR(20),
    IN p_numero VARCHAR(20),
    IN p_fecha_publicacion DATE,
    IN p_periodicidad VARCHAR(20),
    IN p_tema_principal VARCHAR(100),
    OUT p_error INT,
    OUT p_mensaje_error VARCHAR(255)
)
sp: BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET p_error = 1;
        GET DIAGNOSTICS CONDITION 1 p_mensaje_error = MESSAGE_TEXT;
        ROLLBACK;
    END;

    DECLARE EXIT HANDLER FOR SQLWARNING
    BEGIN
        SET p_error = 1;
        GET DIAGNOSTICS CONDITION 1 p_mensaje_error = MESSAGE_TEXT;
        ROLLBACK;
    END;

    -- Validaciones de entrada: campos no nulos
    IF p_material_id IS NULL OR p_tipo_material_id IS NULL OR p_titulo IS NULL OR
       p_año_publicacion IS NULL OR p_editorial IS NULL OR p_ubicacion_fisica IS NULL OR
       p_estado IS NULL OR p_cantidad_total IS NULL OR p_cantidad_disponible IS NULL OR
       p_descripcion IS NULL OR p_fecha_adquisicion IS NULL OR p_codigo_barras IS NULL OR
       p_idioma IS NULL OR p_ISSN IS NULL OR p_volumen IS NULL OR
       p_numero IS NULL OR p_fecha_publicacion IS NULL OR p_periodicidad IS NULL OR
       p_tema_principal IS NULL THEN
        SET p_error = 1;
        SET p_mensaje_error = 'Todos los campos son obligatorios.';
        LEAVE sp; -- Detener la ejecución
    END IF;

    -- Validación lógica: cantidad total >= cantidad disponible
    IF p_cantidad_total < p_cantidad_disponible THEN
        SET p_error = 1;
        SET p_mensaje_error = 'La cantidad total no puede ser menor que la cantidad disponible.';
        LEAVE sp;
    END IF;

    -- Validación de existencia de material en la tabla material
    IF NOT EXISTS (SELECT 1 FROM material WHERE material_id = p_material_id) THEN
        SET p_error = 1;
        SET p_mensaje_error = 'El ID del material no existe en la tabla material.';
        LEAVE sp;
    END IF;

    -- Validación de existencia en la tabla revista
    IF NOT EXISTS (SELECT 1 FROM revista WHERE material_id = p_material_id) THEN
        SET p_error = 1;
        SET p_mensaje_error = 'El ID del material no existe en la tabla revista.';
        LEAVE sp;
    END IF;

    -- Iniciar transacción
    START TRANSACTION;

    -- Actualizar en la tabla material
    UPDATE material
    SET tipo_material_id = p_tipo_material_id, 
        titulo = p_titulo, 
        año_publicacion = p_año_publicacion, 
        editorial = p_editorial,
        ubicacion_fisica = p_ubicacion_fisica, 
        estado = p_estado, 
        cantidad_total = p_cantidad_total, 
        cantidad_disponible = p_cantidad_disponible,
        descripcion = p_descripcion, 
        fecha_adquisicion = p_fecha_adquisicion, 
        codigo_barras = p_codigo_barras, 
        idioma = p_idioma
    WHERE material_id = p_material_id;

    -- Actualizar en la tabla revista
    UPDATE revista
    SET ISSN = p_ISSN, 
        volumen = p_volumen, 
        numero = p_numero, 
        fecha_publicacion = p_fecha_publicacion, 
        periodicidad = p_periodicidad, 
        tema_principal = p_tema_principal
    WHERE material_id = p_material_id;

    -- Confirmar transacción
    COMMIT;

    -- Configurar valores de éxito
    SET p_error = 0;
    SET p_mensaje_error = NULL;
END$$
DELIMITER ;


DELIMITER $$
DROP PROCEDURE IF EXISTS sp_eliminar_revista$$
CREATE PROCEDURE sp_eliminar_revista(
    IN p_material_id INT,
    OUT p_error INT,
    OUT p_mensaje_error VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET p_error = 1;
        GET DIAGNOSTICS CONDITION 1 p_mensaje_error = MESSAGE_TEXT;
        ROLLBACK;
    END;

    DECLARE EXIT HANDLER FOR SQLWARNING
    BEGIN
        SET p_error = 1;
        GET DIAGNOSTICS CONDITION 1 p_mensaje_error = MESSAGE_TEXT;
        ROLLBACK;
    END;

    START TRANSACTION;

    -- Eliminar de la tabla revista
    DELETE FROM revista WHERE material_id = p_material_id;

    -- Eliminar de la tabla material
    DELETE FROM material WHERE material_id = p_material_id;

    COMMIT;
    
    -- Si todo es exitoso
    SET p_error = 0;
    SET p_mensaje_error = NULL;
END$$
DELIMITER ;


DELIMITER $$
DROP PROCEDURE IF EXISTS sp_obtener_revista_por_id$$
CREATE PROCEDURE sp_obtener_revista_por_id(
    IN p_material_id INT,
    OUT p_error INT,
    OUT p_mensaje_error VARCHAR(255)
)
sp: BEGIN
    -- Manejador de errores
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET p_error = 1;
        GET DIAGNOSTICS CONDITION 1 p_mensaje_error = MESSAGE_TEXT;
    END;

    -- Validación de entrada
    IF p_material_id IS NULL THEN
        SET p_error = 1;
        SET p_mensaje_error = 'El ID del material no puede ser NULL.';
        LEAVE sp;
    END IF;

    -- Validación de existencia en material
    IF NOT EXISTS (SELECT 1 FROM material WHERE material_id = p_material_id) THEN
        SET p_error = 1;
        SET p_mensaje_error = 'El material con el ID proporcionado no existe.';
        LEAVE sp;
    END IF;

    -- Validación de existencia en revista
    IF NOT EXISTS (SELECT 1 FROM revista WHERE material_id = p_material_id) THEN
        SET p_error = 1;
        SET p_mensaje_error = 'La revista con el ID proporcionado no existe.';
        LEAVE sp;
    END IF;

    -- Recuperar información de material y revista
    SELECT 
        m.material_id,
        m.tipo_material_id,
        m.titulo,
        m.año_publicacion,
        m.editorial,
        m.ubicacion_fisica,
        m.estado,
        m.cantidad_total,
        m.cantidad_disponible,
        m.descripcion,
        m.fecha_adquisicion,
        m.codigo_barras,
        m.idioma,
        r.ISSN,
        r.volumen,
        r.numero,
        r.fecha_publicacion,
        r.periodicidad,
        r.tema_principal
    FROM material m
    JOIN revista r ON m.material_id = r.material_id
    WHERE m.material_id = p_material_id;

    -- Si todo es exitoso
    SET p_error = 0;
    SET p_mensaje_error = NULL;
END$$
DELIMITER ;


DELIMITER $$
DROP PROCEDURE IF EXISTS sp_listar_revistas$$
CREATE PROCEDURE sp_listar_revistas(
    OUT p_error INT,
    OUT p_mensaje_error VARCHAR(255)
)
sp: BEGIN
    -- Manejador de errores
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        SET p_error = 1;
        SET p_mensaje_error = 'Ocurrió un error al ejecutar el procedimiento.';
    END;

    -- Verificar si hay datos en las tablas
    IF NOT EXISTS (SELECT 1 FROM material m JOIN revista r ON m.material_id = r.material_id) THEN
        SET p_error = 1;
        SET p_mensaje_error = 'No se encontraron registros de revistas.';
        LEAVE sp;
    END IF;

    -- Listar todas las revistas
    SELECT m.*, r.*
    FROM material m
    JOIN revista r ON m.material_id = r.material_id;

    -- Si todo es exitoso
    SET p_error = 0;
    SET p_mensaje_error = NULL;
END$$
DELIMITER ;

CALL sp_listar_revistas(
    @p_error,        -- OUT p_error
    @p_mensaje_error -- OUT p_mensaje_error
);
