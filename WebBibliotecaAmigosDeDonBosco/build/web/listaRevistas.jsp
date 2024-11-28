<%-- 
    Document   : listaRevistas
    Created on : 27 nov 2024, 11:52:55 a. m.
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="Modelos.Revista" %>
<!DOCTYPE html>
<html>
<head>
    <title>Listado de Revistas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container mt-5">
    <h1 class="text-center mb-4">Listado de Revistas</h1>
    <div class="table-responsive">
        <table class="table table-striped table-hover">
            <thead class="table-dark">
                <tr>
                    <th>Título</th>
                    <th>Editorial</th>
                    <th>Año de Publicación</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Revista> listaRevistas = (List<Revista>) request.getAttribute("listaRevistas");
                    if (listaRevistas != null && !listaRevistas.isEmpty()) {
                        for (Revista revista : listaRevistas) {
                %>
                    <tr>
                        <td><%= revista.getTitulo() %></td>
                        <td><%= revista.getEditorial() %></td>
                        <td><%= revista.getAñoPublicacion() %></td>
                        <td>
                            <a href="DetalleRevistaServlet?id=<%= revista.getMaterialId() %>" class="btn btn-info btn-sm">Ver Detalles</a>
                            <a href="ActualizarRevistaServlet?id=<%= revista.getMaterialId() %>" class="btn btn-warning btn-sm">Editar</a>
                            <a href="EliminarRevistaServlet?id=<%= revista.getMaterialId() %>" class="btn btn-danger btn-sm" onclick="return confirm('¿Estás seguro de que deseas eliminar esta revista?');">Eliminar</a>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="4" class="text-center">No se encontraron revistas.</td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>

