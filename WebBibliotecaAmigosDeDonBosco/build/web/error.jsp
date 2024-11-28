<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Error</title>
    <!-- Incluir Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h1 class="text-danger">Ocurrió un error</h1>
    <p><%= request.getAttribute("mensajeError") %></p>
    <a href="editarRevista.jsp" class="btn btn-primary">Volver al inicio</a>
</div>
</body>
</html>
