package game.model;

public class Hacha {

    private String nombre_personaje;
    private int peso;
    private String nombre;

    public Hacha(String nombre_personaje, int peso, String nombre){
        this.nombre_personaje = nombre_personaje;
        this.peso = peso;
        this.nombre = nombre;
    }


    public String getNombre_personaje() {
        return nombre_personaje;
    }

    public void setNombre_personaje(String nombre_personaje) {
        this.nombre_personaje = nombre_personaje;
    }

    public int getPeso() {
        return peso;
    }

    public void setPeso(int peso) {
        this.peso = peso;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
}
