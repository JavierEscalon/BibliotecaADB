package Modelos;

public class Obra extends Material {
    private String tipoObra;
    private String genero;
    private Integer numeroVolumenes;
    private String artistaCompositor;
    private String formato;
    private String dimensiones;

    // Constructor vacío
    public Obra() {
        super();
        this.setTipoMaterialId(5); // Asumiendo que 5 es el ID para obras
    }

    // Getters y Setters
    public String getTipoObra() {
        return tipoObra;
    }

    public void setTipoObra(String tipoObra) {
        this.tipoObra = tipoObra;
    }

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public Integer getNumeroVolumenes() {
        return numeroVolumenes;
    }

    public void setNumeroVolumenes(Integer numeroVolumenes) {
        this.numeroVolumenes = numeroVolumenes;
    }

    public String getArtistaCompositor() {
        return artistaCompositor;
    }

    public void setArtistaCompositor(String artistaCompositor) {
        this.artistaCompositor = artistaCompositor;
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
