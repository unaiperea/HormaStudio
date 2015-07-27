<!doctype html>

<html lang="es">

<head>

  <base href="<%=request.getContextPath()%>/">
  
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  
  <title>Canvas</title>
  <meta name="description" content="Dibujar con canvas">
  <meta name="author" content="Unai Perea Cruz">
  
  <!-- Latest compiled and minified CSS -->
<!-- <link rel="stylesheet" href="js/bootstrap-3.3.5-dist/css/bootstrap.min.css"> -->

<!-- Latest compiled and minified JavaScript -->
<!-- <script src="js/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script> -->
  
  <script type="text/javascript" src="js/paperjs-v0.9.23/dist/paper-full.js" canvas="canvas_croquis"></script>
  
  
 <!-- sadfs -->
  
  <!-- javascript -->
  <script type="text/javascript">
  
  	//TODO No sé si es paper.project. ....

  	
  	paper.install(window);
	//Only executed our code once the DOM is ready.
	window.onload = function() {

	//Atributos de hitTest (eventos provocados por el ratón al clickar sobre un item/Path/Segmento/Stroke
	var hitOptions = {
		segments: true,
		stroke: true,
		//fill: true,
		tolerance: 5
		};
	
	//Atributos de los vectores
	var vectorColor; //$(#controlvectorColor).value; //Inicializa según lo que está predefinido
	var vectorGrosor; //$(#controlvectorGrosor).value; //Inicializa según lo que está predefinido
	var reunionRadio;
	var cursorColor;
	var cursorTamanoPincel;

	//Declaramos variables
	var capaImagen;
	var capaVectorial;	
	var capaCursor;
	var canvas;
	var tool;
	var contexto;
	var imagenRaster;
	
	var segment, path; //variables para saber qué item y en qué parte del item se ha clickado
	var moverPath = false; //Controla el movimiento en bloque del item
	var dibujar = false; //Controla si se va a dibujar o no
	var rutaImagen = "http://localhost:8080/HormaStudio/img/atxarte.jpg";
	
	var circuloReunion; //No sé si es imprescindible
	var rReunion;
	var grupoReunion //circuloReunion y  rReunion agrupados


	inicializarEntorno();
	inicializarCanvas();
	inicializarCapas(); //Creamos las capas (imágen, líneas)
	inicializarDibujoVectorial();
	cargarImagen(rutaImagen);

	//crearPaths(); //Creamos Paths manualmente

	//Modificados desde un control exterior
	//$(#controlvectorColor).onChange(function(){...vectorColor = $(#controlvectorColor).value;...});
	//$(#controlvectorColor).onChange(function(){...vectorGrosor = $(#controlvectorGrosor).value;...});
	
	function inicializarEntorno(){
		document.body.style.cursor = 'none'; //el cursor desaparece
	}
	
	function inicializarCanvas(){
		//Inicializar
		canvas = document.getElementById('canvas_croquis');//$('#canvas_croquis')[0]; //Obtenemos el id de la etiqueta canvas
	    paper.setup('canvas_croquis'); //Crea una clase intermedia para poder utilizar el lenguaje javascript en vez de paperscript
	    tool = new Tool(); //Crea una herramienta para manejar los eventos del teclado y ratón
	  	
	    //Creamos un contexto contra la etiqueta canvas
		contexto = canvas.getContext('2d');
		contexto.fillStyle = "#424242"; //Color de fondo del canvas -- NO FUNCIONA
		
		paper.settings.handleSize=10; //Tamaño de todos los nodos
	}
	
	function inicializarCapas(){
		//var capaActual = paper.project.activeLayer; //capa activa actual
		capaImagen = new paper.Layer();
		capaImagen.name= "capa de imagen";
		capaVectorial = new paper.Layer();
		capaVectorial.name= "capa de lineas";
		capaCursor = new paper.Layer();
		capaCursor.name= "capa del cursor";
	}

	function inicializarDibujoVectorial(){
		vectorColor = 'blue'; //$(#controlvectorColor).value; //Inicializa según lo que está predefinido
		vectorGrosor = 8; //$(#controlvectorGrosor).value; //Inicializa según lo que está predefinido
		reunionRadio = 3;
		cursorColor = 'black';
		
		//Creamos el objeto cursor
		capaCursor.activate();
		cursorTamanoPincel = new paper.Path.Circle ({
			center: [0, 0],
			radius: vectorGrosor/2,
			strokeColor: cursorColor});
		cursorTamanoPincel.visible = false;
		capaVectorial.activate();
		
		
	}
	
	function crearReunion(){
		circuloReunion = new paper.Path.Circle({
			center: paper.view.center,
			radius: reunionRadio,
			name: "circulito"
			//fillColor: 'red'
		});
		
		//TODO letra R rReunion y name: erre
		
		grupoReunion = new Group();
		reunion.addChild(circuloReunion);
		reunion.addChild(rReunion);
		
		//acceder a children reunion.children[0].point
		//acceder a children reunion.children[1].point
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
	*  Cargarmos la imágen/raster en la capa capaImagen
	*/
	function cargarImagen(rutaImagen){
		//Activamos la capa de la imágen y la cargamos
		capaImagen.activate();

		//Carga una imágen. No la toma como dentro de la capa capaImagen
		//var img = new Image();
		//img.onload = function () {
	    //	contexto.drawImage(img, 0, 0);
		//}
		//img.src = "http://localhost:8080/canvas/img/via.jpg";

		//Cargar imágen como raster. Ahora sí que está dentro de la capa capaImagen 
		//var imagenRaster = new Raster(rutaImagen);
		if (imagenRaster != null){
			console.info("va a borrar la imágen")
			imagenRaster.remove();
			imagenRaster = null;
			
		}
		
		var puntoInsercion = new paper.Point(paper.view.center);
		imagenRaster = new paper.Raster({
	  		source: rutaImagen,
	  		//position: view.center,
			selected: false}, puntoInsercion);
		
		paper.view.draw();
		
		//imagenRaster.position = view.center;
		imagenRaster.selected = false;
		capaVectorial.activate(); //Activa la capa de los vectores y lista para dibujar
	}

	
imagenRaster.onLoadk = function() {

	
	//Mi forma
	
	
		var anchoImagen = imagenRaster.width;
		var altoImagen = imagenRaster.height;
		var ratioTamanoCanvas = canvas.width / anchoImagen;

	imagenRaster.scale(ratioTamanoCanvas); //Escala la imágen al canvas
	canvas.height = (altoImagen * canvas.width) / anchoImagen; //ratio del tamaño de la imágen respecto al tamaño del canvas
	var puntoCentroImagen = new paper.Point(canvas.width / 2, canvas.height / 2);
	imagenRaster.position = puntoCentroImagen;
}

	/**
	*  Cuando pulse el botón del ratón se obtendrá el item que está debajo y ...
	*  1.- si no ha pulsado ningún item que no haga nada
	*  2.- si se ha pulsado en cualquier lado del Path con la tecla CTRL pulsada lo mueve en bloque
	*  3.- si se ha pulsado en un nodo con la tecla SHIFT pulsada borra dicho nodo
	*  4.- si se ha pulsado en un segmento/nodo del path preparado para mover el segmento
	*  5.- si se ha pulsado en la línea del path inserta un nodo preparado para mover
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
		console.info("Ha entrado en onMouseDown");
		
		segment = path = null;

		//Obtenemos dónde se ha pulsado el ratón 
		var hitResult = project.hitTest(event.point, hitOptions);
		var claseItem = hitResult.item.className; //Otra forma más fiable de saber qué item hemos clickado

		//si no se ha pulsado ningún item o se ha clickado sobre el raster/imágen que cree un nuevo path y en onMouseDrag se dibuja
		if (!hitResult || claseItem === "Raster"){ //si hitResult=null o se ha clickado sobre la imágen 
			path = new paper.Path({
    			strokeColor: vectorColor,
				strokeWidth: vectorGrosor,
				strokeJoin: 'round' //NO SÉ SI FUNCIONAAAAAAAAAAA, PARECE QUE SÍ PERO... LA PUNTA ES REKTA
				});
			//path.strokeWidth = 8;
			//path.strokeJoin = 'round'; //La redondez de la punta

			dibujar = true;
			return;
		}
		
		//EN MODO DEBUG CON EL CHROME NO ENTRAN LOS MODIFICADORES CONTROL NI SHIFT
		//Si pulsamos CTRL o SHIFT + Click ratón ...
		if (event.modifiers.control){
			//Si se ha pulsado CTRL + CLICK que lo prepare para moverse
			moverPath=true;
			path = hitResult.item;
			//project.activeLayer.addChild(hitResult.item); //no sé si hay que incluirlo luego
			return;
		}else if (event.modifiers.shift) {
				//pulsando SHIFT + CLICK en el segmento/nodo borra el nodo
				if (hitResult.type == 'segment') {
					hitResult.segment.remove();
				};
				return;
			}	

		if ( hitResult && claseItem != "Raster" ) {
			//si pulsa en cualquier lugar del path y que no sea sobre el raster/imágen...
			console.info("guardamos el path clickado");
			path = hitResult.item; //guardamos el path sobre el que se ha pulsado

			if (hitResult.type == 'segment') {
				//Y si se ha pulsado sobre un segmento/nodo del propio path
				console.info("onMouseDown guardamos el path clickado y segment.point");
				segment = hitResult.segment; //guardamos el segmento/nodo del propio path

			}else if (hitResult.type == 'stroke') {
				//Y si se ha pulsado sobre la línea del propio path
				console.info("onMouseDown guardamos el path clickado");
				var location = hitResult.location;
				segment = path.insert(location.index + 1, event.point); //inserta un nodo y lo guardamos
				path.smooth(); //Suaviza el nuevo vértice

			}
		}
	}

	/**
	*  Mientras esté encima de un item se selecciona
	*/
 	//Sólo cuando pasamos por encima de un vector se selecciona (la imágen no)
	tool.onMouseMove = function(event){
		console.info("Ha entrado en onMouseMove");
		
		//movemos el el círculo del tamaño del pincel con el cursor.
		
		//TODO controlar que cuando se salga de los límites desaparezca el círculo del cursor
		capaCursor.activate();
		//cursorTamanoPincel.position = event.point;
		cursorTamanoPincel.position.x = event.point.x;
		cursorTamanoPincel.position.y = event.point.y;
		cursorTamanoPincel.visible = true;
		capaVectorial.activate();
		
		project.activeLayer.selected = false;
		
		//TODO en el caso de que se elija dibujar reunión que le siga al puntero un recuadro con la frase Click en la imágen
		
		if (event.item && event.item.className != "Raster")
			event.item.selected = true;
	}
	
	/**Cuando arrastremos el ratón con el botón pulsado ...
	*  1.- moveremos el Path completo si se había pulsado CTRL
	*  2.- arrastraremos el segmento/nodo si se haía pulsado sobre él
	*  3.- arrastraremos el el nuevo segmento/nodo que acabamos de crear si se haía pulsado sobre la línea/Path
	*/
	tool.onMouseDrag = function(event){
		console.info("Ha entrado en onMouseDrag");

		//movemos el el círculo del tamaño del pincel con el cursor.
		
		//TODO controlar que cuando se salga de los límites desaparezca el círculo del cursor
		capaCursor.activate();
		cursorTamanoPincel.position.x = event.point.x;
		cursorTamanoPincel.position.y = event.point.y;
		cursorTamanoPincel.visible = true;
		capaVectorial.activate();
		
		if (dibujar){
			path.add(event.point);
		}else
			if (moverPath) { //pulsando CONTROL + CLICK mueve path entero
				path.position.x += event.delta.x;
	  			path.position.y += event.delta.y;
				//path.position += event.delta; //No funciona así cuando pongo tool. ...
			}else if (segment) {
				segment.point.x += event.delta.x;
				segment.point.y += event.delta.y;
				//segment.point += event.delta; //No funciona así cuando pongo tool. ...
				path.smooth(); //Suaviza el nuevo vértice
		  		}else if (path) {
		  			path.position.x += event.delta.x;
		  			path.position.y += event.delta.y;
					//path.position += event.delta; //No funciona así cuando pongo tool. ...
				}
	}

	/**
	* Cuando soltemos el ratón se inicializan las variables que controlan el movimiento o dibujo
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

	control_imagen.onchange = function( event ){
		if (this.files && this.files[0]){
			//imagenRaster.remove();
			//paper.view.draw();
			//var fichero = new FileReader();
			//fichero.onload = function (e) {
			//	   $('#canvas_croquis').attr('src', e.target.result);
			//	  }
			//var dataURL = fichero.readAsDataURL(this.files[0]);
			
			//cargarImagen("C:\\Users\Atxa\\Desktop\\" + this.files[0].name);
			rutaImagen = "http://localhost:8080/HormaStudio/img/aspe.jpg"; //le paso una imágen para probar ya que el proceso sería: 1.- Escalara al tamaño del canvas 2.- subirlo a la web
			cargarImagen(rutaImagen);
		}
	}

	
}
	</script>

	<style>
  		/*body{ cursor: url(img/dot.png), pointer; }*/
	</style>
  
</head>

<!-- <body onload="dibujarCanvas()"> -->
<body>
<!-- for others: use <body oncontextmenu="return false;"> to prevent browser context menus from appearing on right click. -->
	<div id="container" style="width:75%;">
	
		<aside id="herramientas_izda" style="width:25%;">herramientas</aside>
		<canvas id="canvas_croquis" style="width:100%; border:1px solid #d3d3d3;" resize>Su navegador no soporta Canvas. Instale la última versión de Chrome</canvas>
			
	</div>
	
	<button type="button" onclick="resizeCanvas()" name="Acci&oacute;n">resize</button>
	
	<input type="file" id="control_imagen" name="control_imagen" accept="image/jpeg" onchange="abrirImagen(this.value);"/> <!-- images/* o image/jpeg, image/bmp, image/png, image/gif y atributo disabled-->
	<input type="color" id="control_color" name="control_color"/>
	<input type="range" id="control_zoom" name="control_zoom"  min="0" max="10"/>
	
	<!--  jQuery -->
	<script src="js/jquery-2.1.4.min.js"></script>
</body>
</html>
