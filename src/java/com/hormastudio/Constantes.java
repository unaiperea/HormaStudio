package com.hormastudio;

import java.util.ArrayList;
import java.util.Arrays;

public class Constantes {

	public static final String SERVER = "http://localhost:8080";
	public static final String ROOT_APP = "/HormaStudio/";
	public static final String APP_NAME = "HormaStudio";
	
	//Vistas públicas
	public static final String VIEW_BACK_HORMA = "index.jsp";
	
	//Controladores
	public static final String CONTROLLER_HORMASTUDIO_IMAGEN = ROOT_APP + "imagen";
	
	//Imágen
	public static final String IMG_UPLOAD_FOLDER      = "C:\\Home\\apache-tomcat-6.0.44\\webapps\\uploads";
	public static final String IMG_UPLOAD_TEMP_FOLDER = "C:\\Home\\apache-tomcat-6.0.44\\temp";
	//public static final String IMG_WEB_PATH           = "http://localhost:8080/uploads/";
	public static final int IMG_MAX_FILE_SIZE = 1000 * 1024;
	public static final int IMG_MAX_MEM_SIZE  = 40 * 1024;
	public static final ArrayList<String> IMG_CONTENT_TYPES = new ArrayList<String>(Arrays.asList("image/jpeg","image/png")); //Para inicializarlo. Por ser constante no se podría añadir elementos con .add();
	
	//Acciones
	public static final byte ACCION_SUBIR_IMAGEN = 1;
	
}
