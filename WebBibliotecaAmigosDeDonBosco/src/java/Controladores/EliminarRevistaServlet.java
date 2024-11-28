package Controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;


import ModelosDAO.RevistaDAO;



@WebServlet(name = "EliminarRevistaServlet", urlPatterns = {"/EliminarRevistaServlet"})
public class EliminarRevistaServlet extends HttpServlet {

    // Reemplazar el método 'processRequest()' con la lógica para eliminar una revista
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener el parámetro "id" enviado desde la vista (JSP) para identificar la revista
        int materialId = Integer.parseInt(request.getParameter("id"));
        RevistaDAO revistaDAO = new RevistaDAO();

        try {
            // Intentar eliminar la revista usando el DAO
            if (revistaDAO.eliminarRevista(materialId)) {
                // Si la eliminación es exitosa, redirigir al listado de revistas
                response.sendRedirect("ListarRevistasServlet");
            }
        } catch (SQLException e) {
            // Si ocurre un error, se envía un mensaje al JSP de error
            e.printStackTrace();
            request.setAttribute("mensajeError", "Error al eliminar la revista: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    // Utilizar el método doGet() para manejar la solicitud de eliminación
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirige a processRequest() para procesar la eliminación de la revista
        processRequest(request, response);
    }

    // Si decides que la eliminación se maneje con POST, puedes modificar el método doPost()
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirige a processRequest() para procesar los datos de eliminación
        processRequest(request, response);
    }

    // Información del servlet (opcional)
    @Override
    public String getServletInfo() {
        return "Servlet que permite eliminar una revista.";
    }
}
