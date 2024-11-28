CREATE DATABASE BibliotecaADB;

use BibliotecaADB;

CREATE TABLE Rol (
    rol_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(20) NOT NULL UNIQUE
);

INSERT INTO Rol (nombre) VALUES
('Administrador'),
('Profesor'),
('Alumno');

CREATE TABLE Usuario (
    usuario_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL UNIQUE,
    nombre_usuario VARCHAR(50) NOT NULL UNIQUE,
    contraseña VARCHAR(256) NOT NULL,
    estado VARCHAR(10) DEFAULT 'Activo',
    rol_id INT NOT NULL,
    FOREIGN KEY (rol_id) REFERENCES Rol(rol_id)
);

CREATE TABLE TipoMaterial (
    tipo_material_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(30) NOT NULL UNIQUE
);

INSERT INTO TipoMaterial (nombre) VALUES
('Libro'),
('Revista'),
('CD'),
('Tesis'),
('Obra'),
('Otros Documentos');


CREATE TABLE Material (
    material_id INT AUTO_INCREMENT PRIMARY KEY,
    tipo_material_id INT NOT NULL,
    titulo VARCHAR(200) NOT NULL,
    año_publicacion INT,
    editorial VARCHAR(100),
    ubicacion_fisica VARCHAR(50),
    estado VARCHAR(15) DEFAULT 'Disponible',
    cantidad_total INT DEFAULT 1,
    cantidad_disponible INT DEFAULT 1,
    descripcion TEXT,
    fecha_adquisicion DATE,
    codigo_barras VARCHAR(50) UNIQUE,
    idioma VARCHAR(30),
    FOREIGN KEY (tipo_material_id) REFERENCES TipoMaterial(tipo_material_id)
);

CREATE TABLE Libro (
    material_id INT PRIMARY KEY,
    ISBN VARCHAR(20),
    numero_edicion VARCHAR(20),
    numero_paginas INT,
    formato VARCHAR(20),
    dimensiones VARCHAR(50),
    FOREIGN KEY (material_id) REFERENCES Material(material_id)
);

CREATE TABLE Revista (
    material_id INT PRIMARY KEY,
    ISSN VARCHAR(20),
    volumen VARCHAR(20),
    numero VARCHAR(20),
    fecha_publicacion DATE,
    periodicidad VARCHAR(20),
    tema_principal VARCHAR(100),
    FOREIGN KEY (material_id) REFERENCES Material(material_id)
);

CREATE TABLE CD (
    material_id INT PRIMARY KEY,
    formato VARCHAR(20),
    duracion VARCHAR(20),
    contenido VARCHAR(50),
    numero_pistas INT,
    requisitos_minimos VARCHAR(100),
    FOREIGN KEY (material_id) REFERENCES Material(material_id)
);

CREATE TABLE Tesis (
    material_id INT PRIMARY KEY,
    grado_academico VARCHAR(50),
    institucion VARCHAR(100),
    director VARCHAR(100),
    area_investigacion VARCHAR(100),
    fecha_defensa DATE,
    numero_paginas INT,
    FOREIGN KEY (material_id) REFERENCES Material(material_id)
);

CREATE TABLE Obra (
    material_id INT PRIMARY KEY,
    tipo_obra VARCHAR(50),
    genero VARCHAR(50),
    numero_volumenes INT,
    artista_compositor VARCHAR(100),
    formato VARCHAR(50),
    dimensiones VARCHAR(50),
    FOREIGN KEY (material_id)
        REFERENCES Material (material_id)
);

CREATE TABLE OtrosDocumentos (
    material_id INT PRIMARY KEY,
    tipo_documento VARCHAR(50),
    organizacion_entidad VARCHAR(100),
    numero_serie VARCHAR(50),
    formato VARCHAR(50),
    dimensiones VARCHAR(50),
    requisitos_especiales VARCHAR(100),
    FOREIGN KEY (material_id) REFERENCES Material(material_id)
);

CREATE TABLE Autor (
    autor_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL
);

-- Esta tabla relaciona los materiales con los autores, permitiendo una relación de muchos a muchos
CREATE TABLE Material_Autor (
    material_id INT NOT NULL,
    autor_id INT NOT NULL,
    PRIMARY KEY (material_id, autor_id),
    FOREIGN KEY (material_id) REFERENCES Material(material_id),
    FOREIGN KEY (autor_id) REFERENCES Autor(autor_id)
);

CREATE TABLE Prestamo (
    prestamo_id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    material_id INT NOT NULL,
    fecha_prestamo DATE NOT NULL,
    fecha_devolucion_prevista DATE NOT NULL,
    fecha_devolucion_real DATE,
    estado VARCHAR(10) DEFAULT 'Activo',
    FOREIGN KEY (usuario_id) REFERENCES Usuario(usuario_id),
    FOREIGN KEY (material_id) REFERENCES Material(material_id)
);

CREATE TABLE Mora (
    mora_id INT AUTO_INCREMENT PRIMARY KEY,
    prestamo_id INT UNIQUE NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    fecha_generacion DATE NOT NULL,
    estado VARCHAR(10) DEFAULT 'Pendiente',
    FOREIGN KEY (prestamo_id) REFERENCES Prestamo(prestamo_id)
);

CREATE TABLE Configuracion (
    configuracion_id INT AUTO_INCREMENT PRIMARY KEY,
    limite_prestamos INT NOT NULL,
    mora_diaria DECIMAL(10,2) NOT NULL,
    año INT NOT NULL UNIQUE
);

INSERT INTO Configuracion (limite_prestamos, mora_diaria, año) VALUES
(5, 1.00, YEAR(CURDATE()));

CREATE TABLE PalabraClave (
    palabra_clave_id INT AUTO_INCREMENT PRIMARY KEY,
    palabra VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Material_PalabraClave (
    material_id INT NOT NULL,
    palabra_clave_id INT NOT NULL,
    PRIMARY KEY (material_id, palabra_clave_id),
    FOREIGN KEY (material_id) REFERENCES Material(material_id),
    FOREIGN KEY (palabra_clave_id) REFERENCES PalabraClave(palabra_clave_id)
);

CREATE TABLE Log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    fecha_hora DATETIME NOT NULL,
    nivel VARCHAR(20) NOT NULL,
    usuario_id INT NULL,
    accion VARCHAR(50) NOT NULL,
    descripcion TEXT,
    ip_direccion VARCHAR(45),
    detalles TEXT,
    FOREIGN KEY (usuario_id) REFERENCES Usuario(usuario_id)
);


-- Inserción de usuarios
INSERT INTO Usuario (nombre, apellido, correo_electronico, nombre_usuario, contraseña, rol_id)
VALUES
('Juan', 'Pérez', 'juan.perez@ejemplo.com', 'juanp', MD5('admin123'), 1), -- Administrador
('María', 'Gómez', 'maria.gomez@ejemplo.com', 'mariag', MD5('profesor123'), 2), -- Profesor
('Carlos', 'López', 'carlos.lopez@ejemplo.com', 'carlosl', MD5('alumno123'), 3), -- Alumno
('Ana', 'Martínez', 'ana.martinez@ejemplo.com', 'anam', MD5('alumno123'), 3); -- Alumna

-- Inserción de materiales
INSERT INTO Material (tipo_material_id, titulo, año_publicacion, editorial, ubicacion_fisica, estado, cantidad_total, cantidad_disponible, descripcion, fecha_adquisicion, codigo_barras, idioma)
VALUES
(1, 'Cien Años de Soledad', 1967, 'Editorial Sudamericana', 'Estante A1', 'Disponible', 5, 5, 'Novela de Gabriel García Márquez', '2015-05-10', 'CB001', 'Español'),
(2, 'Revista National Geographic - Edición Septiembre 2021', 2021, 'National Geographic Society', 'Estante B2', 'Disponible', 3, 3, 'Revista de ciencia y naturaleza', '2021-09-01', 'CB002', 'Español'),
(3, 'Album Thriller', 1982, 'Epic Records', 'Estante C3', 'Disponible', 2, 2, 'Álbum de Michael Jackson', '2018-07-15', 'CB003', 'Inglés'),
(4, 'Tesis sobre Inteligencia Artificial', 2020, 'Universidad XYZ', 'Estante D4', 'Disponible', 1, 1, 'Tesis doctoral sobre IA', '2020-12-01', 'CB004', 'Español'),
(5, 'Obras Completas de Shakespeare', 1997, 'Penguin Classics', 'Estante E5', 'Disponible', 4, 4, 'Colección de obras de William Shakespeare', '2010-03-22', 'CB005', 'Inglés'),
(6, 'Mapa Topográfico de la Región', 2019, 'Instituto Geográfico Nacional', 'Estante F6', 'Disponible', 1, 1, 'Mapa detallado de la región', '2019-08-10', 'CB006', 'Español');

-- Inserción en la tabla Libro
INSERT INTO Libro (material_id, ISBN, numero_edicion, numero_paginas, formato, dimensiones)
VALUES
(1, '978-0060883287', 'Primera', 471, 'Tapa blanda', '15 x 23 cm');


-- Inserción en la tabla Revista
INSERT INTO Revista (material_id, ISSN, volumen, numero, fecha_publicacion, periodicidad, tema_principal)
VALUES
(2, '0027-9358', 'Vol. 240', 'No. 3', '2021-09-01', 'Mensual', 'Ciencia y Naturaleza');

-- Inserción en la tabla CD
INSERT INTO CD (material_id, formato, duracion, contenido, numero_pistas, requisitos_minimos)
VALUES
(3, 'CD de audio', '42:19', 'Música', 9, NULL);

-- Inserción en la tabla Tesis
INSERT INTO Tesis (material_id, grado_academico, institucion, director, area_investigacion, fecha_defensa, numero_paginas)
VALUES
(4, 'Doctorado', 'Universidad XYZ', 'Dr. Alberto Fernández', 'Inteligencia Artificial', '2020-11-20', 250);

-- Inserción en la tabla Obra
INSERT INTO Obra (material_id, tipo_obra, genero, numero_volumenes, artista_compositor, formato, dimensiones)
VALUES
(5, 'Teatro', 'Clásico', 1, 'William Shakespeare', 'Libro', '20 x 25 cm');

-- Inserción en la tabla OtrosDocumentos
INSERT INTO OtrosDocumentos (material_id, tipo_documento, organizacion_entidad, numero_serie, formato, dimensiones, requisitos_especiales)
VALUES
(6, 'Mapa', 'Instituto Geográfico Nacional', 'MGN-REG-2019', 'Impreso', '100 x 70 cm', 'Manejo cuidadoso');

-- Inserción de autores
INSERT INTO Autor (nombre, apellido)
VALUES
('Gabriel', 'García Márquez'),
('William', 'Shakespeare'),
('Michael', 'Jackson'),
('María', 'Rodríguez'); -- Autora de la tesis

-- Relación de materiales y autores
INSERT INTO Material_Autor (material_id, autor_id)
VALUES
(1, 1), -- 'Cien Años de Soledad' de Gabriel García Márquez
(3, 3), -- 'Album Thriller' de Michael Jackson
(4, 4), -- 'Tesis sobre Inteligencia Artificial' de María Rodríguez
(5, 2); -- 'Obras Completas de Shakespeare' de William Shakespeare

-- Inserción de palabras clave
INSERT INTO PalabraClave (palabra)
VALUES
('Realismo Mágico'),
('Literatura Clásica'),
('Música Pop'),
('Inteligencia Artificial'),
('Teatro'),
('Mapa'),
('Ciencia'),
('Naturaleza');

-- Relación de materiales y palabras clave
INSERT INTO Material_PalabraClave (material_id, palabra_clave_id)
VALUES
(1, 1), -- 'Cien Años de Soledad' - 'Realismo Mágico'
(1, 2), -- 'Cien Años de Soledad' - 'Literatura Clásica'
(2, 7), -- 'Revista National Geographic' - 'Ciencia'
(2, 8), -- 'Revista National Geographic' - 'Naturaleza'
(3, 3), -- 'Album Thriller' - 'Música Pop'
(4, 4), -- 'Tesis sobre IA' - 'Inteligencia Artificial'
(5, 2), -- 'Obras de Shakespeare' - 'Literatura Clásica'
(5, 5), -- 'Obras de Shakespeare' - 'Teatro'
(6, 6); -- 'Mapa Topográfico' - 'Mapa'

-- Inserción de configuración para el año actual
INSERT INTO Configuracion (limite_prestamos, mora_diaria, año)
VALUES
(5, 1.00, YEAR(CURDATE()));

-- Inserción de préstamos
INSERT INTO Prestamo (usuario_id, material_id, fecha_prestamo, fecha_devolucion_prevista, estado)
VALUES
(3, 1, '2023-10-01', '2023-10-15', 'Activo'), -- Carlos López prestó 'Cien Años de Soledad'
(4, 2, '2023-09-20', '2023-10-05', 'Finalizado'), -- Ana Martínez prestó 'Revista National Geographic'
(4, 5, '2023-10-10', '2023-10-25', 'Activo'); -- Ana Martínez prestó 'Obras Completas de Shakespeare'

-- Inserción de mora
INSERT INTO Mora (prestamo_id, monto, fecha_generacion, estado)
VALUES
(2, 2.00, '2023-10-06', 'Pendiente'); -- Ana Martínez tiene una mora por devolver tarde la revista

-- Inserción de logs
INSERT INTO Log (fecha_hora, nivel, usuario_id, accion, descripcion, ip_direccion)
VALUES
('2024-11-01 08:00:00', 'INFO', 3, 'Inicio de Sesión', 'El usuario carlosl ha iniciado sesión.', '192.168.1.10'),
('2024-11-01 08:05:00', 'INFO', 3, 'Realizar Préstamo', 'El usuario carlosl realizó un préstamo del material ID 1.', '192.168.1.10'),
('2024-10-20 09:00:00', 'INFO', 4, 'Inicio de Sesión', 'El usuario anam ha iniciado sesión.', '192.168.1.11'),
('2024-10-20 09:10:00', 'INFO', 4, 'Realizar Préstamo', 'El usuario anam realizó un préstamo del material ID 2.', '192.168.1.11'),
('2024-11-06 10:00:00', 'WARN', 4, 'Mora Generada', 'Se generó una mora de 2.00 para el usuario anam por el préstamo ID 2.', '192.168.1.11');

-- Actualización de cantidades disponibles
UPDATE Material SET cantidad_disponible = cantidad_disponible - 1 WHERE material_id IN (1, 2, 5);

-- Consultar Todos los Usuarios
SELECT u.usuario_id, u.nombre, u.apellido, u.nombre_usuario, r.nombre AS rol
FROM Usuario u
JOIN Rol r ON u.rol_id = r.rol_id;

-- Consultar Materiales Disponibles
SELECT m.material_id, m.titulo, tm.nombre AS tipo, m.cantidad_disponible
FROM Material m
JOIN TipoMaterial tm ON m.tipo_material_id = tm.tipo_material_id
WHERE m.estado = 'Disponible';

-- Consultar Préstamos Activos
SELECT p.prestamo_id, u.nombre_usuario, m.titulo, p.fecha_prestamo, p.fecha_devolucion_prevista
FROM Prestamo p
JOIN Usuario u ON p.usuario_id = u.usuario_id
JOIN Material m ON p.material_id = m.material_id
WHERE p.estado = 'Activo';

-- Consultar Moras Pendientes
SELECT mo.mora_id, u.nombre_usuario, mo.monto, mo.fecha_generacion, mo.estado
FROM Mora mo
JOIN Prestamo p ON mo.prestamo_id = p.prestamo_id
JOIN Usuario u ON p.usuario_id = u.usuario_id
WHERE mo.estado = 'Pendiente';

-- Buscar Materiales por Palabra Clave
SELECT m.material_id, m.titulo
FROM Material m
JOIN Material_PalabraClave mpk ON m.material_id = mpk.material_id
JOIN PalabraClave pk ON mpk.palabra_clave_id = pk.palabra_clave_id
WHERE pk.palabra = 'Inteligencia Artificial';

-- Consultar Historial de Logs
SELECT log_id, fecha_hora, nivel, usuario_id, accion, descripcion
FROM Log
ORDER BY fecha_hora DESC;

-- Consultar Autores y sus Materiales
SELECT a.nombre, a.apellido, m.titulo
FROM Autor a
JOIN Material_Autor ma ON a.autor_id = ma.autor_id
JOIN Material m ON ma.material_id = m.material_id;

-- Verificar los Registros Existentes en la Tabla Configuracion
SELECT * FROM Configuracion;

ALTER TABLE Configuracion
DROP INDEX año, -- Eliminamos la restricción única en el campo 'año' si existe
DROP COLUMN año, -- Eliminamos el campo 'año' si ya no es necesario en este contexto
ADD rol_id INT NOT NULL, -- Agregamos un campo 'rol_id' para asociar el tipo de usuario
ADD UNIQUE (rol_id), -- Establecemos 'rol_id' como único para evitar duplicados por rol
ADD FOREIGN KEY (rol_id) REFERENCES Rol(rol_id); -- Establecemos una clave foránea a la tabla Rol

SELECT * FROM configuracion;

ALTER TABLE Configuracion
DROP INDEX año,
DROP COLUMN año;

ALTER TABLE Configuracion
ADD rol_id INT NOT NULL;

UPDATE Configuracion SET rol_id = 3 WHERE configuracion_id = 1; -- o el ID adecuado

ALTER TABLE Configuracion
ADD UNIQUE (rol_id),
ADD FOREIGN KEY (rol_id) REFERENCES Rol(rol_id);

SELECT * FROM Configuracion;

DROP TABLE IF EXISTS Material_PalabraClave;

DROP TABLE IF EXISTS PalabraClave;

SHOW TABLES;

ALTER TABLE Usuario
ADD CONSTRAINT fk_usuario_rol
FOREIGN KEY (rol_id) REFERENCES Rol(rol_id);


ALTER TABLE Material
ADD CONSTRAINT fk_material_tipo
FOREIGN KEY (tipo_material_id) REFERENCES TipoMaterial(tipo_material_id);
-- 
ALTER TABLE Libro
ADD CONSTRAINT fk_libro_material
FOREIGN KEY (material_id) REFERENCES Material(material_id);

ALTER TABLE Revista
ADD CONSTRAINT fk_revista_material
FOREIGN KEY (material_id) REFERENCES Material(material_id);

ALTER TABLE CD
ADD CONSTRAINT fk_cd_material
FOREIGN KEY (material_id) REFERENCES Material(material_id);

ALTER TABLE Tesis
ADD CONSTRAINT fk_tesis_material
FOREIGN KEY (material_id) REFERENCES Material(material_id);

ALTER TABLE Obra
ADD CONSTRAINT fk_obra_material
FOREIGN KEY (material_id) REFERENCES Material(material_id);

ALTER TABLE OtrosDocumentos
ADD CONSTRAINT fk_otrosdocumentos_material
FOREIGN KEY (material_id) REFERENCES Material(material_id);

ALTER TABLE Material_Autor
ADD CONSTRAINT fk_material_autor_material
FOREIGN KEY (material_id) REFERENCES Material(material_id);

ALTER TABLE Material_Autor
ADD CONSTRAINT fk_material_autor_autor
FOREIGN KEY (autor_id) REFERENCES Autor(autor_id);

ALTER TABLE Prestamo
ADD CONSTRAINT fk_prestamo_usuario
FOREIGN KEY (usuario_id) REFERENCES Usuario(usuario_id);

ALTER TABLE Prestamo
ADD CONSTRAINT fk_prestamo_material
FOREIGN KEY (material_id) REFERENCES Material(material_id);

ALTER TABLE Mora
ADD CONSTRAINT fk_mora_prestamo
FOREIGN KEY (prestamo_id) REFERENCES Prestamo(prestamo_id);

ALTER TABLE Configuracion
ADD CONSTRAINT fk_configuracion_rol
FOREIGN KEY (rol_id) REFERENCES Rol(rol_id);

ALTER TABLE Log
ADD CONSTRAINT fk_log_usuario
FOREIGN KEY (usuario_id) REFERENCES Usuario(usuario_id);

SELECT * FROM material;
