<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Modelos.Revista" %>

<!DOCTYPE html>
<html>
<head>
    <title>Editar Revista</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container mt-5">
    <h1 class="text-center mb-4">Editar Revista</h1>
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card">
                <div class="card-body">
                    <%
                        Revista revista = (Revista) request.getAttribute("revista");
                        if (revista != null) {
                    %>
                    <form action="ActualizarRevistaServlet" method="POST">
                        <input type="hidden" name="materialId" value="<%= revista.getMaterialId() %>">
                        
                        <div class="mb-3">
                            <label for="titulo" class="form-label">Título:</label>
                            <input type="text" class="form-control" id="titulo" name="titulo" value="<%= revista.getTitulo() %>" required>
                        </div>

                        <div class="mb-3">
                            <label for="tipoMaterialId" class="form-label">Tipo de Material ID:</label>
                            <input type="number" class="form-control" id="tipoMaterialId" name="tipoMaterialId" value="<%= revista.getTipoMaterialId() %>" required>
                        </div>

                        <div class="mb-3">
                            <label for="editorial" class="form-label">Editorial:</label>
                            <input type="text" class="form-control" id="editorial" name="editorial" value="<%= revista.getEditorial() %>" required>
                        </div>

                        <div class="mb-3">
                            <label for="añoPublicacion" class="form-label">Año de Publicación:</label>
                            <input type="number" class="form-control" id="añoPublicacion" name="añoPublicacion" value="<%= revista.getAñoPublicacion() %>" required>
                        </div>

                        <div class="mb-3">
                            <label for="ubicacionFisica" class="form-label">Ubicación Física:</label>
                            <input type="text" class="form-control" id="ubicacionFisica" name="ubicacionFisica" value="<%= revista.getUbicacionFisica() %>" required>
                        </div>

                        <div class="mb-3">
                            <label for="estado" class="form-label">Estado:</label>
                            <input type="text" class="form-control" id="estado" name="estado" value="<%= revista.getEstado() %>" required>
                        </div>

                        <div class="mb-3">
                            <label for="cantidadTotal" class="form-label">Cantidad Total:</label>
                            <input type="number" class="form-control" id="cantidadTotal" name="cantidadTotal" value="<%= revista.getCantidadTotal() %>" required>
                        </div>

                        <div class="mb-3">
                            <label for="cantidadDisponible" class="form-label">Cantidad Disponible:</label>
                            <input type="number" class="form-control" id="cantidadDisponible" name="cantidadDisponible" value="<%= revista.getCantidadDisponible() %>" required>
                        </div>

                        <div class="mb-3">
                            <label for="descripcion" class="form-label">Descripción:</label>
                            <textarea class="form-control" id="descripcion" name="descripcion" required><%= revista.getDescripcion() %></textarea>
                        </div>

                        <div class="mb-3">
                            <label for="fechaAdquisicion" class="form-label">Fecha de Adquisición:</label>
                            <input type="date" class="form-control" id="fechaAdquisicion" name="fechaAdquisicion" value="<%= revista.getFechaAdquisicion() %>" required>
                        </div>

                        <div class="mb-3">
                            <label for="codigoBarras" class="form-label">Código de Barras:</label>
                            <input type="text" class="form-control" id="codigoBarras" name="codigoBarras" value="<%= revista.getCodigoBarras() %>" required>
                        </div>

                        <div class="mb-3">
                            <label for="idioma" class="form-label">Idioma:</label>
                            <input type="text" class="form-control" id="idioma" name="idioma" value="<%= revista.getIdioma() %>" required>
                        </div>

                        <div class="mb-3">
                            <label for="ISSN" class="form-label">ISSN:</label>
                            <input type="text" class="form-control" id="ISSN" name="ISSN" value="<%= revista.getISSN() %>" required>
                        </div>

                        <div class="mb-3">
                            <label for="volumen" class="form-label">Volumen:</label>
                            <input type="text" class="form-control" id="volumen" name="volumen" value="<%= revista.getVolumen() %>" required>
                        </div>

                        <div class="mb-3">
                            <label for="numero" class="form-label">Número:</label>
                            <input type="text" class="form-control" id="numero" name="numero" value="<%= revista.getNumero() %>" required>
                        </div>

                        <div class="mb-3">
                            <label for="fechaPublicacion" class="form-label">Fecha de Publicación:</label>
                            <input type="date" class="form-control" id="fechaPublicacion" name="fechaPublicacion" value="<%= revista.getFechaPublicacion() %>" required>
                        </div>

                        <div class="mb-3">
                            <label for="periodicidad" class="form-label">Periodicidad:</label>
                            <input type="text" class="form-control" id="periodicidad" name="periodicidad" value="<%= revista.getPeriodicidad() %>" required>
                        </div>

                        <div class="mb-3">
                            <label for="temaPrincipal" class="form-label">Tema Principal:</label>
                            <input type="text" class="form-control" id="temaPrincipal" name="temaPrincipal" value="<%= revista.getTemaPrincipal() %>" required>
                        </div>

                        <button type="submit" class="btn btn-primary">Actualizar Revista</button>
                        <a href="ListarRevistasServlet" class="btn btn-secondary">Cancelar</a>
                    </form>
                    <% } else { %>
                    <p class="text-danger text-center">No se encontró la revista para editar.</p>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
