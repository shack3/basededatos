import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import game.model.Dragon;
import game.model.Hacha;

public class Main {
    // @TODO: Sustituya xxxx por los parámetros de su conexión

    private static final String DB_SERVER = "127.0.0.1";

    private static final int DB_PORT = 3306;

    private static final String DB_NAME = "Dragones_Y_Mazmorras";

    private static final String DB_USER = "root";

    private static final String DB_PASS = "";

    private static Connection conn;



    public static void main(String[] args) throws Exception {

        // @TODO pruebe sus funciones
        System.out.println("Intentando conectarse al servidor...");
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");

            String url = "jdbc:mysql://" + DB_SERVER + ":" + DB_PORT + "/" + DB_NAME;
            conn = DriverManager.getConnection(url, DB_USER, DB_PASS);
        }catch (Exception e){
            System.out.println(e);
        }

        System.out.println("Conexion completada. Inicializando metodos...\n");
        nuevo_dragon("pepito", 232323);
        squad_derrota_dragones(3L);
        mostrar_hachas("Forja del enano risueño");
        espada_porta_guerrero("Makwi");
        conn.close();
    }

    public static void nuevo_dragon(String nombre, int vida){
        // @TODO: complete este método para que cree un nuevo dragón en la base de datos
        System.out.println("---------------Metodo nuevo_dragon("+ nombre + ")---------------\n");

        Dragon nuevoDragon = new Dragon(nombre,vida);
        Statement stmt = null;

        try{
            stmt = conn.createStatement();
            stmt.execute("INSERT INTO " + DB_NAME + ".Dragon" +"(Nombre_dragon, Vida_dragon)"+ " VALUES('" + nuevoDragon.getName() + "', " + nuevoDragon.getLife() +");");
        }
        catch (Exception ex){
            System.out.println("SQLException: " + ex.getMessage());
        }

        System.out.println("Nuevo dragon añadido a la tabla ´Dragon´!\n");
    }

    public static List<Dragon> squad_derrota_dragones(Long id_squad){

        List<Dragon> lista = new ArrayList<>();

        System.out.println("---------------Metodo squad_derrota_dragones("+ id_squad + ")---------------\n");


        Statement stmt = null;
        ResultSet res = null;
        try{
            stmt = conn.createStatement();
            stmt.executeQuery("SELECT Nombre_dragon, Vida_dragon FROM(SELECT Cod_mision, Mision_escuadron.Num_dragon, Dragon.Nombre_dragon, Dragon.Vida_dragon FROM Mision_escuadron LEFT JOIN Dragon ON Dragon.Num_dragon=Mision_escuadron.Num_dragon) AS A\n" +
                    "\t\t\tRIGHT JOIN Participa_escuadron ON A.Cod_mision= Participa_escuadron.Participa_Cod_mision\n" +
                    "            WHERE Participa_Cod_escuadron="+id_squad+ ";");
            res = stmt.getResultSet();

            while(res.next()){
                lista.add(new Dragon(res.getString(1), Integer.parseInt(res.getString(2))));
            }

        }
        catch (Exception ex){
            System.out.println("SQLException: " + ex.getMessage());
        }

        for(int i=0; i<lista.size(); i++)
            System.out.println( lista.get(i).getName() +", " +lista.get(i).getLife());

        return lista;
    }

    public static List<Hacha> mostrar_hachas(String nombre_forja){
        // @TODO: complete este método para que muestre por pantalla las hachas que pueden forjarse en "nombre_forja"
        // Tenga en cuenta que la consulta a la base de datos le devolverá un ResultSet sobre el que deberá
        // ir iterando y creando un objeto con cada hacha disponible en esa forja, y añadirlos a la lista

        List<Hacha> lista = new ArrayList<>();

        System.out.println("---------------Metodo mostrar_hachas("+ nombre_forja + ")---------------\n");

        Statement stmt = null;
        ResultSet res = null;

        try{
            stmt = conn.createStatement();
            stmt.executeQuery("SELECT Nombre_personaje, Peso, Nombre " +
                    "FROM Forja LEFT JOIN Arma ON Forja.Arma_dispon = Arma.Tipo_arma " +
                    "WHERE Nombre_forja='" + nombre_forja + "' " +
                    "AND Arma_dispon='HACHA';");
            res = stmt.getResultSet();
            while(res.next()){
                lista.add(new Hacha(res.getString(1),
                        Integer.parseInt(res.getString(2)),
                        res.getString(3)));
            }

        }catch (Exception ex){
            System.out.println("SQLException: " + ex.getMessage());
        }

        for(int i=0; i<lista.size(); i++)
            System.out.println( lista.get(i).getNombre() +", " +lista.get(i).getNombre_personaje() + ", " + lista.get(i).getPeso());

        return lista;
    }

    public static String espada_porta_guerrero(String nombre_guerrero){
        // @TODO: complete este método para que devuelva el nombre de la espada que porta el guerrero "nombre_guerrero"

        System.out.println("---------------Metodo espada_porta_guerrero("+ nombre_guerrero + ")---------------\n");

        String resultado = "No encontrado";
        Statement stmt = null;
        ResultSet res = null;

        try {
            stmt = conn.createStatement();
            stmt.executeQuery("SELECT Nombre FROM Arma WHERE Nombre_personaje = '" + nombre_guerrero + "' AND Tipo_arma = 'ESPADA';");
            res = stmt.getResultSet();
            res.next();
            resultado = res.getString(1);
        }catch (Exception ex){
            System.out.println("SQLException: " + ex.getMessage());
        }
        System.out.println(resultado);
        return resultado;
    }

}
