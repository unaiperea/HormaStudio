package hormastudio.controladores;

import hormastudio.Constantes;
import hormastudio.bean.Mensaje;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadBase.FileSizeLimitExceededException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 * Servlet implementation class ImagenController
 */
public class ImagenController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	RequestDispatcher dispatcher = null;
	
	//Imágen file
	File file = null;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ImagenController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Mensaje msg = new Mensaje(Mensaje.MSG_DANGER,  "Excepción al modificar");
		
		try{
		//recoger parámetros del formulario y subida de imágen
		getParametersForm(request);
		
		request.setAttribute("msg", msg);
		
		}catch( FileSizeLimitExceededException e){		
			e.printStackTrace();
			msg = new Mensaje( Mensaje.MSG_DANGER , "La imágen excede del tamaño máximo permitido " + Constantes.IMG_MAX_FILE_SIZE + " bytes" );
			request.setAttribute("msg", msg);	
		}catch(Exception e){
			e.printStackTrace();
			msg = new Mensaje( Mensaje.MSG_DANGER , e.getMessage() );
			request.setAttribute("msg", msg);
		}	
		
		dispatcher.forward(request, response);
	}

	/**
	* Recoger los parametros enviados desde el formulario
	* @see backoffice\pages\sectores\form.jsp
	* @param request
	 * @throws UnsupportedEncodingException 
	*/
	private void getParametersForm(HttpServletRequest request) throws Exception {

			request.setCharacterEncoding("UTF-8");
			
			DiskFileItemFactory factory = new DiskFileItemFactory(); //Factorï¿½a para trabajar con ficheros
		    // maximum size that will be stored in memory
			//TODO Cambiar este valor para que falle
		    factory.setSizeThreshold(Constantes.IMG_MAX_MEM_SIZE); //Memoria para trabajar con ficheros. 
		    // Location to save data that is larger than maxMemSize.
		    //TODO Comprobar si no existe carpeta
		    factory.setRepository(new File(Constantes.IMG_UPLOAD_TEMP_FOLDER)); //Directorio temporal del propio Tomcat para guardarlo ahï¿½
			
		    // Create a new file upload handler
		    ServletFileUpload upload = new ServletFileUpload(factory); //Objeto para la gestiï¿½n de estos datos
		    // maximum file size to be uploaded.
		    //TODO Cambiar valor no dejar subir mï¿½s de 1MB
		    upload.setSizeMax(Constantes.IMG_MAX_FILE_SIZE);
		    
		    //Parï¿½metros de la request del formulario, No la imï¿½gen. Creamos un array de dos dimensiones para guardar todos los items de la pï¿½gina con la key su valor 
		    HashMap<String, String> dataParameters = new HashMap<String, String>();
		    
		    // Parse the request to get file items.
		    List<FileItem> items = upload.parseRequest(request); //Todo lo que se ha subido se parsea. Imï¿½genes y parï¿½metros que se han subido
		    // Process the uploaded file items
		    for(FileItem item : items){ //Recorro  todos los items de la pï¿½gina form.jsp para buscar la imï¿½gen
		    
		    	//Parï¿½metro formulario
		    	if(item.isFormField()){ //CampoDeFormulario se refiere a los parï¿½metros. Los metemos al HashMap
		    		//Nombre del item y valor del item, usï¿½ase key y value
		    		dataParameters.put(item.getFieldName(), item.getString("UTF-8") ); //UTF-8 para solucionar al cojer los string con acentos
		    	
		    	//Si no es campoDeFormulario, usï¿½ase imï¿½gen
		    	}else{
			    	//Atributos de la imï¿½gen
		            String fileName = item.getName();
		            if (!"".equals(fileName)){ //Si está vacío subo la imágen. Que no modifique la imágen cuando está
			            String fileContentType = item.getContentType();
			            if (Constantes.IMG_CONTENT_TYPES.contains(fileContentType)){ //Si contiene los tipos de archivo jpg o png
				            boolean isInMemory = item.isInMemory();
				            long sizeInBytes = item.getSize();
				            
				            //comprobar 'size' y 'contentType' (tipo de extensión)

				            //No repetir nombre imágenes
			            	File carpetaUploads = new File(Constantes.IMG_UPLOAD_FOLDER);
			            	if (carpetaUploads.exists()){
				                File[] ficherosUploads = carpetaUploads.listFiles();
				                
				                //Recorro los ficheros y compruebo su nombre por si es igual que el nombre del fichero a subir
				                for (int i=0; i<ficherosUploads.length; i++ ){
				                	if (ficherosUploads[i].isFile()){
				                		//Si el nombre es igual
				                		if (item.getName().equalsIgnoreCase(ficherosUploads[i].getName())){
				                			//Añadimos la fecha
				                			Date fecha = new Date();
				                			SimpleDateFormat formato = new SimpleDateFormat ("yyyy.MM.dd hh:mm:ss");
				                			
				                			int indicePunto = fileName.indexOf(".");
				                			if (indicePunto != -1);
				                				String nombre = fileName.substring(0, indicePunto);
				                				String extension = fileName.substring(indicePunto + 1);
				                				fileName =  nombre + "_" + formato.format(fecha).toString().replace(" ", "-").replace(":", "_") + "." + extension;
				                			break;
				                			
				                			
				                		}
				                	}
				                } //End for: ficherosUploads
				                
				                file = new File(Constantes.IMG_UPLOAD_FOLDER + "\\" + fileName);
						        item.write( file );
						        
			            	} //End: exists()
			            }else{
			            	throw new Exception("[" + fileContentType + "] Extensiï¿½n de imï¿½gen no permitida");
			            } //End: fileContentType
		            }else{
		            	file = null;
		            }//End: fileName vacï¿½o
			    
		    	} //End: fileName
		    } //End: for items<FileItem>
	            
		    //Se comprueba el tamaï¿½o del fichero desde el form.jsp en javascript
		    
		    //Cojo los parï¿½metros pero del propio HashMap dataParameters
		    /*pID = Integer.parseInt(dataParameters.get("id"));
			pNombre = dataParameters.get("nombre");	
			pIDZona = Integer.parseInt(dataParameters.get("zona"));*/
	            
	        //TODO actualizar modelo
	}
	
}
