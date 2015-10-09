/**
 * 
 * Funciones propias del canvas utilizando la librería paper.js
 * 
 */

function inicializarEntorno(){
		//document.body.style.cursor = 'none'; //el cursor desaparece
		console.warn('inicializarEntorno: No hacemos nada');
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
		vectorColor         = '#0000FF';
		vectorGrosor        = 5;
		vectorRedondezPunta = 'round';
		nodoTamano          = vectorGrosor*2;
		
		reunionRadio        = 8;
		reunionColor        = '#ff0000';
		
		cursorColor         = 'black';					/*** CURSOR ***/
		hitTestTolerancia   = 2;
		
		//Tama�o de todos los nodos
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
		
		//Opciones HitTest
		hitOptions = {
				segments: true, //para clickar en los nodos
				stroke: true, //para clickar en las l�neas
				fill: true, //para clickar en las reuniones
				tolerance: hitTestTolerancia
				};
	}
	
	//Creamos Paths manualmente
	//function crarPaths(){
		//path.add(new Point(40, 100));
		//path.add(new Point(150, 10));
		//path.add(new Point(370, 350));
		//path.add(new Point(450, 300));
	//}

	//Redimensiona el entorno
	imagenRaster.onLoad = function() { //Se ejecuta al cargar por primera vez la imágen 
		//redimensionarImagen();
	
		var MAX_WIDTH = $('#canvas_croquis').width();//$('#entorno').width(); //Anchura del div
		var MAX_HEIGHT = $('#canvas_croquis').height();//$('#entorno').height(); //Altura del div
		var tempW = imagenRaster.width;
		var tempH = imagenRaster.height;
		//ratioZoomFactor = 1;
		//porcentajeZoom = 0;
		
		//while (tempW > MAX_WIDTH || tempH > MAX_HEIGHT){
			/*$('#canvas_croquis').width();
				for (i=0 ; i < 10 ; i++){
					setMenosZoom();
					$('#canvas_croquis').width();
				}*/

			//document.getElementById("zoom_texto").value = document.getElementById("control_zoom").value;
		//}
		//TODO
		if (tempW >= MAX_WIDTH || tempH >= MAX_HEIGHT){ //Si cualquiera de las dimensiones de la imágen es mayor que la del canvas que quite nivel de zoom
			//if (tempW >= tempH){ //Comprobamos la dimensión que va a predominar. Si el ancho de la imágen es mayor que el alto de la imágen
			if (tempH >= MAX_HEIGHT){ //Pero si el alto de la imágen es mayor que el alto del canvas que se calcule el ratio respecto del alto del canvas
				//porcentajeZoom = Math.abs(MAX_HEIGHT * 100 / tempH);
				ratioZoomFactor = (tempH / MAX_HEIGHT);
			}else{ //Sino que se calcule el ratio respecto del ancho del canvas
				//porcentajeZoom = Math.abs(MAX_WIDTH * 100 / tempW);
				ratioZoomFactor = (tempW / MAX_WIDTH);
			}
			//porcentajeZoom = Math.abs(1 - ratioZoomFactor);
			//}else{//Si el alto de la imágen es mayor que el ancho de la imágen que se calcule el ratio respecto del alto de la imágen
				//ratioZoomFactor = (tempW / MAX_WIDTH);
			//	ratioZoomFactor = (tempH / MAX_HEIGHT);
			//}
		}else{ //Sino que deje el tamaño de la imágen al 100% y en el centro
			ratioZoomFactor = 1;
		}
		 
		var point = paper.view.viewToProject(paper.view.center); //point //Convertimos a coordenadas dentro del proyecto
		var zoomCenter = point.subtract(paper.view.center); 
		var moveFactor = tool.zoomFactor - 1.0;
		originalZoom = paper.view.zoom /= ratioZoomFactor;
        paper.view.center = paper.view.center.subtract(zoomCenter.multiply(moveFactor));
		
		// now scale the context to counter
        // the fact that we've manually scaled
        // our canvas element
        //contexto.scale(ratio, ratio);
		
		var puntoCentroImagen = new paper.Point(MAX_WIDTH / 2, MAX_HEIGHT / 2);
		originalCentro = imagenRaster.position = paper.view.viewToProject(puntoCentroImagen);
		//paper.view.draw;
		
		//document.getElementById("zoom_texto").value =  porcentajeZoom;
	
	}
	
	function inicializarControles(){
		controlPincel = true;
		controlReunion = false;
		controlBorrar = false;
		
		//ColorPicker
		document.getElementById("control_color").value = "#0000FF";
		
		//Tama�o pincel
		document.getElementById("control_grosor").value = vectorGrosor;
		document.getElementById("grosor_texto").value = vectorGrosor;
		
		//Zoom
		//document.getElementById("control_zoom").value = lowerZoomLimit;
		//document.getElementById("zoom_texto").value = lowerZoomLimit;
		//$("#control_zoom")[0].min = lowerZoomLimit;
        //$("#control_zoom")[0].max = upperZoomLimit;
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
		
		teclaPulsada = new PointText({
		    position: [rectangulo.x + (rectangulo.width/7), rectangulo.y + (rectangulo.height/1.5)],
		    content: 'null',
		    fillColor: 'black',
		    fontFamily: 'Arial',
		    fontWeight: 'bold',
		    fontSize: 10,
		    name: "textotooltip"
		});
		
		grupoTecla = new Group({
			children: [teclaContorno, teclaPulsada]
		});
		grupoTecla.name = "tooltiptext";
		grupoTecla.visible = false;
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
			grupoReunion = new Group();
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
		}else if (controlReunion){ //Si se ha pulsado el bot�n de Reuni�n que cree una nueva reuni�n al clickar sobre el canvas
			console.info("controlReunion = true");
			if (project.activeLayer = capaVectorial) console.info("capaVectorial");
			else console.info("otra capa");
			circuloReunion = new paper.Path.Circle({
				center: event.point,
				radius: reunionRadio,
				fillColor: reunionColor,
				name: "reunion"
				});
			console.info(circuloReunion.visible);
		}else if (controlPincel){ //si no se ha pulsado ning�n item o se ha clickado sobre el raster/im�gen que cree un nuevo path y en onMouseDrag se dibuja
			 //|| hitNombreItem == "cursor"					/*** CURSOR ***/
			if (!hitResult || hitClaseItem === "Raster" || hitResult.type == "fill" || hitNombreItem == "cursor"){ //si hitResult=null o se ha clickado sobre la im�gen o sobre un objeto con relleno/Reuni�n
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
	*  Mientras est� encima de un item se selecciona
	*/
 	//S�lo cuando pasamos por encima de un vector se selecciona (la im�gen no)
	tool.onMouseMove = function(event){
		console.info("Ha entrado en onMouseMove");
		//paper.tool.mouseStartPos = new Point(event.point); //Para el zoom
		//Obtengo la posici�n del cursor para hacer Zoom
		//posicionRaton = getPosicionRaton(canvas, event);
		posicionRaton = canvas.getBoundingClientRect(); //Recojo la posici�n del rat�n en la ��pantalla??. Para el Zoom

	    //posx = posicionRaton.x;
	    //posy = posicionRaton.y;

		//movemos el el c�rculo del tama�o del pincel con el cursor.					/*** CURSOR ***/
		if (!controlMover && !controlBorrar){
			moverCursor(event.point);
		}
		
		project.activeLayer.selected = false;
		
		//Que s�lo seleccione los vectores y las reuniones. Ni la im�gen ni ninguno de los elementos del tooltiptext 
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
	
	/**Cuando arrastremos el rat�n con el bot�n pulsado ...
	*  1.- moveremos el Path completo si se hab�a pulsado CTRL
	*  2.- arrastraremos el segmento/nodo si se ha�a pulsado sobre �l
	*  3.- arrastraremos el el nuevo segmento/nodo que acabamos de crear si se ha�a pulsado sobre la l�nea/Path
	*/
	tool.onMouseDrag = function(event){
		console.info("Ha entrado en onMouseDrag");
		
		if (controlMover){
			//TODO Faltar�a poner el viewToProject *****************************
			for (i=0; i<project.layers.length;i++){
				project.layers[i].position.x += event.delta.x;
				project.layers[i].position.y += event.delta.y;
			}
		}
		else if (dibujar){
			//TODO controlar que no salga del l�mite de la im�gen y/o del canvas. Controlar cuando tiene zoom
			console.info("dibujar");
			path.add(event.point);
			console.info("Pos. nuevo punto: " + event.point);
		}else{
			console.info("dibujar ELSE");
			if (moverPath) { //pulsando CONTROL + CLICK mueve path entero
				path.position.x += event.delta.x;
	  			path.position.y += event.delta.y;
				//path.position += event.delta; //No funciona as� cuando pongo tool. ...
			}else if (segment) {
				segment.point.x += event.delta.x;
				segment.point.y += event.delta.y;
				//segment.point += event.delta; //No funciona as� cuando pongo tool. ...
				path.smooth(); //Suaviza el nuevo v�rtice
	  		}else if (path) {
	  			path.position.x += event.delta.x;
	  			path.position.y += event.delta.y;
				//path.position += event.delta; //No funciona as� cuando pongo tool. ...
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