package config;

import java.sql.*;

public class Conexion {

    private static final String URL = "jdbc:mysql://localhost:3306/bibliotecaadb";
    private static final String USER = "root"; // Cambia "root" por el usuario de tu base de datos
    private static final String PASSWORD = "Root1@.tr"; // Cambia "password" por la contraseña de tu base de datos

    private static Connection connection;

    // Método para obtener la conexión
    public static Connection getConnection() throws SQLException {
        if (connection == null || connection.isClosed()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver"); // Registrar el driver
                connection = DriverManager.getConnection(URL, USER, PASSWORD);
                System.out.println("Conexión exitosa a la base de datos.");
            } catch (ClassNotFoundException e) {
                System.err.println("Driver no encontrado: " + e.getMessage());
                throw new SQLException("Driver no encontrado", e);
            } catch (SQLException e) {
                System.err.println("Error al conectar a la base de datos: " + e.getMessage());
                throw e;
            }
        }
        return connection;
    }

    // Método para cerrar la conexión
    public static void closeConnection() throws SQLException {
        if (connection != null && !connection.isClosed()) {
            connection.close();
            System.out.println("Conexión cerrada.");
        }
    }
}
