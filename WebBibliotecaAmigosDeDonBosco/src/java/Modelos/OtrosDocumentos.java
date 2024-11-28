package Modelos;

public class OtrosDocumentos extends Material {
    private String tipoDocumento;
    private String organizacionEntidad;
    private String numeroSerie;
    private String formato;
    private String dimensiones;
    private String requisitosEspeciales;

    // Constructor vacío
    public OtrosDocumentos() {
        super();
        this.setTipoMaterialId(6); // Asumiendo que 6 es el ID para otros documentos
    }

    // Getters y Setters
    public String getTipoDocumento() {
        return tipoDocumento;
    }

    public void setTipoDocumento(String tipoDocumento) {
        this.tipoDocumento = tipoDocumento;
    }

    public String getOrganizacionEntidad() {
        return organizacionEntidad;
    }

    public void setOrganizacionEntidad(String organizacionEntidad) {
        this.organizacionEntidad = organizacionEntidad;
    }

    public String getNumeroSerie() {
        return numeroSerie;
    }

    public void setNumeroSerie(String numeroSerie) {
        this.numeroSerie = numeroSerie;
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

    public String getRequisitosEspeciales() {
        return requisitosEspeciales;
    }

    public void setRequisitosEspeciales(String requisitosEspeciales) {
        this.requisitosEspeciales = requisitosEspeciales;
    }
}
