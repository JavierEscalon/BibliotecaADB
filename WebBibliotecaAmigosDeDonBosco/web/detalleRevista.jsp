<%-- 
    Document   : detalleRevista
    Created on : 27 nov 2024, 11:55:13 a. m.
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<%@ page import="Modelos.Revista" %>

<!DOCTYPE html>
<html>
<head>
    <title>Detalle de la Revista</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container mt-5">
    <h1 class="text-center mb-4">Detalle de la Revista</h1>
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-body">
                    <%
                        Revista revista = (Revista) request.getAttribute("revista");
                        if (revista != null) {
                    %>
                    <h5 class="card-title">Título: <%= revista.getTitulo() %></h5>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item"><strong>Editorial:</strong> <%= revista.getEditorial() %></li>
                        <li class="list-group-item"><strong>Año de Publicación:</strong> <%= revista.getAñoPublicacion() %></li>
                        <li class="list-group-item"><strong>Ubicación Física:</strong> <%= revista.getUbicacionFisica() %></li>
                        <li class="list-group-item"><strong>Estado:</strong> <%= revista.getEstado() %></li>
                        <li class="list-group-item"><strong>Cantidad Total:</strong> <%= revista.getCantidadTotal() %></li>
                        <li class="list-group-item"><strong>Cantidad Disponible:</strong> <%= revista.getCantidadDisponible() %></li>
                        <li class="list-group-item"><strong>Descripción:</strong> <%= revista.getDescripcion() %></li>
                        <li class="list-group-item"><strong>Fecha de Adquisición:</strong> <%= revista.getFechaAdquisicion() %></li>
                        <li class="list-group-item"><strong>Código de Barras:</strong> <%= revista.getCodigoBarras() %></li>
                        <li class="list-group-item"><strong>Idioma:</strong> <%= revista.getIdioma() %></li>
                        <li class="list-group-item"><strong>ISSN:</strong> <%= revista.getISSN() %></li>
                        <li class="list-group-item"><strong>Volumen:</strong> <%= revista.getVolumen() %></li>
                        <li class="list-group-item"><strong>Número:</strong> <%= revista.getNumero() %></li>
                        <li class="list-group-item"><strong>Fecha de Publicación:</strong> <%= revista.getFechaPublicacion() %></li>
                        <li class="list-group-item"><strong>Periodicidad:</strong> <%= revista.getPeriodicidad() %></li>
                        <li class="list-group-item"><strong>Tema Principal:</strong> <%= revista.getTemaPrincipal() %></li>
                    </ul>
                    <div class="mt-4 text-center">
                        <a href="ListarRevistasServlet" class="btn btn-primary">Volver al Listado</a>
                    </div>
                    <% } else { %>
                    <p class="text-danger text-center">No se encontró la revista.</p>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
