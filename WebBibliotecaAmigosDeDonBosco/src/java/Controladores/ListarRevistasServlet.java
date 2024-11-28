package Controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import ModelosDAO.RevistaDAO;
import Modelos.Revista;

@WebServlet(name = "ListarRevistasServlet", urlPatterns = {"/ListarRevistasServlet"})
public class ListarRevistasServlet extends HttpServlet {

    // Reemplazar el método 'processRequest()' con la lógica para listar las revistas
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RevistaDAO revistaDAO = new RevistaDAO();
        try {
            // Obtener la lista de revistas usando el DAO
            List<Revista> listaRevistas = revistaDAO.listarRevistas();
            // Agregar la lista de revistas al request
            request.setAttribute("listaRevistas", listaRevistas);
            // Redirigir al JSP que muestra el listado de revistas
            request.getRequestDispatcher("listaRevistas.jsp").forward(request, response);
        } catch (SQLException e) {
            // Si ocurre un error, se envía un mensaje al JSP de error
            e.printStackTrace();
            request.setAttribute("mensajeError", "Error al listar las revistas: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    // Utilizar el método doGet() para manejar la solicitud de listar todas las revistas
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirige a processRequest() para procesar la solicitud de listar revistas
        processRequest(request, response);
    }

    // Puedes implementar doPost() si necesitas usar POST, aunque generalmente para listar se utiliza GET
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirige a processRequest() para procesar la solicitud de listar revistas
        processRequest(request, response);
    }

    // Información del servlet (opcional)
    @Override
    public String getServletInfo() {
        return "Servlet que permite listar todas las revistas.";
    }
}
