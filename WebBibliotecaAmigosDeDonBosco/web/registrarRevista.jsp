<%-- 
    Document   : registrarRevista
    Created on : 27 nov 2024, 11:48:30 a. m.
    Author     : LENOVO
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Registrar Revista</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container mt-5">
    <h1 class="text-center mb-4">Registrar una Nueva Revista</h1>
    <div class="card">
        <div class="card-body">
            <form action="RegistrarRevistaServlet" method="POST">
                <div class="mb-3">
                    <label for="titulo" class="form-label">Título:</label>
                    <input type="text" class="form-control" id="titulo" name="titulo" required>
                </div>
                <div class="mb-3">
                    <label for="tipoMaterialId" class="form-label">Tipo de Material ID:</label>
                    <input type="number" class="form-control" id="tipoMaterialId" name="tipoMaterialId" required>
                </div>
                <div class="mb-3">
                    <label for="editorial" class="form-label">Editorial:</label>
                    <input type="text" class="form-control" id="editorial" name="editorial" required>
                </div>
                <div class="mb-3">
                    <label for="añoPublicacion" class="form-label">Año de Publicación:</label>
                    <input type="number" class="form-control" id="añoPublicacion" name="añoPublicacion" required>
                </div>
                <div class="mb-3">
                    <label for="ubicacionFisica" class="form-label">Ubicación Física:</label>
                    <input type="text" class="form-control" id="ubicacionFisica" name="ubicacionFisica" required>
                </div>
                <div class="mb-3">
                    <label for="estado" class="form-label">Estado:</label>
                    <input type="text" class="form-control" id="estado" name="estado" value="Disponible" required>
                </div>
                <div class="mb-3">
                    <label for="cantidadTotal" class="form-label">Cantidad Total:</label>
                    <input type="number" class="form-control" id="cantidadTotal" name="cantidadTotal" required>
                </div>
                <div class="mb-3">
                    <label for="cantidadDisponible" class="form-label">Cantidad Disponible:</label>
                    <input type="number" class="form-control" id="cantidadDisponible" name="cantidadDisponible" required>
                </div>
                <div class="mb-3">
                    <label for="descripcion" class="form-label">Descripción:</label>
                    <textarea class="form-control" id="descripcion" name="descripcion" required></textarea>
                </div>
                <div class="mb-3">
                    <label for="fechaAdquisicion" class="form-label">Fecha de Adquisición:</label>
                    <input type="date" class="form-control" id="fechaAdquisicion" name="fechaAdquisicion" required>
                </div>
                <div class="mb-3">
                    <label for="codigoBarras" class="form-label">Código de Barras:</label>
                    <input type="text" class="form-control" id="codigoBarras" name="codigoBarras" required>
                </div>
                <div class="mb-3">
                    <label for="idioma" class="form-label">Idioma:</label>
                    <input type="text" class="form-control" id="idioma" name="idioma" required>
                </div>
                <div class="mb-3">
                    <label for="ISSN" class="form-label">ISSN:</label>
                    <input type="text" class="form-control" id="ISSN" name="ISSN" required>
                </div>
                <div class="mb-3">
                    <label for="volumen" class="form-label">Volumen:</label>
                    <input type="text" class="form-control" id="volumen" name="volumen" required>
                </div>
                <div class="mb-3">
                    <label for="numero" class="form-label">Número:</label>
                    <input type="text" class="form-control" id="numero" name="numero" required>
                </div>
                <div class="mb-3">
                    <label for="fechaPublicacion" class="form-label">Fecha de Publicación:</label>
                    <input type="date" class="form-control" id="fechaPublicacion" name="fechaPublicacion" required>
                </div>
                <div class="mb-3">
                    <label for="periodicidad" class="form-label">Periodicidad:</label>
                    <input type="text" class="form-control" id="periodicidad" name="periodicidad" required>
                </div>
                <div class="mb-3">
                    <label for="temaPrincipal" class="form-label">Tema Principal:</label>
                    <input type="text" class="form-control" id="temaPrincipal" name="temaPrincipal" required>
                </div>
                <button type="submit" class="btn btn-primary">Registrar Revista</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>
