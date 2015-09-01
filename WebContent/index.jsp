<!doctype html>

<html lang="es">

	<head>
	
		<base href="<%=request.getContextPath()%>/">
		
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		
		<title>Canvas</title>
		<meta name="description" content="Horma Studio, crea tus propias vías de escalada">
		<meta name="author" content="Unai Perea Cruz">
		
		<!-- Estilos CSS -->
		<link rel="stylesheet" type="text/css" href="css/styles.css?v=1.0">
		
		<!-- Responsive Design -->
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
		
		<!-- Bootstrap minified CSS -->
		<link rel="stylesheet" href="js/bootstrap-3.3.5-dist/css/bootstrap.min.css">
		
		<!-- Font Awesome -->		
		<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.4.0/css/font-awesome.min.css">
		
		<style>
			body{background-color: purple;}
	  		#canvas{background-color: #414141; cursor: none;} /* crosshair ----- cursor: url(img/dot.png), pointer; }*/
	  		#control_pincel, #control_reunion, #control_borrar{ cursor: pointer;}
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
					<span id="control_guardar" class="btn btn-default">Guardar im&aacute;gen</span>
					<a id="descargar" href="#" target="_blank">Descargar</a>
					
					<ul class="pull-right">
						<li><span id="control_pincel" class="fa fa-paint-brush boton_pulsado fa-2x"></span></li>
						<!-- <li><span id="control_reunion" class="icon-radio-checked boton_hover boton_no_pulsado" style="font-size: 30px"></span></li> -->
						<li><span id="control_reunion" class="fa fa-dot-circle-o boton_hover boton_no_pulsado fa-2x"></span></li>
						<li><span id="control_borrar" class="fa fa-eraser boton_hover boton_no_pulsado fa-2x"></span></li>
						<li><span id="control_mover" class="fa fa-hand-paper-o boton_hover boton_no_pulsado fa-2x"></span></li>
						<!-- <li><span class="icon-image" style="font-size: 30px"></span></li> -->
					
						<!-- <li><span class="icon-photo" style="font-size: 40px"></span> <a href="#">Contact></a></li>
						<li><span class="icon-minus" style="font-size: 40px"></span> <a href="#">Archive</a></li>
						<li><span class="icon-plus" style="font-size: 40px"></span> <a href="#">Contact></a></li>
						<li><span class="icon-location" style="font-size: 40px"></span> <a href="#">Contact></a></li>
						<li><span class="fa fa-search-plus" style="font-size: 40px"></span> <a href="#">Contact></a></li>
						<li><span class="fa fa-search-minus" style="font-size: 40px"></span> <a href="#">Contact></a></li> -->
					</ul>
				</aside>
				<!-- <div class="clearfix visible-sm-block"></div> -->
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
						<div class="col-xs-3">
							<p>Abrir im&aacute;gen:</p>
							<input type="file" id="control_imagen" name="control_imagen" accept="image/jpeg"/><!-- images/* o image/jpeg, image/bmp, image/png, image/gif y atributo disabled-->
						</div>
						
						<div class="col-xs-2">
							<p>Color:</p>
							<input type="color" id="control_color" name="control_color" onchange="getColor();"/>
						</div>
						<div id="grosor" class="col-xs-3">
							<p>Tama&ntilde;o:<input type="text" id="grosor_texto" size="2" readonly/></p>
							<div class="flotar_izda">
								<span id="grosor_menos" class="fa fa-minus-square-o" style="font-size: 25px" onclick="moverGrosor('abajo');"></span>
							</div>
							<div class="flotar_izda">
								<input type="range" id="control_grosor" name="control_grosor" class="zoom-range" min="2" max="50" onchange="setGrosor();"  style="margin-top: 1px"/>
							</div>
							<div class="flotar_izda">
								<span id="grosor_mas" class="fa fa-plus-square-o" style="font-size: 25px" onclick="moverGrosor('arriba');"></span>
							</div>
						</div>
						<div id="zoom" class="col-xs-3">
							<p>Zoom:
								<input type="text" id="zoom_texto" size="2" readonly/>
								<input type="button" id="zoom_restaurar" name="zoom_restaurar" onclick="resetZoom();" value="Reset"/>
							</p>
							<div class="flotar_izda">
								<span id="zoom_menos" class="fa fa-minus-square-o" style="font-size: 25px" onclick="moverZoom('abajo');"></span>
							</div>
							<div class="flotar_izda">
								<input type="range" id="control_zoom" name="control_zoom" class="zoom-range" onchange="setZoom();"  style="margin-top: 1px"/>
							</div>
							<div class="flotar_izda">
								<span id="zoom_mas" class="fa fa-plus-square-o" style="font-size: 25px" onclick="moverZoom('arriba');"></span>
							</div>
						
							<!-- <i class="col-xs-1 fa fa-minus-square-o" style="font-size: 15px"> -->
							<!-- <input type="range" id="control_zoom" name="control_zoom"  min="0" max="10" onchange="setZoom();"/> -->
							<!-- <i class="col-xs-1 fa fa-plus-square-o" style="font-size: 15px"> -->
						</div>
					</div>
					
				</article>
				
				<aside id="herramientas-dcha" class="col-xs-12 col-sm-12 col-md-2 col-lg-2">
					<p>
						<!-- TODO Incluir un video explicativo -->
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
		
		<!-- Paper.js dibujo en Canvas -->
		<script type="text/javascript" src="js/paperjs-v0.9.23/dist/paper-full.js" canvas="canvas_croquis"></script>
		
		<!--  jQuery -->
		<script src="js/jquery-2.1.4.min.js"></script>
		
		<!-- JQuery MouseWheel -->
		<script type='text/javascript' src='js/jquery.mousewheel.min.js'></script>
		
		<script type="text/javascript">
	
	  	//Variables para que se pueda interactuar entre los botones y el canvas
	  	var canvas; //Para getMousePos(); sino meterlo dentro de onload
		var imagenRaster;
		var controlPincel;
		var controlReunion;
		var controlBorrar;
		var controlMover;
		var reunionColor;
		var reunionRadio;
		var vectorColor;
		var vectorGrosor;
		var cursorTamanoPincel;
		var posicionRaton;
		var upperZoomLimit;
	    var lowerZoomLimit;
		
		//TODO No sé si es paper.project. ....
		
	  	paper.install(window);
		//Only executed our code once the DOM is ready.
		window.onload = function() {
	
		//Atributos de hitTest (eventos provocados por el ratón al clickar sobre un item/Path/Segmento/Stroke
		var hitOptions = null;
		
		//Atributos de los vectores
		var vectorRedondezPunta;
		var cursorColor;					/*** CURSOR ***/
		var hitTestTolerancia;
		var nodoTamano;
	
		//Declaramos variables
		var capaImagen;
		var capaVectorial;
		var capaGenerica; //Para cualquier otro objeto que afecte al dibujo
		var capaCursor;					/*** CURSOR ***/
		
		var contexto;
		
		var segment, path; //variables para saber qué item y en qué parte del item se ha clickado
		var moverPath = false; //Controla el movimiento en bloque del item
		var dibujar = false; //Controla si se va a dibujar o no
		var rutaImagen = "http://localhost:8080/HormaStudio/img/Ametzorbe300x401.jpg";
		
		var circuloReunion; //No sé si es imprescindible
		//var rReunion; //Para si agrupamos el círculo con la letra R en el centro 
		//var grupoReunion //circuloReunion y  rReunion agrupados
		
		var rectangulo;
		var esquinaTamano;
		var teclaContorno; 
		var teclaPulsada;
		var grupoTecla; //teclaPulsada y teclaContorno agrupados (Tool Tip Text)
		
		inicializarEntorno();
		inicializarCanvas();
		inicializarCapas(); //Creamos las capas (imágen, líneas)
		inicializarDibujoVectorial();
		cargarImagen(rutaImagen);
		inicializarControles();
		inicializarToolTip();
	
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
		    tool = new paper.Tool(); //Crea una herramienta para manejar los eventos del teclado y ratón. Machaco la var tool ya existente
		    
		    //Zoom
		    paper.tool.distanceThreshold = 8;
		    paper.tool.mouseStartPos = new paper.Point();
		    paper.tool.zoomFactor = 1.3;
		    lowerZoomLimit = 1;
		    upperZoomLimit = 10;
		    
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
			
			//Opciones HitTest
			hitOptions = {
					segments: true, //para clickar en los nodos
					stroke: true, //para clickar en las líneas
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
				//contexto.clearRect(0, 0, canvas.width, canvas.height); //PROBAAAAAAAAR
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
			controlPincel = true;
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
			
			//PROBAR CON contexto.width;Return the dimensions of the bitmap, in CSS pixels. Can be set, to update the bitmap's dimensions. If the rendering context is bound to a canvas, this will also update the canvas' intrinsic dimensions.
			/*canvas.onmousemove = function (e) { 
			   var x = e.pageX - this.offsetLeft;
			   var y = e.pageY - this.offsetTop;
			
			   var div = document.getElementById("coords");
			   div.innerHTML = "x: " + x + " y: " + y; 
			};*/
			
			//cnvs.width = mirror.width = window.innerWidth;
			
			var MAX_WIDTH = $('#canvas_croquis').width();//$('#entorno').width(); //Anchura del div
			var MAX_HEIGHT = $('#canvas_croquis').height();//$('#entorno').height(); //Altura del div
			var tempW = imagenRaster.width;
			var tempH = imagenRaster.height;
			
			//TODO En vez de escalar la imágen al cargarla que le haga Zoom y que el tamaño del canvas no se modifique nunca******************
			
			if (tempW > tempH){ //Si la anchura de la imágen es mayor que la altura de la imágen se coge la anchura de la imágen
				if (tempW > MAX_WIDTH){ //Si la imágen es mayor (en cuanto a anchura) que la del canvas, que permanezca la anchura del canvas
					//Pero si la altura sigue siendo más grande que el canvas se reduce con respecto a lo alto del canvas
					if (Math.floor((tempH * MAX_WIDTH) / tempW) > MAX_HEIGHT){
						//Reducir imágen según altura del canvas
						tempW = Math.floor((tempW * MAX_HEIGHT) / tempH);
						imagenRaster.height = tempH = MAX_HEIGHT;
						canvas.width = imagenRaster.width = tempW;
						canvas.style.width = tempW + 'px'; //Le da más calidad
					}else{
						//Reducir imágen según anchura del canvas
						tempH = Math.floor((tempH * MAX_WIDTH) / tempW); //Redondeo hacia abajo el redimensionamiento
						imagenRaster.width = tempW = MAX_WIDTH; //OJO CON EL MARCO DEL CANVAS
						canvas.height = imagenRaster.height = tempH;
						canvas.style.height = tempH + 'px';
					}
				}else{ //Reducir canvas
					canvas.width = tempW;
					canvas.style.width = tempW + 'px'; //Le da más calidad
					canvas.height = tempH;
					canvas.style.height = tempH + 'px'; //Le da más calidad
				}
			}else{ //Si la altura de la imágen es mayor que la anchura de la imágen se coge la altura de la imágen
				if (tempH > MAX_HEIGHT){ //Si la imágen es mayor (en cuanto a altura) que la del canvas, que permanezca la altura del canvas
					//Pero si la anchura sigue siendo más grande que el canvas se reduce con respecto a lo ancho del canvas
					if (Math.floor((tempW * MAX_HEIGHT) / tempH) > MAX_HEIGHT){
						//Reducir imágen
						tempW = Math.floor((tempW * MAX_HEIGHT) / tempH);
						imagenRaster.height = tempH = MAX_HEIGHT;
						canvas.width = imagenRaster.width = tempW;
						canvas.style.width = tempW + 'px'; //Le da más calidad
					}else{
						//Reducir imágen según anchura del canvas
						tempH = Math.floor((tempH * MAX_WIDTH) / tempW); //Redondeo hacia abajo el redimensionamiento
						imagenRaster.width = tempW = MAX_WIDTH; //OJO CON EL MARCO DEL CANVAS
						canvas.height = imagenRaster.height = tempH;
						canvas.style.height = tempH + 'px';
					}
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
		
		function inicializarControles(){
			controlPincel = true;
			controlReunion = false;
			controlBorrar = false;
			
			//ColorPicker
			document.getElementById("control_color").value = "#0000FF";
			
			//Tamaño pincel
			document.getElementById("control_grosor").value = vectorGrosor;
			document.getElementById("grosor_texto").value = vectorGrosor;
			
			//Zoom
			document.getElementById("control_zoom").value = lowerZoomLimit;
			document.getElementById("zoom_texto").value = lowerZoomLimit;
			$("#control_zoom")[0].min = lowerZoomLimit;
	        $("#control_zoom")[0].max = upperZoomLimit;
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
			//circuloReunion.position = path.getPointAt(0,0); //posición inicial. NO creo
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
				//circuloReunion.position = path.getPointAt(0,0); //posición inicial. NO creo
				*/
				
			/*} else{*/
				//Obtenemos dónde se ha pulsado el ratón 
			var hitResult = project.hitTest(event.point, hitOptions);
			var hitClaseItem = hitResult.item.className; //Otra forma más fiable de saber qué item hemos clickado
			var hitNombreItem = hitResult.item.name; //Otra forma para evitar que clicke el tooltiptext
			
			console.info(hitResult.item.name);
			
			//EN MODO DEBUG CON EL CHROME NO ENTRAN LOS MODIFICADORES CONTROL NI SHIFT
			//Si pulsamos CTRL o SHIFT + Click ratón ...
			if (event.modifiers.control && controlPincel && hitNombreItem != "cursor"){ // && hitNombreItem != "cursor"					/*** CURSOR ***/
				//Si se ha pulsado CTRL + CLICK que lo prepare para moverse. Controla si clicka sobre alguno de los elementos del tooltiptext que no lo modifique  
				//if ( hitResult && hitClaseItem != "Raster" && hitNombreItem != "tooltiptext" && hitNombreItem != "textotooltip" && hitNombreItem != "contornotooltip" && (controlReunion || controlPincel)) {
				if (hitResult && hitNombreItem == "vector"){
					moverPath = true;
					path = hitResult.item;
					//project.activeLayer.addChild(hitResult.item); //no sé si hay que incluirlo luego
				}
			}else if (event.modifiers.control && controlReunion && hitNombreItem != "cursor"){ // && hitNombreItem != "cursor"					/*** CURSOR ***/
				//Si se ha pulsado CTRL + CLICK que lo prepare para moverse. Controla si clicka sobre alguno de los elementos del tooltiptext que no lo modifique  
				//if ( hitResult && hitClaseItem != "Raster" && hitNombreItem != "tooltiptext" && hitNombreItem != "textotooltip" && hitNombreItem != "contornotooltip" && (controlReunion || controlPincel)) {
				if (hitResult && hitNombreItem == "reunion"){
					moverPath = true;
					path = hitResult.item;
					//project.activeLayer.addChild(hitResult.item); //no sé si hay que incluirlo luego
				}
			}else if (event.modifiers.shift && controlPincel) {
				//pulsando SHIFT + CLICK en el segmento/nodo borra el nodo     			// && hitNombreItem != "cursor"					/*** CURSOR ***/
				if ( hitResult && hitClaseItem != "Raster" && !hitResult.item.hasFill() && hitNombreItem != "cursor" && !controlReunion && !controlBorrar) { //Si hemos hecho click sobre algo y que no sea la imágen y si ha sido en una reunion que no la modifique
					if (hitResult.type == 'segment') {
						hitResult.segment.remove();
					}
				}
			}else if (controlReunion){ //Si se ha pulsado el botón de Reunión que cree una nueva reunión al clickar sobre el canvas
				console.info("controlReunion = true");
				circuloReunion = new paper.Path.Circle({
					center: event.point,
					radius: reunionRadio,
					fillColor: reunionColor,
					name: "reunion"
					});
			}else if (controlPincel){ //si no se ha pulsado ningún item o se ha clickado sobre el raster/imágen que cree un nuevo path y en onMouseDrag se dibuja
				 //|| hitNombreItem == "cursor"					/*** CURSOR ***/
				if (!hitResult || hitClaseItem === "Raster" || hitResult.type == "fill" || hitNombreItem == "cursor"){ //si hitResult=null o se ha clickado sobre la imágen o sobre un objeto con relleno/Reunión
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
					//si pulsa en cualquier lugar del path y que no sea sobre el raster/imágen...
					console.info("guardamos el path clickado");
					path = hitResult.item; //guardamos el path sobre el que se ha pulsado
					
					if (hitResult.type == 'segment') {
						//Y si se ha pulsado sobre un segmento/nodo del propio path
						console.info("onMouseDown guardamos el path clickado y segment.point");
						segment = hitResult.segment; //guardamos el segmento/nodo del propio path
		
					} else if (hitResult.type == 'stroke') {
						//Y si se ha pulsado sobre la línea del propio path
						console.info("onMouseDown guardamos el path clickado");
						var location = hitResult.location;
						segment = path.insert(location.index + 1, event.point); //inserta un nodo y lo guardamos
						path.smooth(); //Suaviza el nuevo vértice
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
		*  Mientras esté encima de un item se selecciona
		*/
	 	//Sólo cuando pasamos por encima de un vector se selecciona (la imágen no)
		tool.onMouseMove = function(event){
			console.info("Ha entrado en onMouseMove");
			//paper.tool.mouseStartPos = new Point(event.point); //Para el zoom
			//Obtengo la posición del cursor para hacer Zoom
			//posicionRaton = getPosicionRaton(canvas, event);
			posicionRaton = canvas.getBoundingClientRect(); //Recojo la posición del ratón en la ¿¿pantalla??. Para el Zoom
	
		    //posx = posicionRaton.x;
		    //posy = posicionRaton.y;
	
			//movemos el el círculo del tamaño del pincel con el cursor.					/*** CURSOR ***/
			moverCursor(event.point);
			
			project.activeLayer.selected = false;
			
			//Que sólo seleccione los vectores y las reuniones. Ni la imágen ni ninguno de los elementos del tooltiptext 
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
		
		/**Cuando arrastremos el ratón con el botón pulsado ...
		*  1.- moveremos el Path completo si se había pulsado CTRL
		*  2.- arrastraremos el segmento/nodo si se haía pulsado sobre él
		*  3.- arrastraremos el el nuevo segmento/nodo que acabamos de crear si se haía pulsado sobre la línea/Path
		*/
		tool.onMouseDrag = function(event){
			console.info("Ha entrado en onMouseDrag");
			
			if (dibujar){
				//TODO controlar que no salga del límite de la imágen y/o del canvas. Controlar cuando tiene zoom
				console.info("dibujar");
				path.add(event.point);
				console.info("Pos. nuevo punto: " + event.point);
			}else{
				console.info("dibujar ELSE");
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
			//movemos el círculo del tamaño del pincel con el cursor.					/*** CURSOR ***/
			moverCursor(event.point);
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
		
		function moverCursor(punto){
			//TODO controlar que cuando se salga de los límites desaparezca el círculo del cursor
			if (project.activeLayer != capaCursor){capaCursor.activate();}
			if (cursorTamanoPincel.visible == false){cursorTamanoPincel.visible = true;}
			cursorTamanoPincel.position.x = punto.x;//event.point.x;
			cursorTamanoPincel.position.y = punto.y;//event.point.y;
			if (project.activeLayer != capaVectorial){capaVectorial.activate();}
			console.info("cursor: " & cursorTamanoPincel.position.x & ", " & cursorTamanoPincel.position.y);
		}
		
	} // End window.onload()
	
		/*************************
		* FUNCIONES DE CONTROLES *
		**************************/
		
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
				rutaImagen = "http://localhost:8080/HormaStudio/img/Ametzorbe300x401.jpg"; //le paso una imágen para probar ya que el proceso sería: 1.- Escalara al tamaño del canvas 2.- subirlo a la web
				cargarImagen(rutaImagen);
			}
		}
		
		control_pincel.onclick = function( event ){
			var botonAuxPincel = document.getElementById("control_pincel");
			var botonAuxReunion = document.getElementById("control_reunion");
			var botonAuxBorrar = document.getElementById("control_borrar");
			var botonAuxMover = document.getElementById("control_mover");
			
			if ( botonAuxPincel.classList.contains("boton_no_pulsado") ){ //Si NO está pulsado boton_pincel lo clickamos
				botonAuxPincel.classList.remove("boton_hover");
				botonAuxPincel.classList.toggle("boton_no_pulsado");
				botonAuxPincel.classList.add("boton_pulsado");
				//document.getElementById("control_color").disabled = false;
				//document.getElementById("control_color").value = vectorColor;
				canvas.classList.remove("cursor_mover");
				habilitarControles();
				controlPincel = true;
				controlReunion = false;
				controlBorrar = false;
				controlMover = false;
				if ( botonAuxReunion.classList.contains("boton_pulsado") ){ //Si está pulsado boton_reunion lo desclickamos
					botonAuxReunion.classList.remove("boton_pulsado");
					botonAuxReunion.classList.add("boton_hover");
					botonAuxReunion.classList.toggle("boton_no_pulsado");
				}else if ( botonAuxBorrar.classList.contains("boton_pulsado") ){ //Si está pulsado boton_borrar lo desclickamos
					botonAuxBorrar.classList.remove("boton_pulsado");
					botonAuxBorrar.classList.add("boton_hover");
					botonAuxBorrar.classList.toggle("boton_no_pulsado");
				}else if ( botonAuxMover.classList.contains("boton_pulsado") ){ //Si está pulsado boton_borrar lo desclickamos
					botonAuxMover.classList.remove("boton_pulsado");
					botonAuxMover.classList.add("boton_hover");
					botonAuxMover.classList.toggle("boton_no_pulsado");
				}
			}
			botonAuxPincel = null;
			botonAuxReunion = null;
			botonAuxBorrar = null;
			botonAuxMover = null;
		}
		
		control_reunion.onclick = function( event ){
			var botonAuxPincel = document.getElementById("control_pincel");
			var botonAuxReunion = document.getElementById("control_reunion");
			var botonAuxBorrar = document.getElementById("control_borrar");
			var botonAuxMover = document.getElementById("control_mover");
			
			if ( botonAuxReunion.classList.contains("boton_no_pulsado") ){ //Si NO está pulsado boton_pincel lo clickamos
				botonAuxReunion.classList.remove("boton_hover");
				botonAuxReunion.classList.toggle("boton_no_pulsado");
				botonAuxReunion.classList.add("boton_pulsado");
				//document.getElementById("control_color").disabled = false;
				//document.getElementById("control_color").value = reunionColor;
				canvas.classList.remove("cursor_mover");
				habilitarControles();
				controlPincel = false;
				controlReunion = true;
				controlBorrar = false;
				controlMover = false;
				if ( botonAuxBorrar.classList.contains("boton_pulsado") ){ //Si está pulsado boton_borrar lo desclickamos
					botonAuxBorrar.classList.remove("boton_pulsado");
					botonAuxBorrar.classList.add("boton_hover");
					botonAuxBorrar.classList.toggle("boton_no_pulsado");
				}else if ( botonAuxPincel.classList.contains("boton_pulsado") ){ //Si está pulsado boton_reunion lo desclickamos
					botonAuxPincel.classList.remove("boton_pulsado");
					botonAuxPincel.classList.add("boton_hover");
					botonAuxPincel.classList.toggle("boton_no_pulsado");
				}else if ( botonAuxMover.classList.contains("boton_pulsado") ){ //Si está pulsado boton_borrar lo desclickamos
					botonAuxMover.classList.remove("boton_pulsado");
					botonAuxMover.classList.add("boton_hover");
					botonAuxMover.classList.toggle("boton_no_pulsado");
				}
			}
			botonAuxPincel = null;
			botonAuxReunion = null;
			botonAuxBorrar = null;
			botonAuxMover = null;
		}
		
		control_borrar.onclick = function( event ){
			var botonAuxPincel = document.getElementById("control_pincel");
			var botonAuxReunion = document.getElementById("control_reunion");
			var botonAuxBorrar = document.getElementById("control_borrar");
			var botonAuxMover = document.getElementById("control_mover");
			
			if ( botonAuxBorrar.classList.contains("boton_no_pulsado") ){ //Si NO está pulsado boton_pincel lo clickamos
				botonAuxBorrar.classList.remove("boton_hover");
				botonAuxBorrar.classList.toggle("boton_no_pulsado");
				botonAuxBorrar.classList.add("boton_pulsado");
				//document.getElementById("control_color").disabled = true;
				canvas.classList.remove("cursor_mover");
				deshabilitarControles();
				controlPincel = false;
				controlReunion = false;
				controlBorrar = true;
				controlMover = false;
				if ( botonAuxReunion.classList.contains("boton_pulsado") ){ //Si está pulsado boton_borrar lo desclickamos
					botonAuxReunion.classList.remove("boton_pulsado");
					botonAuxReunion.classList.add("boton_hover");
					botonAuxReunion.classList.toggle("boton_no_pulsado");
				}else if ( botonAuxPincel.classList.contains("boton_pulsado") ){ //Si está pulsado boton_reunion lo desclickamos
					botonAuxPincel.classList.remove("boton_pulsado");
					botonAuxPincel.classList.add("boton_hover");
					botonAuxPincel.classList.toggle("boton_no_pulsado"); 
				}else if ( botonAuxMover.classList.contains("boton_pulsado") ){ //Si está pulsado boton_borrar lo desclickamos
					botonAuxMover.classList.remove("boton_pulsado");
					botonAuxMover.classList.add("boton_hover");
					botonAuxMover.classList.toggle("boton_no_pulsado");
				}
			}
			botonAuxPincel = null;
			botonAuxReunion = null;
			botonAuxBorrar = null;
			botonAuxMover = null;
		}
		
		control_mover.onclick = function ( event ){
			var botonAuxPincel = document.getElementById("control_pincel");
			var botonAuxReunion = document.getElementById("control_reunion");
			var botonAuxBorrar = document.getElementById("control_borrar");
			var botonAuxMover = document.getElementById("control_mover");
			
			if ( botonAuxMover.classList.contains("boton_no_pulsado") ){ //Si NO está pulsado boton_pincel lo clickamos
				botonAuxMover.classList.remove("boton_hover");
				botonAuxMover.classList.toggle("boton_no_pulsado");
				botonAuxMover.classList.add("boton_pulsado");
				//document.getElementById("control_color").disabled = true;
				canvas.classList.add("cursor_mover");
				//TODO deshabilitar cursor
				cursorTamanoPincel.visible = false; //TODO En onMouseMove lo hace visible = true siempre asique no puede funcionar
				deshabilitarControles();
				controlPincel = false;
				controlReunion = false;
				controlBorrar = false;
				controlMover = true;
				if ( botonAuxReunion.classList.contains("boton_pulsado") ){ //Si está pulsado boton_borrar lo desclickamos
					botonAuxReunion.classList.remove("boton_pulsado");
					botonAuxReunion.classList.add("boton_hover");
					botonAuxReunion.classList.toggle("boton_no_pulsado");
				}else if ( botonAuxPincel.classList.contains("boton_pulsado") ){ //Si está pulsado boton_reunion lo desclickamos
					botonAuxPincel.classList.remove("boton_pulsado");
					botonAuxPincel.classList.add("boton_hover");
					botonAuxPincel.classList.toggle("boton_no_pulsado"); 
				}else if ( botonAuxBorrar.classList.contains("boton_pulsado") ){ //Si está pulsado boton_borrar lo desclickamos
					botonAuxBorrar.classList.remove("boton_pulsado");
					botonAuxBorrar.classList.add("boton_hover");
					botonAuxBorrar.classList.toggle("boton_no_pulsado");
				}
			}
			botonAuxPincel = null;
			botonAuxReunion = null;
			botonAuxBorrar = null;
			botonAuxMover = null;
		}
		
		function deshabilitarControles(){
			document.getElementById("control_grosor").disabled = true;
			document.getElementById("control_color").disabled = true;
		}
		
		function habilitarControles(){
			document.getElementById("control_grosor").disabled = false;
			document.getElementById("control_color").disabled = false;
		}	
		control_guardar.onclick = function( event ){
			
			/*
			//var capaActual = paper.project.activeLayer; //capa activa actual
			var capaGuardar = new paper.Layer();
			capaGuardar.name= "capa guardar";
			capaGuardar.activate;
			
			//if ( capaGuardar.addChildren(capaImagen.children[1]) != null ){
				if ( capaGuardar.addChildren(capaVectorial.children) ){
					console.info("Capa Guardar creada con todos los elementos");
				}
			//}
			*/
	
			//for ( i=0 ; i<project.layers.length ; i++ ){}
			//var tempImg = project.activelayer.rasterize(300); //rasterize tiene el parámetro "resolución" o paper.proj...
			var mimeType = "image/jpeg";
			var calidad = 1.0; //La calidad más alta
			//var dataString = tempImg.toDataURL(mimeType);
			var dataString = document.getElementById("canvas_croquis").toDataURL(mimeType, calidad);
			//tempImg.remove();
			document.getElementById("descargar").href = dataString;
			//downloadme.href = canvasImg.src;
			//window.open(dataString, "toDataURL() image", "width=800, height=200");//Abre en una nueva ventana la imágen
			
			
		}
		
		function descargarImagen() {
		    // feel free to choose your event ;) 
	
		    // just for example
		    // var OFFSET = $(this).offset();
		    // var x = event.pageX - OFFSET.left;
		    // var y = event.pageY - OFFSET.top;
	
		    // standard data to url
		    var imgdata = document.getElementById("canvas_croquis").toDataURL("image/png");
		    // modify the dataUrl so the browser starts downloading it instead of just showing it
		    var newdata = imgdata.replace(/^data:image\/png/,'data:application/octet-stream');
		    // give the link the values it needs
		       $('a.linkwithnewattr').attr('download','your_pic_name.png').attr('href',newdata);
		}
		
		function img_and_link() {
			$('body').append(
				    $('<a>')
				      .attr('href-lang', 'image/png')
				      .attr('href', 'data:image/png;utf8,' +  unescape($('png').outerHTML))
				      .text('Download')
				  );
			  /*$('body').append(
			    $('<a>')
			      .attr('href-lang', 'image/svg+xml')
			      .attr('href', 'data:image/svg+xml;utf8,' +  unescape($('svg')[0].outerHTML))
			      .text('Download')
			  );*/
			}
		
		function getColor(){
			if (controlPincel){
				vectorColor = document.getElementById("control_color").value;
			}else if (controlReunion){
				reunionColor = document.getElementById("control_color").value;
			}
		}
		
		function setGrosor(){
			document.getElementById("grosor_texto").value = document.getElementById("control_grosor").value;
			if (controlPincel) {
				vectorGrosor = document.getElementById("control_grosor").value;
			}else if (controlReunion){
				reunionRadio = document.getElementById("control_grosor").value;
			}
			//Tamaño de cursor
			var radioNuevo = (cursorTamanoPincel.bounds.width + cursorTamanoPincel.strokeWidth) / 2; //seteamos el radio sumando (el ancho total del círculo + el grosor de la línea exterior) / 2
			cursorTamanoPincel.scale((vectorGrosor/2)/radioNuevo);
		}
		
		function moverGrosor(direccion){
			if (controlPincel || controlReunion){
				if (direccion == "arriba"){
					document.getElementById("control_grosor").stepUp(1);
				}else if (direccion == "abajo"){
					document.getElementById("control_grosor").stepDown(1);
				}
				setGrosor();
			}
		}
		
		function setZoom(){ //Al mover el slider del Zoom
			var z = document.getElementById("control_zoom").value - document.getElementById("zoom_texto").value;
			if (z>0){ //Si es positivo hago zoom
				for (i=0 ; i < z ; i++){
					setMasZoom();
				}
			}else{ //Si es negativo quito zoom
				z*=-1; //Lo convierto a positivo
				for (i=0 ; i < z ; i++){
					setMenosZoom();
				}
			}
			document.getElementById("zoom_texto").value = document.getElementById("control_zoom").value;
		}
	
		function moverZoom(direccion){ //Al pulsar - o + del Zoom
			var controlZoom = document.getElementById("control_zoom");
			if (direccion == "arriba"){
				if (controlZoom.value < upperZoomLimit){
					controlZoom.stepUp(1);
					setMasZoom();
				}
			}else if (direccion == "abajo"){
				if (controlZoom.value > lowerZoomLimit){
					controlZoom.stepDown(1);
					setMenosZoom();
				}
			}
			document.getElementById("zoom_texto").value = document.getElementById("control_zoom").value;
		}
	
		function setMasZoom(){
	       	//var children = project.activeLayer.children;
	       	if (paper.view.zoom < upperZoomLimit) { 
	               //scroll up
	               //var point = paper.DomEvent.getOffset(e.originalEvent, $('#canvas_croquis')[0]);
	               
	   			//var point = $('#canvas_croquis').offset(); //var
	   		    //var x = event.clientX - posicionRaton.left; //De la posición del ratón dentro de la pantalla calculamos la posición X dentro del canvas
	   			//var y =  event.clientY - posicionRaton.top; //De la posición del ratón dentro de la pantalla calculamos la posición Y dentro del canvas
	   			point = paper.view.viewToProject(imagenRaster.view.center); //point //Convertimos a coordenadas dentro del proyecto
	            var zoomCenter = point.subtract(paper.view.center);
	            var moveFactor = tool.zoomFactor - 1.0;
	            paper.view.zoom *= tool.zoomFactor;
	            paper.view.center = paper.view.center.add(zoomCenter.multiply(moveFactor / tool.zoomFactor));
	            tool.mode = '';
	        }
		}
		
		function setMenosZoom(){
			if (paper.view.zoom > lowerZoomLimit){ //scroll down
	            //var point = paper.DomEvent.getOffset(e.originalEvent, $('#canvas_croquis')[0]);
	
				//var point = $('#canvas_croquis').offset();
				
				//var x = event.clientX - posicionRaton.left; //De la posición del ratón dentro de la pantalla calculamos la posición X dentro del canvas
				//var y =  event.clientY - posicionRaton.top; //De la posición del ratón dentro de la pantalla calculamos la posición Y dentro del canvas
				var point = paper.view.viewToProject(paper.view.center); //point //Convertimos a coordenadas dentro del proyecto
	            var zoomCenter = point.subtract(paper.view.center);   
	            var moveFactor = tool.zoomFactor - 1.0;
	            paper.view.zoom /= tool.zoomFactor;
	            paper.view.center = paper.view.center.subtract(zoomCenter.multiply(moveFactor))
	        }
		}
	
		function resetZoom(){
			//TODO
		}
		
		$("#canvas_croquis").mousewheel(function(event, delta) {
	    	var delta = 0;
	        //var children = project.activeLayer.children;
			var zTexto = document.getElementById("zoom_texto");
	        var zControl = document.getElementById("control_zoom");
	            
	        event.preventDefault();
	        event = event || window.event;
	        if (event.type == 'mousewheel') {       //this is for chrome/IE
	                delta = event.originalEvent.wheelDelta;
	            }
	            else if (event.type == 'DOMMouseScroll') {  //this is for FireFox
	                delta = event.originalEvent.detail*-1;  //FireFox reverses the scroll so we force to to re-reverse...
	            }
	
	        if((delta > 0) && (paper.view.zoom < upperZoomLimit)) { //scroll up
	            //var point = paper.DomEvent.getOffset(e.originalEvent, $('#canvas_croquis')[0]);
				//point = $('#canvas_croquis').offset(); //var
			    var x = event.clientX - posicionRaton.left; //De la posición del ratón dentro de la pantalla calculamos la posición X dentro del canvas
				var y =  event.clientY - posicionRaton.top; //De la posición del ratón dentro de la pantalla calculamos la posición Y dentro del canvas
				var point = paper.view.viewToProject(x,y); //point //Convertimos a coordenadas dentro del proyecto
	            var zoomCenter = point.subtract(paper.view.center);
	            var moveFactor = tool.zoomFactor - 1.0;
	            paper.view.zoom *= tool.zoomFactor;
	            paper.view.center = paper.view.center.add(zoomCenter.multiply(moveFactor / tool.zoomFactor));
	            tool.mode = '';
	            zTexto.value = parseInt(zTexto.value) + 1;
	            zControl.value = parseInt(zControl.value) + 1;
	        }
	        else if((delta < 0) && (paper.view.zoom > lowerZoomLimit) && (paper.view.zoom != 1.0000000000000002)){ //scroll down //Como paper.view.zoom se queda en 1.0000000000002 hace un zoom de más por lo que lo evito poniéndolo en las condición
				//TODO cuando llegue al nivel máximo de zoom se quede en el medio del canvas 
				
	        	//var point = paper.DomEvent.getOffset(e.originalEvent, $('#canvas_croquis')[0]);
				//var point = $('#canvas_croquis').offset();
				
				var x = event.clientX - posicionRaton.left; //De la posición del ratón dentro de la pantalla calculamos la posición X dentro del canvas
				var y =  event.clientY - posicionRaton.top; //De la posición del ratón dentro de la pantalla calculamos la posición Y dentro del canvas
				var point = paper.view.viewToProject(x,y); //point //Convertimos a coordenadas dentro del proyecto
	            var zoomCenter = point.subtract(paper.view.center);   
	            var moveFactor = tool.zoomFactor - 1.0;
	            paper.view.zoom /= tool.zoomFactor;
	            paper.view.center = paper.view.center.subtract(zoomCenter.multiply(moveFactor));
	            zTexto.value = parseInt(zTexto.value) - 1; //Cambiamos el texto del zoom
	            zControl.value = parseInt(zControl.value) - 1; //Cambiamos el slider del zoom
	        }
	    });
			
			        
	    
	
		//El original - Llamada desde onMouseMove QUITARRRRRRRR
		/*function getPosicionRaton(canvas, event) {
		    var rect = canvas.getBoundingClientRect();
		    return {
		      x: event.clientX - rect.left,
		      y: event.clientY - rect.top
		    };
		}*/
		</script>
		
		<!-- Bootstrap minified JavaScript -->
	  	<script src="js/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
	</body>
</html>

