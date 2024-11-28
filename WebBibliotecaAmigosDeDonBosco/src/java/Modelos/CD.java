package Modelos;

public class CD extends Material {
    private String formato;
    private String duracion;
    private String contenido;
    private Integer numeroPistas;
    private String requisitosMinimos;

    // Constructor vacío
    public CD() {
        super();
        this.setTipoMaterialId(3); // Asumiendo que 3 es el ID para CD
    }

    // Getters y Setters
    public String getFormato() {
        return formato;
    }

    public void setFormato(String formato) {
        this.formato = formato;
    }

    public String getDuracion() {
        return duracion;
    }

    public void setDuracion(String duracion) {
        this.duracion = duracion;
    }

    public String getContenido() {
        return contenido;
    }

    public void setContenido(String contenido) {
        this.contenido = contenido;
    }

    public Integer getNumeroPistas() {
        return numeroPistas;
    }

    public void setNumeroPistas(Integer numeroPistas) {
        this.numeroPistas = numeroPistas;
    }

    public String getRequisitosMinimos() {
        return requisitosMinimos;
    }

    public void setRequisitosMinimos(String requisitosMinimos) {
        this.requisitosMinimos = requisitosMinimos;
    }
}

