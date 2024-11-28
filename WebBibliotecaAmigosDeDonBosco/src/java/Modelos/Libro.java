package Modelos;

public class Libro extends Material {
    private String ISBN;
    private String numeroEdicion;
    private Integer numeroPaginas;
    private String formato;
    private String dimensiones;

    // Constructor vacío
    public Libro() {
        super();
        this.setTipoMaterialId(1); // Asumiendo que 1 es el ID para Libro
    }

    // Getters y Setters

    public String getISBN() {
        return ISBN;
    }

    public void setISBN(String ISBN) {
        this.ISBN = ISBN;
    }

    public String getNumeroEdicion() {
        return numeroEdicion;
    }

    public void setNumeroEdicion(String numeroEdicion) {
        this.numeroEdicion = numeroEdicion;
    }

    public Integer getNumeroPaginas() {
        return numeroPaginas;
    }

    public void setNumeroPaginas(Integer numeroPaginas) {
        this.numeroPaginas = numeroPaginas;
    }

    public String getFormato() {
        return formato;
    }

    public void setFormato(String formato) {
        this.formato = formato;
    }

    public String getDimensiones() {
        return dimensiones;
    }

    public void setDimensiones(String dimensiones) {
        this.dimensiones = dimensiones;
    }
}
