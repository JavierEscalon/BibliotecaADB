package Controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import ModelosDAO.RevistaDAO;
import Modelos.Revista;

@WebServlet(name = "RegistrarRevistaServlet", urlPatterns = {"/RegistrarRevistaServlet"})
public class RegistrarRevistaServlet extends HttpServlet {

    // Reemplazar el método 'processRequest()' con la lógica para registrar una revista
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener parámetros del formulario enviados desde la vista (JSP)
        String titulo = request.getParameter("titulo");
        int tipoMaterialId = Integer.parseInt(request.getParameter("tipoMaterialId"));
        String editorial = request.getParameter("editorial");
        int añoPublicacion = Integer.parseInt(request.getParameter("añoPublicacion"));
        String ubicacionFisica = request.getParameter("ubicacionFisica");
        String estado = request.getParameter("estado");
        int cantidadTotal = Integer.parseInt(request.getParameter("cantidadTotal"));
        int cantidadDisponible = Integer.parseInt(request.getParameter("cantidadDisponible"));
        String descripcion = request.getParameter("descripcion");
        String fechaAdquisicion = request.getParameter("fechaAdquisicion");
        String codigoBarras = request.getParameter("codigoBarras");
        String idioma = request.getParameter("idioma");
        String ISSN = request.getParameter("ISSN");
        String volumen = request.getParameter("volumen");
        String numero = request.getParameter("numero");
        String fechaPublicacion = request.getParameter("fechaPublicacion");
        String periodicidad = request.getParameter("periodicidad");
        String temaPrincipal = request.getParameter("temaPrincipal");

        // Crear una instancia de Revista y setear sus valores
        Revista revista = new Revista();
        revista.setTipoMaterialId(tipoMaterialId);
        revista.setTitulo(titulo);
        revista.setEditorial(editorial);
        revista.setAñoPublicacion(añoPublicacion);
        revista.setUbicacionFisica(ubicacionFisica);
        revista.setEstado(estado);
        revista.setCantidadTotal(cantidadTotal);
        revista.setCantidadDisponible(cantidadDisponible);
        revista.setDescripcion(descripcion);
        revista.setFechaAdquisicion(java.sql.Date.valueOf(fechaAdquisicion));
        revista.setCodigoBarras(codigoBarras);
        revista.setIdioma(idioma);
        revista.setISSN(ISSN);
        revista.setVolumen(volumen);
        revista.setNumero(numero);
        revista.setFechaPublicacion(java.sql.Date.valueOf(fechaPublicacion));
        revista.setPeriodicidad(periodicidad);
        revista.setTemaPrincipal(temaPrincipal);

        // Utilizar RevistaDAO para insertar la revista en la base de datos
        RevistaDAO revistaDAO = new RevistaDAO();
        try {
            if (revistaDAO.insertarRevista(revista)) {
                // Si la inserción es exitosa, redirigir al listado de revistas
                response.sendRedirect("ListarRevistasServlet");
            }
        } catch (SQLException e) {
            // Si ocurre un error, se envía un mensaje al JSP de error
            e.printStackTrace();
            request.setAttribute("mensajeError", "Error al insertar la revista: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    
    // Mantener el método doGet() para llamadas GET (se puede redirigir a una página JSP de registro si es necesario)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Aquí podrías redirigir a una página JSP para registrar una nueva revista, si es necesario.
        request.getRequestDispatcher("registrarRevista.jsp").forward(request, response);
    }


    // Modificar el método doPost() para procesar la solicitud de registro usando processRequest()
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirige a processRequest() para procesar los datos de registro
        processRequest(request, response);
    }

    // Información del servlet (opcional)
    @Override
    public String getServletInfo() {
        return "Servlet que permite registrar una nueva revista.";
    }
}
