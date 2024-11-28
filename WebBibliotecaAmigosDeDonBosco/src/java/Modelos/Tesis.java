package Modelos;

import java.util.Date;

public class Tesis extends Material {
    private String gradoAcademico;
    private String institucion;
    private String director;
    private String areaInvestigacion;
    private Date fechaDefensa;
    private Integer numeroPaginas;

    // Constructor vacío
    public Tesis() {
        super();
        this.setTipoMaterialId(4); // Asumiendo que 4 es el ID para tesis
    }

    // Getters y Setters
    public String getGradoAcademico() {
        return gradoAcademico;
    }

    public void setGradoAcademico(String gradoAcademico) {
        this.gradoAcademico = gradoAcademico;
    }

    public String getInstitucion() {
        return institucion;
    }

    public void setInstitucion(String institucion) {
        this.institucion = institucion;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public String getAreaInvestigacion() {
        return areaInvestigacion;
    }

    public void setAreaInvestigacion(String areaInvestigacion) {
        this.areaInvestigacion = areaInvestigacion;
    }

    public Date getFechaDefensa() {
        return fechaDefensa;
    }

    public void setFechaDefensa(Date fechaDefensa) {
        this.fechaDefensa = fechaDefensa;
    }

    public Integer getNumeroPaginas() {
        return numeroPaginas;
    }

    public void setNumeroPaginas(Integer numeroPaginas) {
        this.numeroPaginas = numeroPaginas;
    }
}
