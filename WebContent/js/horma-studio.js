/**
 * 
 * Aplicación de dibujo vectorial sobre un canvas
 * A partir de una imágen se podrán dibujar vías de escalada
 * 
 * @author: Unai Perea Cruz
 * @date: 
 * @version: 1.0 Beta
 * 
 */
	  	//Variables para que se pueda interactuar entre los botones y el canvas
	  	
		
		//TODO No se si es paper.project. ....
		
	  	paper.install(window);
	  	console.info('paper.js instalado');
		//Only executed our code once the DOM is ready.
		window.onload = function() {
	
			     console.info('window loaded');	
				//Atributos de hitTest (eventos provocados por el rat�n al clickar sobre un item/Path/Segmento/Stroke
				var hitOptions = null;
				
				//Atributos de los vectores
				var vectorRedondezPunta;
				var cursorColor;					/*** CURSOR ***/
				var hitTestTolerancia;
				var nodoTamano;
			
				//Declaramos variables
				//var capaImagen;
				//var capaVectorial;
				var capaGenerica; //Para cualquier otro objeto que afecte al dibujo
				var capaCursor;					/*** CURSOR ***/
				
				//var contexto;
				
				var segment, path; //variables para saber qu� item y en qu� parte del item se ha clickado
				var moverPath = false; //Controla el movimiento en bloque del item
				var dibujar = false; //Controla si se va a dibujar o no
				var rutaImagen = "http://localhost:8080/HormaStudio/img/Ametzorbe766x1024.jpg";
				
				var circuloReunion; //No s� si es imprescindible
				//var rReunion; //Para si agrupamos el c�rculo con la letra R en el centro 
				//var grupoReunion //circuloReunion y  rReunion agrupados
				
				var rectangulo;
				var esquinaTamano;
				var teclaContorno; 
				var teclaPulsada;
				var grupoTecla; //teclaPulsada y teclaContorno agrupados (Tool Tip Text)
				
				inicializarEntorno();
				inicializarCanvas();
				inicializarCapas(); //Creamos las capas (im�gen, l�neas)
				inicializarDibujoVectorial();
				cargarImagen(rutaImagen);
				inicializarControles();
				inicializarToolTip();
			
				//crearPaths(); //Creamos Paths manualmente
			
				//Modificados desde un control exterior
				//$(#controlvectorColor).onChange(function(){...vectorColor = $(#controlvectorColor).value;...});
				//$(#controlvectorColor).onChange(function(){...vectorGrosor = $(#controlvectorGrosor).value;...});
				

		
	} // End window.onload()
	
		
		
		
		
		
