package ModelosDAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import config.Conexion;
import Modelos.Revista;

public class RevistaDAO {

    private Connection conn;

    public RevistaDAO() {
        try {
            conn = Conexion.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Método para insertar una nueva revista usando procedimiento almacenado con manejo de errores
    public boolean insertarRevista(Revista revista) throws SQLException {
        boolean resultado = false;
        String sql = "{CALL sp_insertar_revista(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";
        CallableStatement cs = null;

        try {
            cs = conn.prepareCall(sql);

            // Establecer parámetros de entrada
            cs.setInt(1, revista.getTipoMaterialId());
            cs.setString(2, revista.getTitulo());
            if (revista.getAñoPublicacion() != null) {
                cs.setInt(3, revista.getAñoPublicacion());
            } else {
                cs.setNull(3, Types.INTEGER);
            }
            cs.setString(4, revista.getEditorial());
            cs.setString(5, revista.getUbicacionFisica());
            cs.setString(6, revista.getEstado());
            cs.setInt(7, revista.getCantidadTotal());
            cs.setInt(8, revista.getCantidadDisponible());
            cs.setString(9, revista.getDescripcion());
            if (revista.getFechaAdquisicion() != null) {
                cs.setDate(10, new java.sql.Date(revista.getFechaAdquisicion().getTime()));
            } else {
                cs.setNull(10, Types.DATE);
            }
            cs.setString(11, revista.getCodigoBarras());
            cs.setString(12, revista.getIdioma());

            cs.setString(13, revista.getISSN());
            cs.setString(14, revista.getVolumen());
            cs.setString(15, revista.getNumero());
            if (revista.getFechaPublicacion() != null) {
                cs.setDate(16, new java.sql.Date(revista.getFechaPublicacion().getTime()));
            } else {
                cs.setNull(16, Types.DATE);
            }
            cs.setString(17, revista.getPeriodicidad());
            cs.setString(18, revista.getTemaPrincipal());

            // Parámetros de salida
            cs.registerOutParameter(19, Types.INTEGER); // p_material_id
            cs.registerOutParameter(20, Types.INTEGER); // p_error
            cs.registerOutParameter(21, Types.VARCHAR); // p_mensaje_error

            cs.execute();

            int p_error = cs.getInt(20);
            String p_mensaje_error = cs.getString(21);

            if (p_error == 0) {
                int materialId = cs.getInt(19);
                revista.setMaterialId(materialId);
                resultado = true;
            } else {
                throw new SQLException("Error al insertar revista: " + p_mensaje_error);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw e; // Re-lanzar la excepción para que pueda ser manejada en niveles superiores
        } finally {
            if (cs != null) {
                cs.close();
            }
        }

        return resultado;
    }

    // Método para actualizar una revista usando procedimiento almacenado con manejo de errores
    public boolean actualizarRevista(Revista revista) throws SQLException {
        boolean resultado = false;
        String sql = "{CALL sp_actualizar_revista(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";
        CallableStatement cs = null;

        try {
            cs = conn.prepareCall(sql);

            // Establecer parámetros de entrada
            cs.setInt(1, revista.getMaterialId());
            cs.setInt(2, revista.getTipoMaterialId());
            cs.setString(3, revista.getTitulo());
            if (revista.getAñoPublicacion() != null) {
                cs.setInt(4, revista.getAñoPublicacion());
            } else {
                cs.setNull(4, Types.INTEGER);
            }
            cs.setString(5, revista.getEditorial());
            cs.setString(6, revista.getUbicacionFisica());
            cs.setString(7, revista.getEstado());
            cs.setInt(8, revista.getCantidadTotal());
            cs.setInt(9, revista.getCantidadDisponible());
            cs.setString(10, revista.getDescripcion());
            if (revista.getFechaAdquisicion() != null) {
                cs.setDate(11, new java.sql.Date(revista.getFechaAdquisicion().getTime()));
            } else {
                cs.setNull(11, Types.DATE);
            }
            cs.setString(12, revista.getCodigoBarras());
            cs.setString(13, revista.getIdioma());

            cs.setString(14, revista.getISSN());
            cs.setString(15, revista.getVolumen());
            cs.setString(16, revista.getNumero());
            if (revista.getFechaPublicacion() != null) {
                cs.setDate(17, new java.sql.Date(revista.getFechaPublicacion().getTime()));
            } else {
                cs.setNull(17, Types.DATE);
            }
            cs.setString(18, revista.getPeriodicidad());
            cs.setString(19, revista.getTemaPrincipal());

            // Parámetros de salida
            cs.registerOutParameter(20, Types.INTEGER); // p_error
            cs.registerOutParameter(21, Types.VARCHAR); // p_mensaje_error

            cs.execute();

            int p_error = cs.getInt(20);
            String p_mensaje_error = cs.getString(21);

            if (p_error == 0) {
                resultado = true;
            } else {
                throw new SQLException("Error al actualizar revista: " + p_mensaje_error);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw e; // Re-lanzar la excepción
        } finally {
            if (cs != null) {
                cs.close();
            }
        }

        return resultado;
    }

    // Método para eliminar una revista usando procedimiento almacenado con manejo de errores
    public boolean eliminarRevista(int materialId) throws SQLException {
        boolean resultado = false;
        String sql = "{CALL sp_eliminar_revista(?, ?, ?)}";
        CallableStatement cs = null;

        try {
            cs = conn.prepareCall(sql);

            cs.setInt(1, materialId);

            // Parámetros de salida
            cs.registerOutParameter(2, Types.INTEGER); // p_error
            cs.registerOutParameter(3, Types.VARCHAR); // p_mensaje_error

            cs.execute();

            int p_error = cs.getInt(2);
            String p_mensaje_error = cs.getString(3);

            if (p_error == 0) {
                resultado = true;
            } else {
                throw new SQLException("Error al eliminar revista: " + p_mensaje_error);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw e; // Re-lanzar la excepción
        } finally {
            if (cs != null) {
                cs.close();
            }
        }

        return resultado;
    }


   // Método para obtener una revista por ID usando un procedimiento almacenado con manejo de errores
    public Revista obtenerRevistaPorId(int materialId) throws SQLException {
        Revista revista = null;
        String sql = "{CALL sp_obtener_revista_por_id(?, ?, ?)}";
        CallableStatement cs = null;
        ResultSet rs = null;

        try {
            cs = conn.prepareCall(sql);
            cs.setInt(1, materialId);

            // Registrar los parámetros de salida
            cs.registerOutParameter(2, Types.INTEGER); // p_error
            cs.registerOutParameter(3, Types.VARCHAR); // p_mensaje_error

            // Ejecutar el procedimiento almacenado
            boolean hasResultSet = cs.execute();

            // Obtener los parámetros de salida
            int p_error = cs.getInt(2);
            String p_mensaje_error = cs.getString(3);

            if (p_error == 0) {
                if (hasResultSet) {
                    rs = cs.getResultSet();
                    if (rs.next()) {
                        revista = new Revista();
                        // Mapear los datos del ResultSet al objeto Revista
                        revista.setMaterialId(rs.getInt("material_id"));
                        revista.setTipoMaterialId(rs.getInt("tipo_material_id"));
                        revista.setTitulo(rs.getString("titulo"));
                        revista.setAñoPublicacion(rs.getInt("año_publicacion"));
                        revista.setEditorial(rs.getString("editorial"));
                        revista.setUbicacionFisica(rs.getString("ubicacion_fisica"));
                        revista.setEstado(rs.getString("estado"));
                        revista.setCantidadTotal(rs.getInt("cantidad_total"));
                        revista.setCantidadDisponible(rs.getInt("cantidad_disponible"));
                        revista.setDescripcion(rs.getString("descripcion"));
                        revista.setFechaAdquisicion(rs.getDate("fecha_adquisicion"));
                        revista.setCodigoBarras(rs.getString("codigo_barras"));
                        revista.setIdioma(rs.getString("idioma"));
                        // Datos específicos de Revista
                        revista.setISSN(rs.getString("ISSN"));
                        revista.setVolumen(rs.getString("volumen"));
                        revista.setNumero(rs.getString("numero"));
                        revista.setFechaPublicacion(rs.getDate("fecha_publicacion"));
                        revista.setPeriodicidad(rs.getString("periodicidad"));
                        revista.setTemaPrincipal(rs.getString("tema_principal"));
                    } else {
                        throw new SQLException("No se encontraron registros con el ID proporcionado.");
                    }
                } else {
                    throw new SQLException("El procedimiento almacenado no devolvió ningún conjunto de resultados.");
                }
            } else {
                throw new SQLException("Error en procedimiento almacenado: " + p_mensaje_error);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e; // Re-lanzar la excepción para que pueda ser manejada en niveles superiores
        } finally {
            // Cerrar recursos
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (cs != null) {
                try {
                    cs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            // No cerramos la conexión aquí, ya que puede ser reutilizada
        }
        return revista;
    }


    // Método para listar todas las revistas usando procedimiento almacenado con manejo de errores
    public List<Revista> listarRevistas() throws SQLException {
        List<Revista> lista = new ArrayList<>();
        String sql = "{CALL sp_listar_revistas(?, ?)}";
        CallableStatement cs = null;
        ResultSet rs = null;

        try {
            cs = conn.prepareCall(sql);

            // Parámetros de salida
            cs.registerOutParameter(1, Types.INTEGER); // p_error
            cs.registerOutParameter(2, Types.VARCHAR); // p_mensaje_error

            rs = cs.executeQuery();

            int p_error = cs.getInt(1);
            String p_mensaje_error = cs.getString(2);

            if (p_error == 0) {
                while (rs.next()) {
                    Revista revista = new Revista();
                    // Datos de material
                    revista.setMaterialId(rs.getInt("material_id"));
                    revista.setTipoMaterialId(rs.getInt("tipo_material_id"));
                    revista.setTitulo(rs.getString("titulo"));
                    revista.setAñoPublicacion(rs.getInt("año_publicacion"));
                    revista.setEditorial(rs.getString("editorial"));
                    revista.setUbicacionFisica(rs.getString("ubicacion_fisica"));
                    revista.setEstado(rs.getString("estado"));
                    revista.setCantidadTotal(rs.getInt("cantidad_total"));
                    revista.setCantidadDisponible(rs.getInt("cantidad_disponible"));
                    revista.setDescripcion(rs.getString("descripcion"));
                    revista.setFechaAdquisicion(rs.getDate("fecha_adquisicion"));
                    revista.setCodigoBarras(rs.getString("codigo_barras"));
                    revista.setIdioma(rs.getString("idioma"));

                    // Datos de revista
                    revista.setISSN(rs.getString("ISSN"));
                    revista.setVolumen(rs.getString("volumen"));
                    revista.setNumero(rs.getString("numero"));
                    revista.setFechaPublicacion(rs.getDate("fecha_publicacion"));
                    revista.setPeriodicidad(rs.getString("periodicidad"));
                    revista.setTemaPrincipal(rs.getString("tema_principal"));

                    lista.add(revista);
                }
            } else {
                throw new SQLException("Error al listar revistas: " + p_mensaje_error);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw e; // Re-lanzar la excepción
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (cs != null) {
                cs.close();
            }
        }

        return lista;
    }
}

