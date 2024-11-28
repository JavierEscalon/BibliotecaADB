package Controladores;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;


import ModelosDAO.RevistaDAO;
import Modelos.Revista;


@WebServlet(name = "ActualizarRevistaServlet", urlPatterns = {"/ActualizarRevistaServlet"})
public class ActualizarRevistaServlet extends HttpServlet {

    // Reemplazar el método 'processRequest()' con la lógica para actualizar una revista
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Obtener parámetros del formulario enviados desde la vista (JSP)
        int materialId = Integer.parseInt(request.getParameter("materialId"));
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
        revista.setMaterialId(materialId);
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

        // Utilizar RevistaDAO para actualizar la revista en la base de datos
        RevistaDAO revistaDAO = new RevistaDAO();
        try {
            if (revistaDAO.actualizarRevista(revista)) {
                // Si la actualización es exitosa, redirigir al listado de revistas
                response.sendRedirect("ListarRevistasServlet");
            }
        } catch (SQLException e) {
            // Si ocurre un error, se envía un mensaje al JSP de error
            e.printStackTrace();
            request.setAttribute("mensajeError", "Error al actualizar la revista: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    // Mantener el método doGet() para posibles redirecciones de consulta GET (opcional)
@Override
protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String idStr = request.getParameter("id");
    int id;
    try {
        if (idStr == null) {
            throw new NumberFormatException("El ID es nulo.");
        }
        id = Integer.parseInt(idStr);

        // Crear instancia de RevistaDAO
        RevistaDAO revistaDAO = new RevistaDAO();

        // Obtener la revista por ID
        Revista revista = revistaDAO.obtenerRevistaPorId(id);

        if (revista != null) {
            // Colocar la revista en el atributo de solicitud
            request.setAttribute("revista", revista);
            // Reenviar al JSP de edición
            request.getRequestDispatcher("editarRevista.jsp").forward(request, response);
        } else {
            // Si no se encuentra la revista, mostrar mensaje de error
            request.setAttribute("mensajeError", "No se encontró la revista con el ID proporcionado.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    } catch (NumberFormatException e) {
        e.printStackTrace();
        request.setAttribute("mensajeError", "ID de revista inválido: " + e.getMessage());
        request.getRequestDispatcher("error.jsp").forward(request, response);
    } catch (SQLException e) {
        e.printStackTrace();
        request.setAttribute("mensajeError", "Error al obtener la revista: " + e.getMessage());
        request.getRequestDispatcher("error.jsp").forward(request, response);
    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("mensajeError", "Error inesperado: " + e.getMessage());
        request.getRequestDispatcher("error.jsp").forward(request, response);
    }
}

    // Modificar el método doPost() para procesar la solicitud de actualización usando processRequest()
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirige a processRequest() para procesar los datos de actualización
        processRequest(request, response);
    }

    // Información del servlet (opcional)
    @Override
    public String getServletInfo() {
        return "Servlet que permite actualizar una revista.";
    }
}