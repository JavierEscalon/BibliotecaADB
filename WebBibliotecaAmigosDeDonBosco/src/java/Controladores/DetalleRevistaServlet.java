package Controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import ModelosDAO.RevistaDAO;
import Modelos.Revista;

@WebServlet(name = "DetalleRevistaServlet", urlPatterns = {"/DetalleRevistaServlet"})
public class DetalleRevistaServlet extends HttpServlet {

    // Reemplazar el método 'processRequest()' con la lógica para obtener los detalles de una revista
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener el parámetro "id" enviado desde la vista (JSP) para identificar la revista
        int materialId = Integer.parseInt(request.getParameter("id"));
        RevistaDAO revistaDAO = new RevistaDAO();

        try {
            // Intentar obtener los detalles de la revista usando el DAO
            Revista revista = revistaDAO.obtenerRevistaPorId(materialId);
            if (revista != null) {
                // Si se encuentra la revista, se agrega como atributo al request y se redirige al JSP de detalle
                request.setAttribute("revista", revista);
                request.getRequestDispatcher("detalleRevista.jsp").forward(request, response);
            } else {
                // Si no se encuentra, mostrar un mensaje de error
                request.setAttribute("mensajeError", "La revista no fue encontrada.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            // Si ocurre un error, se envía un mensaje al JSP de error
            e.printStackTrace();
            request.setAttribute("mensajeError", "Error al obtener la revista: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    // Utilizar el método doGet() para manejar la solicitud de obtener detalles
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirige a processRequest() para procesar la obtención de detalles de la revista
        processRequest(request, response);
    }

    // Si decides que la obtención de detalles se maneje con POST (aunque generalmente se usa GET), puedes modificar el método doPost()
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirige a processRequest() para procesar la solicitud
        processRequest(request, response);
    }

    // Información del servlet (opcional)
    @Override
    public String getServletInfo() {
        return "Servlet que permite obtener los detalles de una revista.";
    }
}
