<!doctype html>

<html lang="es">

<head>

  <base href="<%=request.getContextPath()%>/">
  
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  
  <title>Canvas</title>
  <meta name="description" content="Dibujar con canvas">
  <meta name="author" content="Unai Perea Cruz">
  
  <!-- Responsive Design -->
  <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
  
  <!-- Bootstrap minified CSS -->
  <link rel="stylesheet" href="js/bootstrap-3.3.5-dist/css/bootstrap.min.css">

  <!-- Custom IconMoon  -->
  <link rel="stylesheet" type="text/css" href="fonts/iconmoon/style.css">

  <!-- Paper.js dibujo en Canvas -->
  <script type="text/javascript" src="js/paperjs-v0.9.23/dist/paper-full.js" canvas="canvas_croquis"></script>
  
  <!-- javascript -->
  <script type="text/javascript">
  
  	//TODO No sé si es paper.project. ....

  	
  	paper.install(window);
	//Only executed our code once the DOM is ready.
	window.onload = function() {

	//Atributos de hitTest (eventos provocados por el ratón al clickar sobre un item/Path/Segmento/Stroke
	var hitOptions = null;
	
	//Atributos de los vectores
	var vectorColor; //$(#controlvectorColor).value; //Inicializa según lo que está predefinido
	var vectorGrosor; //$(#controlvectorGrosor).value; //Inicializa según lo que está predefinido
	var vectorRedondezPunta;
	var reunionRadio;
	var reunionColor;
	//var cursorColor;					*** CURSOR ***
	var cursorTamanoPincel;
	var hitTestTolerancia;
	var nodoTamano;

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
		//document.body.style.cursor = 'none'; //el cursor desaparece
	}
	
	function inicializarCanvas(){
		//Inicializar
		canvas = document.getElementById('canvas_croquis');//$('#canvas_croquis')[0]; //Obtenemos el id de la etiqueta canvas
	    paper.setup('canvas_croquis'); //Crea una clase intermedia para poder utilizar el lenguaje javascript en vez de paperscript
	    tool = new Tool(); //Crea una herramienta para manejar los eventos del teclado y ratón
	  	
	    //Creamos un contexto contra la etiqueta canvas
		contexto = canvas.getContext('2d');
		//contexto.fillStyle = "#424242"; //Color de fondo del canvas -- NO FUNCIONA
		
		//project.currentStyle = {
		//		strokeColor: 'black',
		//		strokeWidth: 4,
		//		strokeCap: 'round'
		//	};
		project.strokeCap = 'round'; //COMPROBAAAAR *****
		//project.fillStyle = "#424242";
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
		vectorColor         = 'blue'; //$(#controlvectorColor).value; //Inicializa según lo que está predefinido
		vectorGrosor        = 5; //$(#controlvectorGrosor).value; //Inicializa según lo que está predefinido
		vectorRedondezPunta = 'round';
		nodoTamano          = vectorGrosor*2;
		
		reunionRadio        = 3;
		reunionColor        = 'red';
		
		//cursorColor         = 'black';					*** CURSOR ***
		hitTestTolerancia   = -15;

		
		//Tamaño de todos los nodos
		paper.settings.handleSize = nodoTamano;
		
		//Creamos el objeto cursor
		/*capaCursor.activate();
		cursorTamanoPincel = new paper.Path.Circle ({
			center: [0, 0],
			radius: vectorGrosor/2,
			strokeColor: cursorColor,						*** CURSOR ***
			name: 'puntero'});
		cursorTamanoPincel.visible = false;
		capaVectorial.activate();*/
		
		//Opciones HitTest
		hitOptions = {
				segments: true,
				stroke: true,
				fill: false,
				tolerance: hitTestTolerancia
				};
	}
	
	function crearReunion(){
		circuloReunion = new paper.Path.Circle({
			center: paper.view.center,
			radius: reunionRadio,
			name: "circulito",
			fillColor: reunionColor
		});
		
		/*
		//TODO letra R rReunion y name: erre
		grupoReunion = new Group();
		reunion.addChild(circuloReunion);
		reunion.addChild(rReunion);
		
		//acceder a children reunion.children[0].point
		//acceder a children reunion.children[1].point
		//circuloReunion.position = path.getPointAt(0,0); //posición inicial. NO creo
		*/
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
		
		/*var puntoInsercion = new paper.Point(paper.view.center);
		imagenRaster = new paper.Raster({
	  		source: rutaImagen,
	  		//position: view.center,
			selected: false}, puntoInsercion);*/
		imagenRaster = new paper.Raster({
	  		source: rutaImagen,
			selected: false});
		
		paper.view.draw(); //Nos aseguramos que la redibuja en el caso de cambiar la imágen (entra en imagenRaster.onload)
		
		//imagenRaster.position = view.center;
		imagenRaster.selected = false;
		capaVectorial.activate(); //Activa la capa de los vectores y lista para dibujar
	}

	
	//Redimensiona el entorno
	imagenRaster.onLoad = function() {
		
		// finally query the various pixel ratios
        devicePixelRatio = window.devicePixelRatio || 1,
        backingStoreRatio = contexto.webkitBackingStorePixelRatio ||
                            contexto.mozBackingStorePixelRatio ||
                            contexto.msBackingStorePixelRatio ||
                            contexto.oBackingStorePixelRatio ||
                            contexto.backingStorePixelRatio || 1,

        ratio = devicePixelRatio / backingStoreRatio;
		
		var MAX_WIDTH = $('#canvas_croquis').width();//$('#entorno').width(); //Anchura del div
		var MAX_HEIGHT = $('#canvas_croquis').height();//$('#entorno').height(); //Altura del div
		var tempW = imagenRaster.width;
		var tempH = imagenRaster.height;
		
		if (tempW > tempH){ //Si la anchura de la imágen es mayor que la altura de la imágen se coge la anchura de la imágen
			if (tempW > MAX_WIDTH){ //Si la imágen es mayor (en cuanto a anchura) que la del canvas, que permanezca la anchura del canvas
				//Reducir imágen
				tempH = Math.floor((tempH * MAX_WIDTH) / tempW); //Redondeo hacia abajo el redimensionamiento
				imagenRaster.width = tempW = MAX_WIDTH; //OJO CON EL MARCO DEL CANVAS
				canvas.height = imagenRaster.height = tempH;
				canvas.style.height = tempH + 'px';
			}else{ //Reducir canvas
				canvas.width = tempW;
				canvas.style.width = tempW + 'px'; //Le da más calidad
				canvas.height = tempH;
				canvas.style.height = tempH + 'px'; //Le da más calidad
			}
		}else{ //Si la altura de la imágen es mayor que la anchura de la imágen se coge la anchura de la imágen
			if (tempH > MAX_HEIGHT){ //Si la imágen es mayor (en cuanto a altura) que la del canvas, que permanezca la altura del canvas
				//Reducir imágen
				tempW = Math.floor((tempW * MAX_HEIGHT) / tempH);
				imagenRaster.height = tempH = MAX_HEIGHT;
				canvas.width = imagenRaster.width = tempW;
				canvas.style.width = tempW + 'px'; //Le da más calidad
			}else{ //Reducir canvas
				canvas.width = tempW;
				canvas.style.width = tempW + 'px'; //Le da más calidad
				canvas.height = tempH;
				canvas.style.height = tempH + 'px'; //Le da más calidad
			}
			
		}
		
		// La dimensión mayor de la imágen entre los atributos MAX_WIDTH o MAX_HEIGHT es la que definimos como máxima
		/*var MAX_WIDTH = $(document).width; //coge la anchura total del div en el que se encuentra
		var MAX_HEIGHT = $(document).height; //coge la altura total del div en el que se encuentra
		var tempW = imagenRaster.width;
		var tempH = imagenRaster.height;
		if (tempW > tempH) {
			if (tempW > MAX_WIDTH) {
				tempH *= MAX_WIDTH / tempW;
				tempW = MAX_WIDTH;
			}
		} else {
			if (tempH > MAX_HEIGHT) {
				tempW *= MAX_HEIGHT / tempH;
				tempH = MAX_HEIGHT;
			}
		}
		canvas.width = tempW;
		canvas.height = tempH;*/
		
		// now scale the context to counter
        // the fact that we've manually scaled
        // our canvas element
        contexto.scale(ratio, ratio);
		
		var puntoCentroImagen = new paper.Point(tempW / 2, tempH / 2);
		imagenRaster.position = puntoCentroImagen;
		paper.view.draw;
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
		var hitClaseItem = hitResult.item.className; //Otra forma más fiable de saber qué item hemos clickado
		
		console.info(hitResult.item.name);
		
		//si no se ha pulsado ningún item o se ha clickado sobre el raster/imágen que cree un nuevo path y en onMouseDrag se dibuja
		if (!hitResult || hitClaseItem === "Raster"){ //si hitResult=null o se ha clickado sobre la imágen 
			path = new paper.Path({
    			strokeColor: vectorColor,
				strokeWidth: vectorGrosor,
				strokeJoin: vectorRedondezPunta //NO SÉ SI FUNCIONAAAAAAAAAAA, PARECE QUE SÍ PERO... LA PUNTA ES REKTA
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

		if ( hitResult && hitClaseItem != "Raster") {
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
		
		/*
		//movemos el el círculo del tamaño del pincel con el cursor.
		//TODO controlar que cuando se salga de los límites desaparezca el círculo del cursor
		if (project.activeLayer != capaCursor){capaCursor.activate();}
		cursorTamanoPincel.position.x = event.point.x;													*** CURSOR ***
		cursorTamanoPincel.position.y = event.point.y;
		if (cursorTamanoPincel.visible == false){cursorTamanoPincel.visible = true;}
		if (project.activeLayer != capaVectorial){capaVectorial.activate();}
		//PROBAR QUE NO ENTRE A event.item.selected = true; O QUITAR project.activeLayer.selected = false O = TRUE;
		*/
		
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

		/*
		//movemos el el círculo del tamaño del pincel con el cursor.
		//TODO controlar que cuando se salga de los límites desaparezca el círculo del cursor
		if (project.activeLayer != capaCursor){capaCursor.activate();}
		cursorTamanoPincel.position.x = event.point.x;												*** CURSOR ***
		cursorTamanoPincel.position.y = event.point.y;
		if (cursorTamanoPincel.visible == false){cursorTamanoPincel.visible = true;}
		if (project.activeLayer != capaVectorial){capaVectorial.activate();}
		*/
		
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
		body{background-color: purple;}
  		#canvas{background-color: #414141; cursor: crosshair;} /* cursor: url(img/dot.png), pointer; }*/
  		header{background-color: lime;}
  		#cabecera{background-color: yellow;}
  		.container{background-color: grey;}
  		.menu{background-color: brown;}
  		#barra-menus{background-color: olive;}
  		#controles{background-color: orange;}
  		#herramientas-izda{background-color: cyan;}
  		#herramientas-dcha{background-color: blue;}
  		footer{background-color: silver;}
  		
	</style>
  
</head>

<body>
<!-- for others: use <body oncontextmenu="return false;"> to prevent browser context menus from appearing on right click. -->

	<header id="cabecera">
		<div class="container">
			<h1>T&iacute;tulo</h1>
		</div>
	</header>
	
	<nav class="menu-wrapper">
		<div class="menu">
			<h2>menu</h2>
		</div>
	</nav>
	
	<div class="container-fluid">
		
		<section id="entorno" class="main row">
		
			<aside id="herramientas-izda" class="col-xs-12 col-sm-1 col-md-1 col-lg-2">
			
				<div class="pull-left">
					<button type="button" class="btn btn-default free free-uniE905">sdkjfsldf lksj dhfkhs akhf</button>
				</div>
				
				<div class="pull-left">
					<button type="button" class="btn btn-default">Default</button>
				</div>
				
				<div class="pull-left">
					<button type="button" class="btn btn-default">Default</button>
				</div>

			</aside>
			
			<article class="col-xs-12 col-sm-11 col-md-9 col-lg-8">
			
				<div id="barra-menus">
					<p>
						Frankfurter bresaola spare ribs, ham drumstick venison swine pork belly chuck tenderloin pork loin tri-tip tail turducken kevin. Turducken tongue ham hock fatback jowl picanha tenderloin sirloin meatloaf. Corned beef sirloin ball tip turducken capicola ribeye. Bacon leberkas bresaola landjaeger filet mignon pork loin. Capicola landjaeger cupim shank. Ribeye hamburger pancetta filet mignon beef ribs corned beef capicola.
					</p>
				</div>

				<div id="canvas">
					<canvas id="canvas_croquis" style="width:100%; border:0px solid #d3d3d3;">Su navegador no soporta Canvas. Instale la última versión de Chrome</canvas>
				</div>
				
				<div id="controles" class="clearfix">
					<span class="col-xs-5">
						<input type="file" id="control_imagen" name="control_imagen" accept="image/jpeg" onchange="abrirImagen(this.value);"/> <!-- images/* o image/jpeg, image/bmp, image/png, image/gif y atributo disabled-->
					</span>
					
					<span class="col-xs-2">
						<input type="color" id="control_color" name="control_color"/>
					</span>
					
					<span class="col-xs-3 col-md-offset-2">
						<input type="range" id="control_zoom" name="control_zoom"  min="0" max="10"/>
					</span>
				</div>
				
			</article>
			
			<aside id="herramientas-dcha" class="col-xs-12 col-sm-12 col-md-2 col-lg-2">
				<p>
					Incluir un video explicativo
					Pig salami kielbasa, turducken hamburger turkey strip steak shankle ham hock tenderloin cupim. Pork loin tenderloin doner strip steak beef turkey. Tail shank swine tri-tip alcatra pig cupim filet mignon meatball capicola jerky chuck ham venison. Chuck salami shank, tenderloin alcatra ball tip brisket corned beef flank pig short ribs pork loin t-bone meatloaf cupim.
				</p>
			</aside>
			
		</section>
		
		<footer>
			<div class="container">
				<h3>pie de pagina</h3>
			</div>
		</footer>
	
	</div>
	
	<!--  jQuery -->
	<script src="js/jquery-2.1.4.min.js"></script>
	
	<!-- Bootstrap minified JavaScript -->
  	<script src="js/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
</body>
</html>
