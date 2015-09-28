package hormastudio.bean;

public class Mensaje {
	
	private String tipo;
	private String texto;
	
	//Tipos de mensajes en bootstrap
	public static final String MSG_SUCCESS = "alert-success";
	public static final String MSG_INFO    = "alert-info";
	public static final String MSG_WARNING = "alert-warning";
	public static final String MSG_DANGER  = "alert-danger";
	
	/**
	 * @param tipo
	 * @param texto
	 */
	public Mensaje(String tipo, String texto) {
		super();
		this.tipo = tipo;
		this.texto = texto;
	}
	
	//Getters y setters
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}
	public String getTexto() {
		return texto;
	}
	public void setTexto(String texto) {
		this.texto = texto;
	}
	
}