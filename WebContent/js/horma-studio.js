/**
 * 
 * Aplicación de dibujo vectorial sobre un canvas
 * A partir de una imágen es posible dibujar vías de escalada
 * 
 * @author: Unai Perea Cruz
 * @date: 
 * @version: 1.0 Beta
 * 
 */

  	//Variables para que se pueda interactuar entre los botones y el canvas
  	var canvas; //Para getMousePos(); sino meterlo dentro de onload
  	var contexto;
	var imagenRaster;
	var nombreKrokis;
	
	//controles de ....
	var controlPincel;
	var controlReunion;
	var controlBorrar;
	var controlMover;
	
	var reunionColor;
	var reunionRadio;
	var vectorColor;
	var vectorGrosor;
	
	var cursorTamanoPincel;
	var etiquetaGrosor;
	var posicionRaton;
	
	var upperZoomLimit;
    var lowerZoomLimit;
    //var porcentajeZoom;
    var originalZoom;
    var originalCentro;
    var originalMoveFactor;
    var ratioZoomFactor;
    var diferenciaZoom;
    var etiquetaZoom;
    
    var controlImagen; //input type=file
    var hayImagen = false; //Para poder pintar sobre la imagen
    
    var capaImagen;
	var capaVectorial;
	
  	paper.install(window);
  	console.info('paper.js instalado');
  	
	//Only executed our code once the DOM is ready.
	window.onload = function() {

		/* ININICIALIZARLOS EN UN METODO CADA UNO ???? ****************/
		
		/**
		 * GROSOR: input type=range
		 */
		var sliderGrosor = document.querySelector('#control_grosor');
		if (sliderGrosor) {
		  etiquetaGrosor = document.querySelector('#etiqueta-grosor');
		  if (etiquetaGrosor) {
			  etiquetaGrosor.innerHTML = "Tamaño pincel: " + sliderGrosor.value;

		    sliderGrosor.addEventListener('input', function() {
		    	etiquetaGrosor.innerHTML = "Tamaño pincel: " + sliderGrosor.value;
		    }, false);
		  }
		}
		
		/**
		 * zoom: input type=range
		 */
		/*sliderZoom = new Slider("#control_zoom", {
			reversed : true,
		});*/
		var sliderZoom = document.querySelector('#control_zoom');
		if (sliderZoom) {
		  etiquetaZoom = document.querySelector('#etiqueta-zoom');
		  if (etiquetaZoom) {
			  etiquetaZoom.innerHTML = "Zoom: " + sliderZoom.value;

		    sliderZoom.addEventListener('input', function() {
		    	if (hayImagen){
		    		etiquetaZoom.innerHTML = "Zoom: " + sliderZoom.value;
		    	}
		    }, false);
		  }
		}
		
		/**
		 * input type=color - Spectrum Color Picker
		 */
		$("#control-color").spectrum({
		    showPaletteOnly: true,
		    togglePaletteOnly: true,
		    togglePaletteMoreText: 'más',
		    togglePaletteLessText: 'menos',
		    chooseText: "Ok",
		    cancelText: "Cancelar",
		    color: "#ff0000",
		    palette: [
		        ["#000","#444","#666","#999","#ccc","#eee","#f3f3f3","#fff"],
		        ["#f00","#f90","#ff0","#0f0","#0ff","#00f","#90f","#f0f"],
		        ["#f4cccc","#fce5cd","#fff2cc","#d9ead3","#d0e0e3","#cfe2f3","#d9d2e9","#ead1dc"],
		        ["#ea9999","#f9cb9c","#ffe599","#b6d7a8","#a2c4c9","#9fc5e8","#b4a7d6","#d5a6bd"],
		        ["#e06666","#f6b26b","#ffd966","#93c47d","#76a5af","#6fa8dc","#8e7cc3","#c27ba0"],
		        ["#c00","#e69138","#f1c232","#6aa84f","#45818e","#3d85c6","#674ea7","#a64d79"],
		        ["#900","#b45f06","#bf9000","#38761d","#134f5c","#0b5394","#351c75","#741b47"],
		        ["#600","#783f04","#7f6000","#274e13","#0c343d","#073763","#20124d","#4c1130"]
		    ]
		});
		
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
		var rutaImagen = "http://localhost:8080/HormaStudio/img/krokis.png";
		
		//var circuloReunion; //No s� si es imprescindible
		//var rReunion; //Para si agrupamos el c�rculo con la letra R en el centro 
		var grupoReunion //circuloReunion y  numeroReunion agrupados
		
		var rectangulo;
		var esquinaTamano;
		var teclaContorno; 
		var teclaPulsada;
		var grupoTecla; //teclaPulsada y teclaContorno agrupados (Tool Tip Text)
		
		inicializarEntorno();
		inicializarCanvas();
		inicializarCapas(); //Creamos las capas (imagen, lineas)
		inicializarDibujoVectorial();
		cargarImagenInicial(rutaImagen);
		inicializarControles();
		inicializarToolTip();
	
		//crearPaths(); //Creamos Paths manualmente
	
		//Modificados desde un control exterior
		//$(#controlvectorColor).onChange(function(){...vectorColor = $(#controlvectorColor).value;...});
		//$(#controlvectorColor).onChange(function(){...vectorGrosor = $(#controlvectorGrosor).value;...});
	
		/**
		* Funciones propias del canvas utilizando la librería paper.js
		*/
		function inicializarEntorno(){
			//document.body.style.cursor = 'none'; //el cursor desaparece
			console.warn('inicializarEntorno: No hacemos nada');
			
			controlImagen = document.getElementById('control_imagen');
			controlImagen.addEventListener('change', loadImagen, false);
			document.getElementById("nombre-krokis").innerHTML = "[Sin im&aacutegen]";
		}
		
		function inicializarCanvas(){
			console.info('inicializarCanvas: entramos');
			//Inicializar
			canvas = document.getElementById('canvas_croquis');//$('#canvas_croquis')[0]; //Obtenemos el id de la etiqueta canvas
			paper.setup('canvas_croquis'); //Crea una clase intermedia para poder utilizar el lenguaje javascript en vez de paperscript
		    tool = new paper.Tool(); //Crea una herramienta para manejar los eventos del teclado y rat�n. Machaco la var tool ya existente
		    
		    //TODO Zoom
		    paper.tool.distanceThreshold = 8;
		    paper.tool.mouseStartPos = new paper.Point();
		    paper.tool.zoomFactor = 1.3;
		    lowerZoomLimit = 0;
		    upperZoomLimit = 10;
		    diferenciaZoom = document.getElementById("control_zoom").value;
		    
		    //Creamos un contexto contra la etiqueta canvas
			contexto = canvas.getContext('2d');
			//contexto.fillStyle = "#424242"; //Color de fondo del canvas -- NO FUNCIONA
			
			//project.currentStyle = {
			//		strokeColor: 'black',
			//		strokeWidth: 4,
			//		strokeCap: 'round'
			//	};
			project.strokeCap = 'round'; //COMPROBAAAAR *****
			contexto.lineCap = "round"; //COMPROBAAAAR *****
			contexto.lineJoin = "round"; //COMPROBAAAAR *****
			//project.fillStyle = "#424242";
			console.info('inicializarCanvas:salimos');
		}
		
		function inicializarCapas(){
			capaImagen = new paper.Layer();
			capaImagen.name = "capa de imagen";
			capaGenerica = new paper.Layer();
			capaGenerica.name = "capa generica";
			capaCursor = new paper.Layer();					/*** CURSOR ***/
			capaCursor.name= "capa del cursor";
			capaVectorial = new paper.Layer();
			capaVectorial.name = "capa de lineas";
		}

		function inicializarDibujoVectorial(){
			vectorColor         = "#0000ff";
			$("#control-color").spectrum("set", vectorColor);
			//inicializarColorPicker(vectorColor);
			//$("#control-color").spectrum({color: 'blue'});
			vectorGrosor        = 6;
			vectorRedondezPunta = 'round';
			nodoTamano          = vectorGrosor*2;
			
			reunionRadio        = 20;//8;
			reunionColor        = '#ff0000';
			document.getElementById("control-color").value = reunionColor;
			
			cursorColor         = 'black';					/*** CURSOR ***/
			hitTestTolerancia   = 2;
			
			//Tamaño de todos los nodos
			paper.settings.handleSize = nodoTamano;
			
			//Creamos el objeto cursor
			capaCursor.activate();
			cursorTamanoPincel = new paper.Path.Circle ({
				center: [0, 0],
				radius: vectorGrosor/2,
				strokeColor: cursorColor,					/*** CURSOR ***/
				name: 'cursor'});
			cursorTamanoPincel.visible = false;
			capaVectorial.activate();
		}
		
		//Creamos Paths manualmente
		//function crarPaths(){
			//path.add(new Point(40, 100));
			//path.add(new Point(150, 10));
			//path.add(new Point(370, 350));
			//path.add(new Point(450, 300));
		//}

		
		/**
		*  Cargamos la imagen/raster en la capa capaImagen
		*/
		function cargarImagenInicial(rutaImagen){ 
			//Activamos la capa de la im�gen y la cargamos
			capaImagen.activate();
			
			contexto.clearRect(0, 0, canvas.width, canvas.height); //Borro todo lo que haya en nuestro lienzo
			hayImagen = false;
			
			/*var puntoInsercion = new paper.Point(paper.view.center);
			imagenRaster = new paper.Raster({
		  		source: rutaImagen,
		  		//position: view.center,
				selected: false}, puntoInsercion);*/
			imagenRaster = new paper.Raster({
		  		source: rutaImagen,
				selected: false});
			hayImagen = false;
			
			//Centra la imagen
			var MAX_WIDTH = $('#canvas_croquis').width();//$('#entorno').width(); //Anchura del div
			var MAX_HEIGHT = $('#canvas_croquis').height();//$('#entorno').height(); //Altura del div
			var puntoCentroImagen = new paper.Point(MAX_WIDTH / 2, MAX_HEIGHT / 2);
			imagenRaster.position = paper.view.viewToProject(puntoCentroImagen);
			
			capaVectorial.activate(); //Activa la capa de los vectores y lista para dibujar
		}
		
		function inicializarControles(){
			controlPincel = true;
			controlReunion = false;
			controlBorrar = false;
			
			//ColorPicker
			document.getElementById("control-color").value = "#0000FF";
			
			//Tamaño pincel
			document.getElementById("control_grosor").value = vectorGrosor;
			document.getElementById("etiqueta-grosor").innerHTML = "Tamaño pincel: " + vectorGrosor;
			
			//Rellenamos la Select de las reuniones
			var opcion;
			for (i=1; i < 100; i++){
				opcion = document.createElement("option");
			    opcion.text = i;
			    document.getElementById("funcion-numero-reunion").add(opcion);
			}
			document.getElementById("funcion-numero-reunion").selectedIndex = 0;
			//Zoom
			//document.getElementById("control_zoom").value = lowerZoomLimit;
			//document.getElementById("zoom_texto").value = lowerZoomLimit;
			//$("#control_zoom")[0].min = lowerZoomLimit;
	        //$("#control_zoom")[0].max = upperZoomLimit;
			//Opciones HitTest
			hitOptions = {
					segments: true, //para clickar en los nodos
					stroke: true, //para clickar en las l�neas
					fill: true, //para clickar en las reuniones
					tolerance: hitTestTolerancia
					};
			circuloReunion = new paper.Path.Circle({
				center: [80, 50],//event.point,
				radius: reunionRadio,
				strokeColor: reunionColor,
				name: "circulo-reunion"
				});
			
			numeroReunion = new paper.PointText({
			    position: [circuloReunion.position.x - (reunionRadio/2), circuloReunion.position.y + (reunionRadio/2)],//circuloReunion.position,
			    content: 99,//document.getElementById("funcion-numero-reunion").value,
			    strokeColor: reunionColor,
			    fillColor: reunionColor,
			    fontFamily: 'Arial',
			    fontWeight: 'bold',
			    fontSize: 20,
			    name: "numero-reunion"
			});
			
			grupoReunion = new paper.Group({
				children: [circuloReunion, numeroReunion],
				name:"reunion",
				visible: true
			});
		}
		
		function inicializarToolTip(){
			//TODO letra R rReunion y name: erre
			//this.position + new point ...
			
			capaGenerica.activate();
		
			rectangulo = new paper.Rectangle(new Point(100, 100), new Size(30, 15));
			esquinaTamano = new Size(5, 5);
			teclaContorno = new paper.Path.RoundRectangle(rectangulo, esquinaTamano);
			teclaContorno.fillColor = 'white';
			teclaContorno.strokeColor = 'black';
			teclaContorno.name = "contornotooltip";
			
			teclaPulsada = new paper.PointText({
			    position: [rectangulo.x + (rectangulo.width/7), rectangulo.y + (rectangulo.height/1.5)],
			    content: 'null',
			    fillColor: 'black',
			    fontFamily: 'Arial',
			    fontWeight: 'bold',
			    fontSize: 10,
			    name: "textotooltip"
			});
			
			grupoTecla = new paper.Group({
				children: [teclaContorno, teclaPulsada],
				name: "tooltiptext",
				visible: false
			});
			capaVectorial.activate();
			
			//acceder a children reunion.children[0].point
			//acceder a children reunion.children[1].point
			//circuloReunion.position = path.getPointAt(0,0); //posici�n inicial. NO creo
		}
	
		/**
		*  Cuando pulse el bot�n del rat�n se obtendr� el item que est� debajo y ...
		*  1.- si no ha pulsado ning�n item que no haga nada
		*  2.- si se ha pulsado en cualquier lado del Path con la tecla CTRL pulsada lo mueve en bloque
		*  3.- si se ha pulsado en un nodo con la tecla SHIFT pulsada borra dicho nodo
		*  4.- si se ha pulsado en un segmento/nodo del path preparado para mover el segmento
		*  5.- si se ha pulsado en la l�nea del path inserta un nodo preparado para mover
		*/
		tool.onMouseDown = function(event){
			//switch (event.event.button) {
				// leftclick
			//	case 0:
			//		alert('Left mouse button pressed');
			//		break;
				// rightclick
			//	case 2:
			//		alert('Right mouse button pressed');
			//		break;
			//}
			console.debug("Ha entrado en onMouseDown");

			//Controlamos para que cuando pulsemos CTRL y SHIFT aparezca un tooltiptext al lado del cursor
			tool.onKeyDown = function(e){
				if (e.key == 'control' && !controlBorrar){
					 //Colocamos el tooltiptext al lado del cursor
					if (project.activeLayer != capaGenerica){capaGenerica.activate();}
					grupoTecla.position.x = event.point.x + 18;
					grupoTecla.position.y = event.point.y + 10;
					if (!grupoTecla.visible){
						teclaPulsada.content = "Ctrl"; // que escriba Ctrl
						grupoTecla.visible = true;
					}
					if (project.activeLayer != capaVectorial){capaVectorial.activate();}
				}else if (e.key == 'shift' && !controlBorrar && !controlReunion){
					 //Colocamos el tooltiptext al lado del cursor
					if (project.activeLayer != capaGenerica){capaGenerica.activate();}
					grupoTecla.position.x = event.point.x + 18;
					grupoTecla.position.y = event.point.y + 10;
					if (!grupoTecla.visible){
						teclaPulsada.content = "Shift"; // que escriba Shift
						grupoTecla.visible = true;
					}
					if (project.activeLayer != capaVectorial){capaVectorial.activate();}
				}
			}
			
			tool.onKeyUp = function(e){
				if (e.key == 'control' || e.key == 'shift'){
					if (project.activeLayer != capaGenerica){capaGenerica.activate();}
					if (grupoTecla.visible){
						grupoTecla.visible = false;
						teclaPulsada.content = "null";
					}
					if (project.activeLayer != capaVectorial){capaVectorial.activate();}
				}
			}
			
			segment = path = null;
			
			/*if (controlReunion){
				console.info("controlReunion = true");
				circuloReunion = new paper.Path.Circle({
					center: event.point,
					radius: reunionRadio,
					fillColor: reunionColor
					});
				
				/*
				//TODO letra R rReunion y name: erre
				grupoReunion = new paper.Group();
				reunion.addChild(circuloReunion);
				reunion.addChild(rReunion);
				
				//acceder a children reunion.children[0].point
				//acceder a children reunion.children[1].point
				//circuloReunion.position = path.getPointAt(0,0); //posici�n inicial. NO creo
				*/
				
			/*} else{*/
			//Obtenemos d�nde se ha pulsado el rat�n
			var hitResult = project.hitTest(event.point, hitOptions);
			if (hitResult != null){
				var hitClaseItem = hitResult.item.className; //Otra forma m�s fiable de saber qu� item hemos clickado
				var hitNombreItem = hitResult.item.name; //Otra forma para evitar que clicke el tooltiptext
				
				console.info(hitResult.item.name);
			}else{ //Si no ha pinchado nada, useas�, controlMover = true
				return;
			}
			
			//EN MODO DEBUG CON EL CHROME NO ENTRAN LOS MODIFICADORES CONTROL NI SHIFT
			//Si pulsamos CTRL o SHIFT + Click rat�n ...
			if (event.modifiers.control && controlPincel && hitNombreItem != "cursor"){ // && hitNombreItem != "cursor"					/*** CURSOR ***/
				//Si se ha pulsado CTRL + CLICK que lo prepare para moverse. Controla si clicka sobre alguno de los elementos del tooltiptext que no lo modifique  
				//if ( hitResult && hitClaseItem != "Raster" && hitNombreItem != "tooltiptext" && hitNombreItem != "textotooltip" && hitNombreItem != "contornotooltip" && (controlReunion || controlPincel)) {
				if (hitResult && hitNombreItem == "vector"){
					moverPath = true;
					path = hitResult.item;
					//project.activeLayer.addChild(hitResult.item); //no s� si hay que incluirlo luego
				}
			}else if (event.modifiers.control && controlReunion && hitNombreItem != "cursor"){ // && hitNombreItem != "cursor"					/*** CURSOR ***/
				//Si se ha pulsado CTRL + CLICK que lo prepare para moverse. Controla si clicka sobre alguno de los elementos del tooltiptext que no lo modifique  
				//if ( hitResult && hitClaseItem != "Raster" && hitNombreItem != "tooltiptext" && hitNombreItem != "textotooltip" && hitNombreItem != "contornotooltip" && (controlReunion || controlPincel)) {
				if (hitResult && hitNombreItem == "reunion"){
					moverPath = true;
					path = hitResult.item;
					//project.activeLayer.addChild(hitResult.item); //no s� si hay que incluirlo luego
				}
			}else if (event.modifiers.shift && controlPincel) {
				//pulsando SHIFT + CLICK en el segmento/nodo borra el nodo     			// && hitNombreItem != "cursor"					/*** CURSOR ***/
				if ( hitResult && hitClaseItem != "Raster" && !hitResult.item.hasFill() && hitNombreItem != "cursor" && !controlReunion && !controlBorrar) { //Si hemos hecho click sobre algo y que no sea la im�gen y si ha sido en una reunion que no la modifique
					if (hitResult.type == 'segment') {
						hitResult.segment.remove();
					}
				}
			}else if (controlReunion && hayImagen){ //Si se ha pulsado el bot�n de Reuni�n que cree una nueva reuni�n al clickar sobre el canvas
				console.info("controlReunion = true");
				//Si donde hace click esta dentro de los limites de la imagen
				if (imagenRaster.bounds.contains(event.point)){
					if (project.activeLayer != capaVectorial){
						capaVectorial.activate();
					}
					
					//TODO 

					//Grupo Reunion
					circuloReunion = new paper.Path.Circle({
						center: event.point,
						radius: reunionRadio,
						//fillColor: reunionColor,
						name: "circulo-reunion"
						});
					
					numeroReunion = new paper.PointText({
					    position: [circuloReunion.position],
					    content: document.getElementById("funcion-numero-reunion").value,
					    fillColor: reunionColor,
					    fontFamily: 'Arial',
					    fontWeight: 'bold',
					    fontSize: 10,
					    name: "numero-reunion"
					});
					
					grupoReunion = new paper.Group({
						children: [circuloReunion, numeroReunion],
						name:"reunion",
						visible: true
					});
					
					/*circuloReunion = new paper.Path.Circle({
						center: event.point,
						radius: reunionRadio,
						fillColor: reunionColor,
						name: "reunion"
						});*/
				}
			}else if (controlPincel && hayImagen){ //si no se ha pulsado ning�n item o se ha clickado sobre el raster/im�gen que cree un nuevo path y en onMouseDrag se dibuja
				 //|| hitNombreItem == "cursor"					/*** CURSOR ***/
				if (!hitResult || hitClaseItem === "Raster" || hitResult.type == "fill" || hitNombreItem == "cursor"){ //si hitResult=null o se ha clickado sobre la im�gen o sobre un objeto con relleno/Reunion
					if (imagenRaster.bounds.contains(event.point)){//Si donde hace click esta dentro de los limites de la imagen
						if (project.activeLayer != capaVectorial){
							capaVectorial.activate();
						}
						path = new paper.Path({ //Crea un nuevo Path
							strokeColor: vectorColor,
							strokeWidth: vectorGrosor,
							strokeCap: vectorRedondezPunta,
							name: "vector"
							});
						//path.add(event.point);
						//center: [0, 0],
						//path.add(event.point);
						console.info("controlPincel = true");
						//path.strokeWidth = 8;
						//path.strokeJoin = 'round'; //La redondez de la punta
						dibujar = true;
					}
				} else if ( hitResult && hitClaseItem != "Raster") {
					//si pulsa en cualquier lugar del path y que no sea sobre el raster/im�gen...
					console.info("guardamos el path clickado");
					path = hitResult.item; //guardamos el path sobre el que se ha pulsado
					
					if (hitResult.type == 'segment') {
						//Y si se ha pulsado sobre un segmento/nodo del propio path
						console.info("onMouseDown guardamos el path clickado y segment.point");
						segment = hitResult.segment; //guardamos el segmento/nodo del propio path
		
					} else if (hitResult.type == 'stroke') {
						//Y si se ha pulsado sobre la l�nea del propio path
						console.info("onMouseDown guardamos el path clickado");
						var location = hitResult.location;
						segment = path.insert(location.index + 1, event.point); //inserta un nodo y lo guardamos
						path.smooth(); //Suaviza el nuevo v�rtice
					}
				}
			} else if (controlBorrar){
				console.info("controlBorrar = true");
				if (hitResult && hitClaseItem != "Raster") {
					hitResult.item.remove(); //Elimina el path completo con sus hijos pero en realidad no lo destruye por completo, luego se puede recuperar. Devuelve un booleano
				}
			}
		console.info("a punto de salir del onMouseDown");
		}

		/**
		*  Mientras esta encima de un item se selecciona
		*/
	 	//S�lo cuando pasamos por encima de un vector se selecciona (la imagen no)
		tool.onMouseMove = function(event){
			console.info("Ha entrado en onMouseMove");
			//paper.tool.mouseStartPos = new Point(event.point); //Para el zoom
			//Obtengo la posici�n del cursor para hacer Zoom
			//posicionRaton = getPosicionRaton(canvas, event);
			posicionRaton = canvas.getBoundingClientRect(); //Recojo la posicion del raton en la pantalla??. Para el Zoom

		    //posx = posicionRaton.x;
		    //posy = posicionRaton.y;

			//movemos el el circulo del tamanoo del pincel con el cursor.					/*** CURSOR ***/
			if (!controlMover && !controlBorrar){
				moverCursor(event.point);
			}
			
			project.activeLayer.selected = false;
			
			if (hayImagen){
				//Que solo seleccione los vectores y las reuniones. Ni la imagen ni ninguno de los elementos del tooltiptext 
				if (controlReunion && event.item && event.item.name == "reunion"){
					event.item.selected = true;
				}
				if (controlPincel && event.item && event.item.name == "vector"){
					event.item.selected = true;
				}
				if (controlBorrar && event.item && (event.item.name == "vector" || event.item.name == "reunion")){
					event.item.selected = true;
				}
				/*if (event.item && event.item.className != "Raster" && event.item.name != "tooltiptext" && event.item.name != "reunion"){
					event.item.selected = true;
				}*/
			}
		}
		
		/**Cuando arrastremos el rat�n con el bot�n pulsado ...
		*  1.- moveremos el Path completo si se hab�a pulsado CTRL
		*  2.- arrastraremos el segmento/nodo si se ha�a pulsado sobre �l
		*  3.- arrastraremos el el nuevo segmento/nodo que acabamos de crear si se ha�a pulsado sobre la l�nea/Path
		*/
		tool.onMouseDrag = function(event){
			console.info("Ha entrado en onMouseDrag");
			
			if (controlMover){
				//TODO Faltaria poner el viewToProject *****************************
				for (i=0; i<project.layers.length;i++){
					project.layers[i].position.x += event.delta.x;
					project.layers[i].position.y += event.delta.y;
				}
			}
			else if (dibujar){
				console.info("dibujar");
				//Si donde hace click esta dentro de los limites de la imagen
				if (imagenRaster.bounds.contains(event.point)){
					path.add(event.point);
				}
				console.info("Pos. nuevo punto: " + event.point);
			}else{
				console.info("dibujar ELSE");
				if (moverPath) { //pulsando CONTROL + CLICK mueve path entero
					path.position.x += event.delta.x;
		  			path.position.y += event.delta.y;
					//path.position += event.delta; //No funciona asi cuando pongo tool. ...
				}else if (segment) {
					segment.point.x += event.delta.x;
					segment.point.y += event.delta.y;
					//segment.point += event.delta; //No funciona asi cuando pongo tool. ...
					path.smooth(); //Suaviza el nuevo v�rtice
		  		}else if (path) {
		  			path.position.x += event.delta.x;
		  			path.position.y += event.delta.y;
					//path.position += event.delta; //No funciona asi cuando pongo tool. ...
				}
			}
			//movemos el c�rculo del tama�o del pincel con el cursor.					/*** CURSOR ***/
			if (!controlMover && !controlBorrar){
				moverCursor(event.point);
			}
		}

		/**
		* Cuando soltemos el rat�n se inicializan las variables que controlan el movimiento o dibujo
		*/
		tool.onMouseUp = function(event){
			console.info("Ha entrado en onMouseUp");
			if (dibujar){
				dibujar = false;
				path.simplify(5); //El ratio de simplificado por defecto es 2.5
			}else
				if (moverPath){
					moverPath = false;
				}
		}
		
		/**
		 * 
		 */
		function moverCursor(punto){
			//TODO controlar que cuando se salga de los l�mites desaparezca el c�rculo del cursor
			if (project.activeLayer != capaCursor){capaCursor.activate();}
			if (cursorTamanoPincel.visible == false){cursorTamanoPincel.visible = true;}
			cursorTamanoPincel.position.x = punto.x;//event.point.x;
			cursorTamanoPincel.position.y = punto.y;//event.point.y;
			if (project.activeLayer != capaVectorial){capaVectorial.activate();}
			console.info("cursor: " & cursorTamanoPincel.position.x & ", " & cursorTamanoPincel.position.y);
		}
		
		
	} // End window.onload()
		
