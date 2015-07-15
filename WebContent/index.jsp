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
<body>

	<div id="container">
	
		<canvas id="canvas_croquis" style="width:1000px; height:1000; border:1px solid #d3d3d3;">Su navegador no soporta Canvas.</canvas>
			
		
	</div>
	
	<input type="button" onclick="accionBoton();" name="Acci&oacute;n"/>
	
	<script type="text/paperscript" canvas="canvas_croquis">

	//Atributos de hitTest (eventos provocados por el ratón al clickar sobre un item/Path/Segmento/Stroke
	var hitOptions = {
		segments: true,
		stroke: true,
		//fill: true,
		tolerance: 5
		};

	var path; //creamos variable=null a utilizar (la línea/vía) y le damos unos atributos predefinidos

	paper.settings.handleSize=10; //Tamaño de todos los nodos

	rutaImagen = "http://localhost:8080/HormaStudio/img/via.jpg";
	cargarImagen(rutaImagen);

	//crearPaths();

	//var circuloCercano = new Path.Circle({
	//	center: view.center,
	//	radius: 3,
	//	fillColor: 'red'
	//});
	//crearCirculito();

	//function crearCiruculito(){
	//circuloCercano.visible=false; //Oculta posición inicial
	//circuloCercano.position = path.getPointAt(0,0); //posición inicial. NO creo
	//}

	//function crarPaths(){
		//Creamos Paths manualmente
		//path.add(new Point(40, 100));
		//path.add(new Point(150, 10));
		//path.add(new Point(370, 350));
		//path.add(new Point(450, 300));
	//}

	function cargarImagen(rutaImagen){
		//Crea una capa para la imágen y la activa
		//var capaPrincipal = paper.project.activeLayer;

		//Creamos las capas
		var capaImagen = new Layer();
		capaImagen.name= "capa de imágen";

		var capaLineas = new Layer();
		capaLineas.name= "capa de líneas";
		
		//Activamos una capa y dibujamos
		capaImagen.activate();

		//Creamos un contexto contra la etiqueta canvas
		var c = document.getElementById('canvas_croquis');
		contexto = c.getContext('2d');

		//Carga una imágen. No la toma como dentro de la capa capaImagen
		//var img = new Image();
		//img.onload = function () {
	    //	contexto.drawImage(img, 0, 0);
		//}
		//img.src = "http://localhost:8080/canvas/img/via.jpg";
		//Cargar imágen como raster. Ahora sí que está dentro de la capa capaImagen 
		var imagenRaster = new Raster(rutaImagen);
		imagenRaster.position = view.center;
		//raster.opacity=0.5;
		imagenRaster.selected = false;

		capaLineas.activate();
	}


	/**
	*Cuando pulse el botón del ratón se obtendrá el item que está debajo y ...
	*1.- si no ha pulsado ningún item que no haga nada
	*2.- si se ha pulsado en cualquier lado del Path con la tecla CTRL pulsada lo mueve en bloque
	*3.- si se ha pulsado en un nodo con la tecla SHIFT pulsada borra dicho nodo
	*4.- si se ha pulsado en un segmento/nodo del path preparado para mover el segmento
	*5.- si se ha pulsado en la línea del path inserta un nodo preparado para mover
	*/
	var segment, path;
	var moverPath = false; //Controla el movimiento en bloque del item
	var dibujar = false; //Controla si se va a dibujar o no
	function onMouseDown(event){

		segment = path = null;

		//Obtenemos dónde se ha pulsado el ratón 
		var hitResult = project.hitTest(event.point, hitOptions);
		var claseItem = hitResult.item.className; //Otra forma más fiable de saber qué item hemos clickado

		//si no se ha pulsado ningún item o se ha clickado sobre el raster/imágen que cree un nuevo path y en onMouseDrag se dibuja
		if (!hitResult || claseItem === "Raster"){ //si hitResult=null !hitResult || 
			path = new Path({
    			strokeColor: 'red',
				strokeWidth: 8,
				strokeJoin: 'round' //NO SÉ SI FUNCIONAAAAAAAAAAA, PARECE QUE SÍ PERO... LA PUNTA ES REKTA
				});
			//path.strokeWidth = 8;
			//path.strokeJoin = 'round'; //La redondez de la punta

			dibujar = true;
			return;
		}
		
		//EN MODO DEBUG CON EL CHROME NO ENTRAN LOS MODIFICADORES NI CONTROL NI SHIFT
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
	* Mientras esté encima de un item se selecciona
	*/
 	//Sólo cuando pasamos por encima del path se selecciona
	function onMouseMove(event) {
		project.activeLayer.selected = false;
		if (event.item)
			event.item.selected = true;
	}
	
	/**Cuando arrastremos el ratón con el botón pulsado ...
	*1.- moveremos el Path completo si se había pulsado CTRL
	*2.- arrastraremos el segmento/nodo si se haía pulsado sobre él
	*3.- arrastraremos el el nuevo segmento/nodo que acabamos de crear si se haía pulsado sobre la línea/Path
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

		//Hacemos desaparecer el circulito de la referencia para estirar el path
	//	if (circuloCercano.visible == true){
	//		circuloCercano.visible = false;
	//	}
	} 

	</script>
	
	<!--  jQuery -->
	<script src="js/jquery-2.1.4.min.js"></script>
</body>
</html>