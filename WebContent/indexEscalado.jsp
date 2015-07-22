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
   		/*cursor: url(img/dot.png), pointer;*/
	}
  </style>
  
</head>

<!-- <body onload="dibujarCanvas()"> -->
<body><!-- oncontextmenu="return false;"> -->
<!-- for others: use <body oncontextmenu="return false;"> to prevent browser context menus from appearing on right click. -->
	
	<div id="container" style="width:75%;">
	
		<aside id="herramientas_izda" style="width:25%;">herramientas</aside>
		<canvas id="canvas_croquis" style="width:100%; border:1px solid #d3d3d3;">Su navegador no soporta Canvas. Instale la última versión de Chrome</canvas>
			
	</div>
	
	<button type="button" onclick="resizeCanvas()" name="Acci&oacute;n">resize</button>
	
	<input type="file" id="controlImagen" name="controlImagen" accept="images/*"/> <!-- image/jpeg, image/bmp, image/png, image/gif y atributo disabled-->
	<input type="color" id="controlColor" name="controlColor"/>
	<input type="range" id="controlZoom" name="controlZoom"  min="0" max="10"/>
	
	<script type="text/paperscript" canvas="canvas_croquis"  charset="utf-8">

	//Atributos de hitTest (eventos provocados por el ratón al clickar sobre un item/Path/Segmento/Stroke
	var hitOptions = {
		segments: true,
		stroke: true,
		//fill: true,
		tolerance: 5
		};
	//Atributos de los vectores
	var colorVector = 'blue'; //$(#controlColorVector).value; //Inicializa según lo que está predefinido
	var grosorVector = 8; //$(#controlGrosorVector).value; //Inicializa según lo que está predefinido
	var radioReunion = 3;

	var capaImagen;
	var capaVectores;
	var imagenRaster;
	var circuloReunion;
	var segment, path; //variables para saber qué item y en qué parte del item se ha clickado
	var moverPath = false; //Controla el movimiento en bloque del item
	var dibujar = false; //Controla si se va a dibujar o no
	//var contexto;
	var canvas = $('#canvas_croquis')[0]; //Obtenemos el id de la etiqueta canvas
	
	paper.settings.handleSize=10; //Tamaño de todos los nodos

	crearCapas(); //Creamos las capas (imágen, líneas)
	rutaImagen = "http://localhost:8080/HormaStudio/img/atxarte.jpg";
	cargarImagen(rutaImagen);
	//resizeCanvas(); //Aplica el tamaño de la imágen al canvas
	//adaptarCanvasAcontainer(); //Redimensiona el tamaño del canvas al div
	capaVectores.activate(); //Activa la capa de los vectores y lista para dibujar

	//crearPaths(); //Creamos Paths manualmente

	//Modificados desde un control exterior
	//$(#controlColorVector).onChange(function(){...colorVector = $(#controlColorVector).value;...});
	//$(#controlColorVector).onChange(function(){...grosorVector = $(#controlgrosorVector).value;...});
	
	function crearCapas(){
		//var capaActual = paper.project.activeLayer; //capa activa actual
		capaImagen = new Layer();
		capaImagen.name= "capa de imágen";
		capaVectores = new Layer();
		capaVectores.name= "capa de líneas";
	}

	function crearReunion(){
		circuloReunion = new Path.Circle({
			center: view.center,
			radius: radioReunion
			//fillColor: 'red'
		});
		//circuloReunion.position = path.getPointAt(0,0); //posición inicial. NO creo
	}
	
	//Creamos Paths manualmente
	//function crarPaths(){
		//path.add(new Point(40, 100));
		//path.add(new Point(150, 10));
		//path.add(new Point(370, 350));
		//path.add(new Point(450, 300));
	//}

	/**
	*  Preparamos el lienzo/canvas y cargarmos la imágen/raster en la capa capaImagen
	*/
	function cargarImagen(rutaImagen){
		//Activamos la capa de la imágen y la cargamos
		capaImagen.activate();

		//Carga una imágen. No la toma como dentro de la capa capaImagen
		//var img = new Image();
		//img.onload = function () {
	    //	contexto.drawImage(img, 0, 0);
		//}
		//img.src = "img/via.jpg";

		
		//Creamos un contexto contra la etiqueta canvas
		contexto = canvas.getContext("2d");
		contexto.fillStyle = "#424242";

		//Cargar imágen como raster. Ahora sí que está dentro de la capa capaImagen
		var puntoInsercion = new paper.Point(view.center);
		imagenRaster = new Raster({
  			source: rutaImagen,
  			//position: view.center,
			selected: false}, puntoInsercion);
		
		//canvas[0].width = 300;
		//canvas[0].height = 100;
		//paper.view.viewSize = new Size(500, 300);
		//paper.view.draw();

	}

	function adaptarCanvasAcontainer(){
  		// Make it visually fill the positioned parent
  		canvas.style.width ='100%'; //cambia la escala del contenido
  		canvas.style.height='100%'; //cambia la escala del contenido
  		// ...then set the internal size to match
  		canvas.width  = canvas.offsetWidth;
  		canvas.height = canvas.offsetHeight;
	}

	imagenRaster.onLoadl = function() {

		
		var anchoImagen = imagenRaster.width;
		var altoImagen = imagenRaster.height;
		var ratioTamanoCanvas = canvas.width / anchoImagen;

	imagenRaster.scale(ratioTamanoCanvas); //Escala la imágen al canvas
	canvas.height = (altoImagen * canvas.width) / anchoImagen; //ratio del tamaño de la imágen respecto al tamaño del canvas
	var puntoCentroImagen = new Point(canvas.width / 2, canvas.height / 2);
	imagenRaster.position = puntoCentroImagen;

		//canvas.width = this.width;
		//canvas.height = this.height;

		//Creamos un contexto contra la etiqueta canvas
		//contexto = canvas.getContext('2d');
		//contexto.drawImage(this, 0, 0, anchoImagen, altoImagen);
		

		//canvas.width = imagenRaster.width;
		//canvas.height = imagenRaster.height;
		//canvas.style.height='100%'; //cambia la escala del contenido

		
	//alert("Tamaño de imagen antes de tratarlo dentro del canvas: " + imagenRaster.size);


		
		//canvas.height = (canvas.height * anchoImagen) / altoImagen;
		//contexto.drawImage(this, anchoImagen / 2, altoImagen / 2, anchoImagen, altoImagen);
		

		//canvas.height = (canvas.height * imagenRaster.width) / imagenRaster.height; ESTAAAAAAAAA
    	//imagenRaster.size = new Size(canvas.width, canvas.height);
		//var puntoCentroImagen = new Point(imagenRaster.width / 2, imagenRaster.height / 2);
		//imagenRaster.position = puntoCentroImagen;
		
		//alert("Posicion de la imagen: " + imagenRaster.position + "\n Posicion del centro de la imagen: " + paper.view.center
		//		+ "\n Posicion del centro de la imagen: " + view.center + "\n Tamaño de la imagen: " + imagenRaster.size
		//		+ "\n Punto centro Imagen: " + puntoCentroImagen);

		//var ratio = anchoImagen / altoImagen;

		//var anchoCanvas = canvas.width;
		//var altoCanvas = canvas.height;
		//canvas.height *= ratio;
		//imagenRaster.width = canvas.width;
		//canvas.height = imagenRaster.height;
		//imagenRaster.height = canvas.height;
		//imagenRaster.position = view.center;
		//paper.view.draw();
	};


//function onResize(event) {
	// Whenever the window is resized, recenter the path:
//	path.position = view.center;
//	imagenRaster = view.center;
//}

	/**
	*  Cuando pulse el botón del ratón se obtendrá el item que está debajo y ...
	*  1.- si no ha pulsado ningún item que no haga nada
	*  2.- si se ha pulsado en cualquier lado del Path con la tecla CTRL pulsada lo mueve en bloque
	*  3.- si se ha pulsado en un nodo con la tecla SHIFT pulsada borra dicho nodo
	*  4.- si se ha pulsado en un segmento/nodo del path preparado para mover el segmento
	*  5.- si se ha pulsado en la línea del path inserta un nodo preparado para mover
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

		//Obtenemos dónde se ha pulsado el ratón 
		var hitResult = project.hitTest(event.point, hitOptions);

		if (hitResult==null){
			console.log("hitResult=null");
		}
		else{
			console.log("hitResult diferente de null");
		}

		//var claseItem = hitResult.item.className; //Otra forma más fiable de saber qué item hemos clickado

		//si no se ha pulsado ningún item o se ha clickado sobre el raster/imágen que cree un nuevo path y en onMouseDrag se dibuja
		if (!hitResult || claseItem === "Raster"){ //si hitResult=null o se ha clickado sobre la imágen //hitResult.type == "pixel"){// 
			path = new Path({
    			strokeColor: colorVector,
				strokeWidth: grosorVector,
				strokeJoin: 'round' //NO SÉ SI FUNCIONAAAAAAAAAAA, PARECE QUE SÍ PERO... LA PUNTA ES REKTA
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
			//project.activeLayer.addChild(hitResult.item); //no sñe si hay que incluirlo luego
			return;
		}

		//pulsando SHIFT + CLICK en el segmento/nodo borra el nodo 
		if (event.modifiers.shift) {
			if (hitResult.type == 'segment') {
				hitResult.segment.remove();
			};
			return;
		}	
	
		//si pulsa en cualquier lugar del path y que no sea sobre el raster/imágen...
		if ( hitResult && claseItem != "Raster" ) {

			path = hitResult.item; //guardamos el path sobre el que se ha pulsado

			//Y si se ha pulsado sobre un segmento/nodo del propio path
			if (hitResult.type == 'segment') {

				segment = hitResult.segment; //guardamos el segmento/nodo del propio path

			} //Y si se ha pulsado sobre la línea del propio path
			  else if (hitResult.type == 'stroke') {
				var location = hitResult.location;
				segment = path.insert(location.index + 1, event.point); //inserta un nodo y lo guardamos
				path.smooth();

			}
		}
	}

	/**
	*  Mientras esté encima de un item se selecciona
	*/
 	//Sólo cuando pasamos por encima de un vector se selecciona (la imágen no)
	function onMouseMove(event) {
		project.activeLayer.selected = false;
		if (event.item && event.item.className != "Raster")
			event.item.selected = true;
	}
	
	/**Cuando arrastremos el ratón con el botón pulsado ...
	*  1.- moveremos el Path completo si se había pulsado CTRL
	*  2.- arrastraremos el segmento/nodo si se haía pulsado sobre él
	*  3.- arrastraremos el el nuevo segmento/nodo que acabamos de crear si se haía pulsado sobre la línea/Path
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
	* Cuando soltemos el ratón se inicializan las variables que controlan el movimiento o dibujo
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

//First define the zoom tool properties

var toolZoomIn = new paper.Tool();

toolZoomIn.distanceThreshold = 8;
toolZoomIn.mouseStartPos = new paper.Point();
toolZoomIn.zoomFactor = 1.3;

	$('#canvas_croquis').bind('mousewheel DOMMouseScroll MozMousePixelScroll', function(e){

        var delta = 0;
        var children = project.activeLayer.children;
        var upperZoomLimit = 20;
        var lowerZoomLimit = 1.25;

        e.preventDefault();
        e = e || window.event;
        if (e.type == 'mousewheel') {       //this is for chrome/IE
                delta = e.originalEvent.wheelDelta;
            }
            else if (e.type == 'DOMMouseScroll') {  //this is for FireFox
                delta = e.originalEvent.detail*-1;  //FireFox reverses the scroll so we force to to re-reverse...
            }

        if((delta > 0) && (paper.view.zoom<upperZoomLimit)) { 
            //scroll up
            //var point = paper.DomEvent.getOffset(e.originalEvent, $('#canvas_croquis')[0]);
			var point = $('#canvas_croquis').offset();
            point = paper.view.viewToProject(point);
            var zoomCenter = point.subtract(paper.view.center);
            var moveFactor = toolZoomIn.zoomFactor - 1.0;
            paper.view.zoom *= toolZoomIn.zoomFactor;
            paper.view.center = paper.view.center.add(zoomCenter.multiply(moveFactor / toolZoomIn.zoomFactor));
            toolZoomIn.mode = '';
        }

        else if((delta < 0) && (paper.view.zoom>lowerZoomLimit)){ //scroll down
            //var point = paper.DomEvent.getOffset(e.originalEvent, $('#canvas_croquis')[0]);
			var point = $('#canvas_croquis').offset();
            point = paper.view.viewToProject(point);
            var zoomCenter = point.subtract(paper.view.center);   
            var moveFactor = toolZoomIn.zoomFactor - 1.0;
            paper.view.zoom /= toolZoomIn.zoomFactor;
            paper.view.center = paper.view.center.subtract(zoomCenter.multiply(moveFactor))
        }
    });

	function onResize(event) {
		// Whenever the window is resized, recenter the path:
		//capaImagen.position = view.center;
	}

	</script>
	
	<script type="text/javascript">
	function resizeCanvas(){
		//$('#canvas_croquis')[0].width = window.innerWidth;
		//$('#canvas_croquis')[0].height = window.innerHeight;
		$('#canvas_croquis')[0].width = $('#canvas_croquis')[0].width;
		$('#canvas_croquis')[0].height = $('#canvas_croquis')[0].height;
		//paper.view.draw();
		//$('#canvas_croquis')[0].width = 100;
		//$('#canvas_croquis')[0].height = 100;
	}
	</script>
	
	<!--  jQuery -->
	<script src="js/jquery-2.1.4.min.js"></script>
</body>
</html>