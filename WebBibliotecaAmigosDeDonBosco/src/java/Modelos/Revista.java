package Modelos;


import java.util.Date;

public class Revista extends Material {
    private String ISSN;
    private String volumen;
    private String numero;
    private Date fechaPublicacion;
    private String periodicidad;
    private String temaPrincipal;

    // Constructor vacío
    public Revista() {
        super(); // Llama al constructor de la clase padre Material
        this.setTipoMaterialId(2); // Asumiendo que 2 es el ID para revistas
    }

    // Getters y Setters
    public String getISSN() {
        return ISSN;
    }

    public void setISSN(String ISSN) {
        this.ISSN = ISSN;
    }

    public String getVolumen() {
        return volumen;
    }

    public void setVolumen(String volumen) {
        this.volumen = volumen;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public Date getFechaPublicacion() {
        return fechaPublicacion;
    }

    public void setFechaPublicacion(Date fechaPublicacion) {
        this.fechaPublicacion = fechaPublicacion;
    }

    public String getPeriodicidad() {
        return periodicidad;
    }

    public void setPeriodicidad(String periodicidad) {
        this.periodicidad = periodicidad;
    }

    public String getTemaPrincipal() {
        return temaPrincipal;
    }

    public void setTemaPrincipal(String temaPrincipal) {
        this.temaPrincipal = temaPrincipal;
    }
}
