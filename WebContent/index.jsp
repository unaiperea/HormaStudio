<!doctype html>

<html lang="es">

<head>

  <base href="<%=request.getContextPath()%>/">
  
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  
  <title>Canvas</title>
  <meta name="description" content="Dibujar con canvas">
  <meta name="author" content="Unai Perea Cruz">
  
  <script type="text/javascript" src="js/paperjs-v0.9.23/dist/paper-full.js"></script>
  
  <!--[if lt IE 9]>
  	  <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	  <script src="http://css3-mediaqueries-js.googlecode.com/svn/trunk/css3-mediaqueries.js"></script>
  <![endif]-->
  
  <style>
  	body{
   		cursor: url(img/dot.png), pointer;
	}
  </style>
  
</head>

<!-- <body onload="dibujarCanvas()"> -->
<body oncontextmenu="return false;">
<!-- for others: use <body oncontextmenu="return false;"> to prevent browser context menus from appearing on right click. -->
	<div id="container">
	
		<canvas id="canvas_croquis" style="width:1000px; height:1000; border:1px solid #d3d3d3;">Su navegador no soporta Canvas.</canvas>
			
		
	</div>
	
	<input type="button" onclick="accionBoton();" name="Acci&oacute;n"/>
	
	<script type="text/paperscript" canvas="canvas_croquis">

	//Atributos de hitTest (eventos provocados por el rat�n al clickar sobre un item/Path/Segmento/Stroke
	var hitOptions = {
		segments: true,
		stroke: true,
		//fill: true,
		tolerance: 5
		};
	//Atributos de los vectores
	var colorVector = 'blue'; //$(#controlColorVector).value; //Inicializa seg�n lo que est� predefinido
	var grosorVector = 8; //$(#controlGrosorVector).value; //Inicializa seg�n lo que est� predefinido
	var radioReunion = 3;

	var capaImagen;
	var capaVectores;
	var circuloReunion;
	var segment, path; //variables para saber qu� item y en qu� parte del item se ha clickado
	var moverPath = false; //Controla el movimiento en bloque del item
	var dibujar = false; //Controla si se va a dibujar o no

	paper.settings.handleSize=10; //Tama�o de todos los nodos

	crearCapas(); //Creamos las capas (im�gen, l�neas)
	rutaImagen = "http://localhost:8080/HormaStudio/img/via.jpg";
	cargarImagen(rutaImagen);
	capaVectores.activate(); //Activa la capa de los vectores y lista para dibujar

	//crearPaths(); //Creamos Paths manualmente

	//Modificados desde un control exterior
	//$(#controlColorVector).onChange(function(){...colorVector = $(#controlColorVector).value;...});
	//$(#controlColorVector).onChange(function(){...grosorVector = $(#controlgrosorVector).value;...});
	
	function crearCapas(){
		//var capaActual = paper.project.activeLayer; //capa activa actual
		capaImagen = new Layer();
		capaImagen.name= "capa de im�gen";
		capaVectores = new Layer();
		capaVectores.name= "capa de l�neas";
	}

	function crearReunion(){
		circuloReunion = new Path.Circle({
			center: view.center,
			radius: radioReunion
			//fillColor: 'red'
		});
		//circuloReunion.position = path.getPointAt(0,0); //posici�n inicial. NO creo
	}
	
	//Creamos Paths manualmente
	//function crarPaths(){
		//path.add(new Point(40, 100));
		//path.add(new Point(150, 10));
		//path.add(new Point(370, 350));
		//path.add(new Point(450, 300));
	//}

	/**
	*  Preparamos el lienzo/canvas y cargarmos la im�gen/raster en la capa capaImagen
	*/
	function cargarImagen(rutaImagen){
		//Activamos la capa de la im�gen y la cargamos
		capaImagen.activate();

		//Creamos un contexto contra la etiqueta canvas
		var c = document.getElementById('canvas_croquis');
		contexto = c.getContext('2d');

		//Carga una im�gen. No la toma como dentro de la capa capaImagen
		//var img = new Image();
		//img.onload = function () {
	    //	contexto.drawImage(img, 0, 0);
		//}
		//img.src = "http://localhost:8080/canvas/img/via.jpg";

		//Cargar im�gen como raster. Ahora s� que est� dentro de la capa capaImagen 
		var imagenRaster = new Raster(rutaImagen);
		imagenRaster.position = view.center;
		imagenRaster.selected = false;
	}

	/**
	*  Cuando pulse el bot�n del rat�n se obtendr� el item que est� debajo y ...
	*  1.- si no ha pulsado ning�n item que no haga nada
	*  2.- si se ha pulsado en cualquier lado del Path con la tecla CTRL pulsada lo mueve en bloque
	*  3.- si se ha pulsado en un nodo con la tecla SHIFT pulsada borra dicho nodo
	*  4.- si se ha pulsado en un segmento/nodo del path preparado para mover el segmento
	*  5.- si se ha pulsado en la l�nea del path inserta un nodo preparado para mover
	*/
	function onMouseDown(event){
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

		segment = path = null;

		//Obtenemos d�nde se ha pulsado el rat�n 
		var hitResult = project.hitTest(event.point, hitOptions);
		var claseItem = hitResult.item.className; //Otra forma m�s fiable de saber qu� item hemos clickado

		//si no se ha pulsado ning�n item o se ha clickado sobre el raster/im�gen que cree un nuevo path y en onMouseDrag se dibuja
		if (!hitResult || claseItem === "Raster"){ //si hitResult=null o se ha clickado sobre la im�gen 
			path = new Path({
    			strokeColor: colorVector,
				strokeWidth: grosorVector,
				strokeJoin: 'round' //NO S� SI FUNCIONAAAAAAAAAAA, PARECE QUE S� PERO... LA PUNTA ES REKTA
				});
			//path.strokeWidth = 8;
			//path.strokeJoin = 'round'; //La redondez de la punta

			dibujar = true;
			return;
		}
		
		//EN MODO DEBUG CON EL CHROME NO ENTRAN LOS MODIFICADORES CONTROL NI SHIFT
		//Si se ha pulsado CTRL + CLICK que lo prepare para moverse
		if (event.modifiers.control){
			moverPath=true;
			path = hitResult.item;
			//project.activeLayer.addChild(hitResult.item); //no s�e si hay que incluirlo luego
			return;
		}

		//pulsando SHIFT + CLICK en el segmento/nodo borra el nodo 
		if (event.modifiers.shift) {
			if (hitResult.type == 'segment') {
				hitResult.segment.remove();
			};
			return;
		}	
	
		//si pulsa en cualquier lugar del path y que no sea sobre el raster/im�gen...
		if ( hitResult && claseItem != "Raster" ) {

			path = hitResult.item; //guardamos el path sobre el que se ha pulsado

			//Y si se ha pulsado sobre un segmento/nodo del propio path
			if (hitResult.type == 'segment') {

				segment = hitResult.segment; //guardamos el segmento/nodo del propio path

			} //Y si se ha pulsado sobre la l�nea del propio path
			  else if (hitResult.type == 'stroke') {
				var location = hitResult.location;
				segment = path.insert(location.index + 1, event.point); //inserta un nodo y lo guardamos
				path.smooth();

			}
		}
	}

	/**
	*  Mientras est� encima de un item se selecciona
	*/
 	//S�lo cuando pasamos por encima del path se selecciona
	function onMouseMove(event) {
		project.activeLayer.selected = false;
		if (event.item)
			event.item.selected = true;
	}
	
	/**Cuando arrastremos el rat�n con el bot�n pulsado ...
	*  1.- moveremos el Path completo si se hab�a pulsado CTRL
	*  2.- arrastraremos el segmento/nodo si se ha�a pulsado sobre �l
	*  3.- arrastraremos el el nuevo segmento/nodo que acabamos de crear si se ha�a pulsado sobre la l�nea/Path
	*/ 
	function onMouseDrag(event){
		
		if (dibujar){
			path.add(event.point);
		}else
			if (moverPath) { //pulsando CONTROL + CLICK mueve path entero
				path.position += event.delta;
			}else
				if (segment) {
					segment.point += event.delta;
					path.smooth();
		  		}else
					if (path) {
						path.position += event.delta;
					}
	}

	/**
	* Cuando soltemos el rat�n se inicializan las variables que controlan el movimiento o dibujo
	*/
	function onMouseUp (event){
		if (dibujar){
			dibujar = false;
			path.simplify(5); //El ratio de simplificado por defecto es 2.5
		}else
			if (moverPath){
				moverPath = false;
			}
	} 

	$('#canvas_croquis').bind('mousewheel DOMMouseScroll MozMousePixelScroll', function(e){
		var delta = 0;
		e.preventDefault();
		if (e.type == 'mousewheel') { //this is for chrome/IE
			delta = e.originalEvent.wheelDelta;
		} else if (e.type == 'DOMMouseScroll') { //this is for FireFox
			delta = e.originalEvent.detail*-1; //FireFox reverses the scroll so we force to to re-reverse...
		}

		if(delta > 0) { //scroll up
			capaImagen.scale(1.25, e.point);
		} else if(delta < 0){ //scroll down
			capaImagen.scale(.8, e.point);
		}
	});

	</script>
	
	<script type="text/javascript">

	</script>
	
	<!--  jQuery -->
	<script src="js/jquery-2.1.4.min.js"></script>
</body>
</html>