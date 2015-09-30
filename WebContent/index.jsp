<!doctype html>

<!-- Para que salgan acentos -->
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<%@page import="com.hormastudio.Constantes"%>
<html lang="es">

	<head>
	
		<base href="<%=request.getContextPath()%>/">
		
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		
		<title>Canvas</title>
		<meta name="description" content="Horma Studio, crea tus propias vï¿½as de escalada">
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
	  		#control_pincel, #control_reunion, #control_borrar{ cursor: pointer;} /*QuÃ© pasa aquÃ­iii? ***********************/
	  		header{background-color: lime;}
	  		#cabecera{background-color: yellow;}
	  		.container{background-color: grey;}
	  		.menu{background-color: brown;}
	  		#barra-menus{background-color: olive;}
	  		#controles{background-color: orange;}
	  		/* #herramientas-izda{background-color: cyan;} */
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
					<div id="control-archivo">
						<ul>
							<li>
								<!-- SUBIR FICHEROS -->
								<!-- Formulario -->
								<!-- @see: http://www.tutorialspoint.com/servlets/servlets-file-uploading.htm -->
								<form action="<%=Constantes.CONTROLLER_HORMASTUDIO_IMAGEN%>"
									enctype="multipart/form-data"
									method="post"
									role="form">
									<!-- images/* o image/jpeg, image/bmp, image/png, image/gif y atributo disabled-->
									<input type="file" id="control_imagen" name="control_imagen" accept="image/jpeg"/>
									<input type="submit" id="btn_submit" class="btn btn-outline btn-primary" value="Guardar"/>
								</form>
							</li>
							<li><span id="control_guardar" class="btn btn-default">Guardar im&aacute;gen</span></li>
							<li><a id="descargar" href="#" target="_blank" class="invisible">Descargar im&aacute;gen</a></li>
						</ul>
					</div>
					<div id="control-dibujo" class="clearfix">
						<ul>
							<li><i id="ruta">Ruta</i></li>
							<li><i id="reunion">Reunión</i></li>
							<li><i id="borrar">Borrar</i></li>
							<!-- <li><span class="icon-image" style="font-size: 30px"></span></li> -->
						</ul>
						<ul id="iconos-dibujo" class="pull-right">
							<li><span id="control_pincel" class="fa fa-paint-brush boton_pulsado fa-2x"></span></li>
							<li><span id="control_reunion" class="fa fa-dot-circle-o boton_hover boton_no_pulsado fa-2x lista-margen-arriba"></span></li>
							<li><span id="control_borrar" class="fa fa-eraser boton_hover boton_no_pulsado fa-2x lista-margen-arriba"></span></li>
							<!-- <li><span id="control_mover" class="fa fa-arrows boton_hover boton_no_pulsado fa-2x lista-margen-arriba"></span></li> -->
							<!-- <li><span class="icon-image" style="font-size: 30px"></span></li> -->
						</ul>
					</div>
					<div id="control-propiedades" class="clearfix">
						<ul class="pull-right">
							<li>
								<span>Color:</span>
								<input type="color" id="control_color" name="control_color" onchange="getColor();"/>
							</li>
						</ul>
						<ul class="pull-right">
							<li>
								<div id="grosor">
									<p>Tama&ntilde;o:<input type="text" id="grosor_texto" size="1" readonly/></p>
									<div class="flotar_izda">
										<span id="grosor_menos" class="fa fa-minus-square-o" style="font-size: 25px; color: #FFFFFF;" onclick="moverGrosor('abajo');"></span>
									</div>
									<div class="flotar_izda">
										<input type="range" id="control_grosor" name="control_grosor" class="zoom-range" min="2" max="50" onchange="setGrosor();"  style="margin-top: 1px"/>
									</div>
									<div class="flotar_izda">
										<span id="grosor_mas" class="fa fa-plus-square-o" style="font-size: 25px; color: #FFFFFF;" onclick="moverGrosor('arriba');"></span>
									</div>
								</div>
							</li>
						</ul>
				</aside>
				<!-- <div class="clearfix visible-sm-block"></div> -->
				<article id="centro" class="col-xs-12 col-sm-11 col-md-9 col-lg-8 clearfix">
				
					<div id="barra-menus">
						<p>
							<!-- TODO Incluir un video explicativo -->
							Pig salami kielbasa, turducken hamburger turkey strip steak shankle ham hock tenderloin cupim. Pork loin tenderloin doner strip steak beef turkey. Tail shank swine tri-tip alcatra pig cupim filet mignon meatball capicola jerky chuck ham venison. Chuck salami shank, tenderloin alcatra ball tip brisket corned beef flank pig short ribs pork loin t-bone meatloaf cupim.
						</p>
					</div>
	
					<div id="canvas-container">
						<canvas id="canvas_croquis" class="cursor_none" name="imagen">Su navegador no soporta Canvas. Instale la ultima version de Chrome</canvas>
						<div>
							<span id="control_mover" class="fa fa-arrows boton_hover boton_no_pulsado fa-2x cursor_hand"></span>
						</div>
						
						<div id="zoom-container" class="clearfix">
							<div class="flotar_dcha">
								<!-- Al estar dentro de zoom-container no funciona deslizar el slider ********************************** -->
								<span id="zoom_menos" class="fa fa-plus-square-o cursor_hand" style="font-size: 25px;" onclick="moverZoom('arriba');"></span>
							</div>
							<div class="flotar_dcha">
								<!-- <input type="range" id="control_zoom" name="control_zoom" class="bar cursor_hand" onchange="setZoom();" style="margin-top: 1px;"/> -->
								<input type="range" id="control_zoom" name="control_zoom" min="0.13" max="10" onchange="setZoom();"/>
								<!-- <div id="zoom-slider">
									<input class="bar" type="range" id="rangeinput" value="10" onchange="rangevalue.value=value"/>
									<span class="highlight"></span>
									<output id="rangevalue">50</output>
								</div> -->
							</div>
							<div class="flotar_dcha">
								<span id="zoom_mas" class="fa fa-minus-square-o cursor_hand" style="font-size: 25px;" onclick="moverZoom('abajo');"></span>
							</div>
						</div>
						<div id="zoom-1-1" class="cursor_hand" >
							<input type="button" id="zoom_restaurar" name="zoom_restaurar" onclick="resetZoom();" value="1:1"/>
						</div>
					</div>

					<!-- <div id="controles" class="clearfix">
						<div id="zoom" class="col-xs-3">
							<p>Zoom:
								<input type="text" id="zoom_texto" size="2" readonly/>
							</p>
					-->	
							<!-- <i class="col-xs-1 fa fa-minus-square-o" style="font-size: 15px"> -->
							<!-- <input type="range" id="control_zoom" name="control_zoom"  onchange="setZoom();"/> --> 
							<!-- <i class="col-xs-1 fa fa-plus-square-o" style="font-size: 15px"> -->
					<!-- 	</div>
					</div>
					-->
					
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
	  	var contexto;
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
	    //var porcentajeZoom;
	    var ratioZoomFactor;
	    var diferenciaZoom;
	    
	    var capaImagen;
		var capaVectorial;
		
		//TODO No sï¿½ si es paper.project. ....
		
	  	paper.install(window);
		//Only executed our code once the DOM is ready.
		window.onload = function() {
	
		//Atributos de hitTest (eventos provocados por el ratï¿½n al clickar sobre un item/Path/Segmento/Stroke
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
		
		var segment, path; //variables para saber quï¿½ item y en quï¿½ parte del item se ha clickado
		var moverPath = false; //Controla el movimiento en bloque del item
		var dibujar = false; //Controla si se va a dibujar o no
		var rutaImagen = "http://localhost:8080/HormaStudio/img/Ametzorbe766x1024.jpg";
		
		var circuloReunion; //No sï¿½ si es imprescindible
		//var rReunion; //Para si agrupamos el cï¿½rculo con la letra R en el centro 
		//var grupoReunion //circuloReunion y  rReunion agrupados
		
		var rectangulo;
		var esquinaTamano;
		var teclaContorno; 
		var teclaPulsada;
		var grupoTecla; //teclaPulsada y teclaContorno agrupados (Tool Tip Text)
		
		inicializarEntorno();
		inicializarCanvas();
		inicializarCapas(); //Creamos las capas (imï¿½gen, lï¿½neas)
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
		    tool = new paper.Tool(); //Crea una herramienta para manejar los eventos del teclado y ratï¿½n. Machaco la var tool ya existente
		    
		    //TODO Zoom
		    paper.tool.distanceThreshold = 8;
		    paper.tool.mouseStartPos = new paper.Point();
		    paper.tool.zoomFactor = 1.3;
		    lowerZoomLimit = 0.13;
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
			
			//Tamaï¿½o de todos los nodos
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
					stroke: true, //para clickar en las lï¿½neas
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
		imagenRaster.onLoad = function() { //Se ejecuta al cargar por primera vez la imÃ¡gen 
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
			if (tempW >= MAX_WIDTH || tempH >= MAX_HEIGHT){ //Si cualquiera de las dimensiones de la imÃ¡gen es mayor que la del canvas que quite nivel de zoom
				//if (tempW >= tempH){ //Comprobamos la dimensiÃ³n que va a predominar. Si el ancho de la imÃ¡gen es mayor que el alto de la imÃ¡gen
				if (tempH >= MAX_HEIGHT){ //Pero si el alto de la imÃ¡gen es mayor que el alto del canvas que se calcule el ratio respecto del alto del canvas
					//porcentajeZoom = Math.abs(MAX_HEIGHT * 100 / tempH);
					ratioZoomFactor = (tempH / MAX_HEIGHT);
				}else{ //Sino que se calcule el ratio respecto del ancho del canvas
					//porcentajeZoom = Math.abs(MAX_WIDTH * 100 / tempW);
					ratioZoomFactor = (tempW / MAX_WIDTH);
				}
				//porcentajeZoom = Math.abs(1 - ratioZoomFactor);
				//}else{//Si el alto de la imÃ¡gen es mayor que el ancho de la imÃ¡gen que se calcule el ratio respecto del alto de la imÃ¡gen
					//ratioZoomFactor = (tempW / MAX_WIDTH);
				//	ratioZoomFactor = (tempH / MAX_HEIGHT);
				//}
			}else{ //Sino que deje el tamaÃ±o de la imÃ¡gen al 100% y en el centro
				ratioZoomFactor = 1;
			}
			 
			var point = paper.view.viewToProject(paper.view.center); //point //Convertimos a coordenadas dentro del proyecto
			var zoomCenter = point.subtract(paper.view.center); 
			var moveFactor = tool.zoomFactor - 1.0;
			paper.view.zoom /= ratioZoomFactor;
            paper.view.center = paper.view.center.subtract(zoomCenter.multiply(moveFactor));
			
			// now scale the context to counter
	        // the fact that we've manually scaled
	        // our canvas element
	        //contexto.scale(ratio, ratio);
			
			var puntoCentroImagen = new paper.Point(MAX_WIDTH / 2, MAX_HEIGHT / 2);
			imagenRaster.position = puntoCentroImagen;
			//paper.view.draw;
			
			//document.getElementById("zoom_texto").value =  porcentajeZoom;
		
		}
		
		function inicializarControles(){
			controlPincel = true;
			controlReunion = false;
			controlBorrar = false;
			
			//ColorPicker
			document.getElementById("control_color").value = "#0000FF";
			
			//Tamaï¿½o pincel
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
			//circuloReunion.position = path.getPointAt(0,0); //posiciï¿½n inicial. NO creo
		}
		
		/**
		*  Cuando pulse el botï¿½n del ratï¿½n se obtendrï¿½ el item que estï¿½ debajo y ...
		*  1.- si no ha pulsado ningï¿½n item que no haga nada
		*  2.- si se ha pulsado en cualquier lado del Path con la tecla CTRL pulsada lo mueve en bloque
		*  3.- si se ha pulsado en un nodo con la tecla SHIFT pulsada borra dicho nodo
		*  4.- si se ha pulsado en un segmento/nodo del path preparado para mover el segmento
		*  5.- si se ha pulsado en la lï¿½nea del path inserta un nodo preparado para mover
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
				//circuloReunion.position = path.getPointAt(0,0); //posiciï¿½n inicial. NO creo
				*/
				
			/*} else{*/
				//Obtenemos dï¿½nde se ha pulsado el ratï¿½n 
			var hitResult = project.hitTest(event.point, hitOptions);
			var hitClaseItem = hitResult.item.className; //Otra forma mï¿½s fiable de saber quï¿½ item hemos clickado
			var hitNombreItem = hitResult.item.name; //Otra forma para evitar que clicke el tooltiptext
			
			console.info(hitResult.item.name);
			
			//EN MODO DEBUG CON EL CHROME NO ENTRAN LOS MODIFICADORES CONTROL NI SHIFT
			//Si pulsamos CTRL o SHIFT + Click ratï¿½n ...
			if (event.modifiers.control && controlPincel && hitNombreItem != "cursor"){ // && hitNombreItem != "cursor"					/*** CURSOR ***/
				//Si se ha pulsado CTRL + CLICK que lo prepare para moverse. Controla si clicka sobre alguno de los elementos del tooltiptext que no lo modifique  
				//if ( hitResult && hitClaseItem != "Raster" && hitNombreItem != "tooltiptext" && hitNombreItem != "textotooltip" && hitNombreItem != "contornotooltip" && (controlReunion || controlPincel)) {
				if (hitResult && hitNombreItem == "vector"){
					moverPath = true;
					path = hitResult.item;
					//project.activeLayer.addChild(hitResult.item); //no sï¿½ si hay que incluirlo luego
				}
			}else if (event.modifiers.control && controlReunion && hitNombreItem != "cursor"){ // && hitNombreItem != "cursor"					/*** CURSOR ***/
				//Si se ha pulsado CTRL + CLICK que lo prepare para moverse. Controla si clicka sobre alguno de los elementos del tooltiptext que no lo modifique  
				//if ( hitResult && hitClaseItem != "Raster" && hitNombreItem != "tooltiptext" && hitNombreItem != "textotooltip" && hitNombreItem != "contornotooltip" && (controlReunion || controlPincel)) {
				if (hitResult && hitNombreItem == "reunion"){
					moverPath = true;
					path = hitResult.item;
					//project.activeLayer.addChild(hitResult.item); //no sï¿½ si hay que incluirlo luego
				}
			}else if (event.modifiers.shift && controlPincel) {
				//pulsando SHIFT + CLICK en el segmento/nodo borra el nodo     			// && hitNombreItem != "cursor"					/*** CURSOR ***/
				if ( hitResult && hitClaseItem != "Raster" && !hitResult.item.hasFill() && hitNombreItem != "cursor" && !controlReunion && !controlBorrar) { //Si hemos hecho click sobre algo y que no sea la imï¿½gen y si ha sido en una reunion que no la modifique
					if (hitResult.type == 'segment') {
						hitResult.segment.remove();
					}
				}
			}else if (controlReunion){ //Si se ha pulsado el botï¿½n de Reuniï¿½n que cree una nueva reuniï¿½n al clickar sobre el canvas
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
			}else if (controlPincel){ //si no se ha pulsado ningï¿½n item o se ha clickado sobre el raster/imï¿½gen que cree un nuevo path y en onMouseDrag se dibuja
				 //|| hitNombreItem == "cursor"					/*** CURSOR ***/
				if (!hitResult || hitClaseItem === "Raster" || hitResult.type == "fill" || hitNombreItem == "cursor"){ //si hitResult=null o se ha clickado sobre la imï¿½gen o sobre un objeto con relleno/Reuniï¿½n
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
					//si pulsa en cualquier lugar del path y que no sea sobre el raster/imï¿½gen...
					console.info("guardamos el path clickado");
					path = hitResult.item; //guardamos el path sobre el que se ha pulsado
					
					if (hitResult.type == 'segment') {
						//Y si se ha pulsado sobre un segmento/nodo del propio path
						console.info("onMouseDown guardamos el path clickado y segment.point");
						segment = hitResult.segment; //guardamos el segmento/nodo del propio path
		
					} else if (hitResult.type == 'stroke') {
						//Y si se ha pulsado sobre la lï¿½nea del propio path
						console.info("onMouseDown guardamos el path clickado");
						var location = hitResult.location;
						segment = path.insert(location.index + 1, event.point); //inserta un nodo y lo guardamos
						path.smooth(); //Suaviza el nuevo vï¿½rtice
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
		*  Mientras estï¿½ encima de un item se selecciona
		*/
	 	//Sï¿½lo cuando pasamos por encima de un vector se selecciona (la imï¿½gen no)
		tool.onMouseMove = function(event){
			console.info("Ha entrado en onMouseMove");
			//paper.tool.mouseStartPos = new Point(event.point); //Para el zoom
			//Obtengo la posiciï¿½n del cursor para hacer Zoom
			//posicionRaton = getPosicionRaton(canvas, event);
			posicionRaton = canvas.getBoundingClientRect(); //Recojo la posiciï¿½n del ratï¿½n en la ï¿½ï¿½pantalla??. Para el Zoom
	
		    //posx = posicionRaton.x;
		    //posy = posicionRaton.y;
	
			//movemos el el cï¿½rculo del tamaï¿½o del pincel con el cursor.					/*** CURSOR ***/
			if (!controlMover && !controlBorrar){
				moverCursor(event.point);
			}
			
			project.activeLayer.selected = false;
			
			//Que sï¿½lo seleccione los vectores y las reuniones. Ni la imï¿½gen ni ninguno de los elementos del tooltiptext 
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
		
		/**Cuando arrastremos el ratï¿½n con el botï¿½n pulsado ...
		*  1.- moveremos el Path completo si se habï¿½a pulsado CTRL
		*  2.- arrastraremos el segmento/nodo si se haï¿½a pulsado sobre ï¿½l
		*  3.- arrastraremos el el nuevo segmento/nodo que acabamos de crear si se haï¿½a pulsado sobre la lï¿½nea/Path
		*/
		tool.onMouseDrag = function(event){
			console.info("Ha entrado en onMouseDrag");
			
			if (controlMover){
				//TODO Faltarï¿½a poner el viewToProject *****************************
				for (i=0; i<project.layers.length;i++){
					project.layers[i].position.x += event.delta.x;
					project.layers[i].position.y += event.delta.y;
				}
			}
			else if (dibujar){
				//TODO controlar que no salga del lï¿½mite de la imï¿½gen y/o del canvas. Controlar cuando tiene zoom
				console.info("dibujar");
				path.add(event.point);
				console.info("Pos. nuevo punto: " + event.point);
			}else{
				console.info("dibujar ELSE");
				if (moverPath) { //pulsando CONTROL + CLICK mueve path entero
					path.position.x += event.delta.x;
		  			path.position.y += event.delta.y;
					//path.position += event.delta; //No funciona asï¿½ cuando pongo tool. ...
				}else if (segment) {
					segment.point.x += event.delta.x;
					segment.point.y += event.delta.y;
					//segment.point += event.delta; //No funciona asï¿½ cuando pongo tool. ...
					path.smooth(); //Suaviza el nuevo vï¿½rtice
		  		}else if (path) {
		  			path.position.x += event.delta.x;
		  			path.position.y += event.delta.y;
					//path.position += event.delta; //No funciona asï¿½ cuando pongo tool. ...
				}
			}
			//movemos el cï¿½rculo del tamaï¿½o del pincel con el cursor.					/*** CURSOR ***/
			if (!controlMover && !controlBorrar){
				moverCursor(event.point);
			}
		}
	
		/**
		* Cuando soltemos el ratï¿½n se inicializan las variables que controlan el movimiento o dibujo
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
			//TODO controlar que cuando se salga de los lï¿½mites desaparezca el cï¿½rculo del cursor
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
		/**
		*  Cargarmos la imï¿½gen/raster en la capa capaImagen
		*/
		function cargarImagen(rutaImagen){
			//Activamos la capa de la imï¿½gen y la cargamos
			capaImagen.activate();
	
			//Carga una imï¿½gen. No la toma como dentro de la capa capaImagen
			//var img = new Image();
			//img.onload = function () {
		    //	contexto.drawImage(img, 0, 0);
			//}
			//img.src = "http://localhost:8080/canvas/img/via.jpg";
	
			//Cargar imï¿½gen como raster. Ahora sï¿½ que estï¿½ dentro de la capa capaImagen 
			//var imagenRaster = new Raster(rutaImagen);
			
			if (imagenRaster != null){
				console.info("va a borrar la imágen")
				imagenRaster.remove();
				imagenRaster = null;
				contexto.clearRect(0, 0, canvas.width, canvas.height); //Borro todo lo que haya en nuestro lienzo
			}
			
			/*var puntoInsercion = new paper.Point(paper.view.center);
			imagenRaster = new paper.Raster({
		  		source: rutaImagen,
		  		//position: view.center,
				selected: false}, puntoInsercion);*/
			imagenRaster = new paper.Raster({
		  		source: rutaImagen,
				selected: false});
			
			redimensionarImagen();
			//paper.view.draw(); //Nos aseguramos que la redibuja en el caso de cambiar la imï¿½gen (entra en imagenRaster.onload)
			
			//imagenRaster.position = view.center;
			imagenRaster.selected = false;
			capaVectorial.activate(); //Activa la capa de los vectores y lista para dibujar
			controlPincel = true;
		}
	
		function redimensionarImagen(){
			var MAX_WIDTH = $('#canvas_croquis').width();//$('#entorno').width(); //Anchura del div
			var MAX_HEIGHT = $('#canvas_croquis').height();//$('#entorno').height(); //Altura del div
			var tempW = imagenRaster.width;
			var tempH = imagenRaster.height;
			ratioZoomFactor = 1;
			porcentajeZoom = 0;
			
			//while (tempW > MAX_WIDTH || tempH > MAX_HEIGHT){
				/*$('#canvas_croquis').width();
					for (i=0 ; i < 10 ; i++){
						setMenosZoom();
						$('#canvas_croquis').width();
					}*/

				//document.getElementById("zoom_texto").value = document.getElementById("control_zoom").value;
			//}
			//TODO
			if (tempW >= MAX_WIDTH || tempH >= MAX_HEIGHT){ //Si cualquiera de las dimensiones de la imÃ¡gen es mayor que la del canvas que quite nivel de zoom
				//if (tempW >= tempH){ //Comprobamos la dimensiÃ³n que va a predominar. Si el ancho de la imÃ¡gen es mayor que el alto de la imÃ¡gen
				if (tempH >= MAX_HEIGHT){ //Pero si el alto de la imÃ¡gen es mayor que el alto del canvas que se calcule el ratio respecto del alto del canvas
					porcentajeZoom = Math.abs(MAX_HEIGHT * 100 / tempH);
					ratioZoomFactor = (tempH / MAX_HEIGHT);
				}else{ //Sino que se calcule el ratio respecto del ancho del canvas
					porcentajeZoom = Math.abs(MAX_WIDTH * 100 / tempW);
					ratioZoomFactor = (tempW / MAX_WIDTH);
				}
				//porcentajeZoom = Math.abs(1 - ratioZoomFactor);
				//}else{//Si el alto de la imÃ¡gen es mayor que el ancho de la imÃ¡gen que se calcule el ratio respecto del alto de la imÃ¡gen
					//ratioZoomFactor = (tempW / MAX_WIDTH);
				//	ratioZoomFactor = (tempH / MAX_HEIGHT);
				//}
			}else{ //Sino que deje el tamaÃ±o de la imÃ¡gen al 100% y en el centro
				ratioZoomFactor = 1;
			}
			 
			var point = paper.view.viewToProject(paper.view.center); //point //Convertimos a coordenadas dentro del proyecto
			var zoomCenter = point.subtract(paper.view.center); 
			var moveFactor = tool.zoomFactor - 1.0;
			paper.view.zoom /= ratioZoomFactor;
            paper.view.center = paper.view.center.subtract(zoomCenter.multiply(moveFactor));
			
			// now scale the context to counter
	        // the fact that we've manually scaled
	        // our canvas element
	        //contexto.scale(ratio, ratio);
			
			var puntoCentroImagen = new paper.Point(MAX_WIDTH / 2, MAX_HEIGHT / 2);
			imagenRaster.position = puntoCentroImagen;
			//paper.view.draw;
			
			//document.getElementById("zoom_texto").value =  porcentajeZoom;
		}
		
		/*control_imagen.onchange = function( event ){
			if (this.files && this.files[0]){
				//imagenRaster.remove();
				//paper.view.draw();
				//var fichero = new FileReader();
				//fichero.onload = function (e) {
				//	   $('#canvas_croquis').attr('src', e.target.result);
				//	  }
				//var dataURL = fichero.readAsDataURL(this.files[0]);
				//cargarImagen("C:\\Users\Atxa\\Desktop\\" + this.files[0].name);
				rutaImagen = "http://localhost:8080/HormaStudio/img/aspe1600x1550.jpg";//le paso una imï¿½gen para probar ya que el proceso serï¿½a: 1.- Escalara al tamaï¿½o del canvas 2.- subirlo a la web

				cargarImagen(rutaImagen);
			}
		}*/
		
		control_pincel.onclick = function( event ){
			var botonAuxPincel = document.getElementById("control_pincel");
			var botonAuxReunion = document.getElementById("control_reunion");
			var botonAuxBorrar = document.getElementById("control_borrar");
			var botonAuxMover = document.getElementById("control_mover");
			
			if ( botonAuxPincel.classList.contains("boton_no_pulsado") ){ //Si NO estï¿½ pulsado boton_pincel lo clickamos
				botonAuxPincel.classList.remove("boton_hover");
				botonAuxPincel.classList.toggle("boton_no_pulsado");
				botonAuxPincel.classList.add("boton_pulsado");
				canvas.classList.remove("cursor_mover");
				canvas.classList.remove("cursor_borrar");
				canvas.classList.add("cursor_none");
				
				document.getElementById("control_grosor").disabled = false;
				document.getElementById("grosor_texto").value = document.getElementById("control_grosor").value = vectorGrosor;
				document.getElementById("control_color").disabled = false;
				document.getElementById("control_color").value = vectorColor;
				controlPincel = true;
				controlReunion = false;
				controlBorrar = false;
				controlMover = false;
				setGrosor(); //Restauramos el grosor del cursor para el grosor del vector
				if ( botonAuxReunion.classList.contains("boton_pulsado") ){ //Si estï¿½ pulsado boton_reunion lo desclickamos
					botonAuxReunion.classList.remove("boton_pulsado");
					botonAuxReunion.classList.add("boton_hover");
					botonAuxReunion.classList.toggle("boton_no_pulsado");
				}else if ( botonAuxBorrar.classList.contains("boton_pulsado") ){ //Si estï¿½ pulsado boton_borrar lo desclickamos
					botonAuxBorrar.classList.remove("boton_pulsado");
					botonAuxBorrar.classList.add("boton_hover");
					botonAuxBorrar.classList.toggle("boton_no_pulsado");
				}else if ( botonAuxMover.classList.contains("boton_pulsado") ){ //Si estï¿½ pulsado boton_borrar lo desclickamos
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
			
			if ( botonAuxReunion.classList.contains("boton_no_pulsado") ){ //Si NO estï¿½ pulsado boton_pincel lo clickamos
				botonAuxReunion.classList.remove("boton_hover");
				botonAuxReunion.classList.toggle("boton_no_pulsado");
				botonAuxReunion.classList.add("boton_pulsado");
				canvas.classList.remove("cursor_mover");
				canvas.classList.remove("cursor_borrar");
				canvas.classList.add("cursor_none");
				
				document.getElementById("control_grosor").disabled = false;
				document.getElementById("grosor_texto").value = document.getElementById("control_grosor").value = reunionRadio;
				document.getElementById("control_color").disabled = false;
				document.getElementById("control_color").value = reunionColor;
				controlPincel = false;
				controlReunion = true;
				controlBorrar = false;
				controlMover = false;
				setGrosor(); //Restauramos el grosor del cursor para el grosor de la reuniÃ³n
				if ( botonAuxBorrar.classList.contains("boton_pulsado") ){ //Si estï¿½ pulsado boton_borrar lo desclickamos
					botonAuxBorrar.classList.remove("boton_pulsado");
					botonAuxBorrar.classList.add("boton_hover");
					botonAuxBorrar.classList.toggle("boton_no_pulsado");
				}else if ( botonAuxPincel.classList.contains("boton_pulsado") ){ //Si estï¿½ pulsado boton_reunion lo desclickamos
					botonAuxPincel.classList.remove("boton_pulsado");
					botonAuxPincel.classList.add("boton_hover");
					botonAuxPincel.classList.toggle("boton_no_pulsado");
				}else if ( botonAuxMover.classList.contains("boton_pulsado") ){ //Si estï¿½ pulsado boton_borrar lo desclickamos
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
			
			if ( botonAuxBorrar.classList.contains("boton_no_pulsado") ){ //Si NO estï¿½ pulsado boton_pincel lo clickamos
				botonAuxBorrar.classList.remove("boton_hover");
				botonAuxBorrar.classList.toggle("boton_no_pulsado");
				botonAuxBorrar.classList.add("boton_pulsado");
				canvas.classList.remove("cursor_none");
				canvas.classList.remove("cursor_mover");
				canvas.classList.add("cursor_borrar");

				document.getElementById("control_grosor").disabled = true;
				document.getElementById("control_color").disabled = true;
				controlPincel = false;
				controlReunion = false;
				controlBorrar = true;
				controlMover = false;
				cursorTamanoPincel.visible = false;
				if ( botonAuxReunion.classList.contains("boton_pulsado") ){ //Si estï¿½ pulsado boton_borrar lo desclickamos
					botonAuxReunion.classList.remove("boton_pulsado");
					botonAuxReunion.classList.add("boton_hover");
					botonAuxReunion.classList.toggle("boton_no_pulsado");
				}else if ( botonAuxPincel.classList.contains("boton_pulsado") ){ //Si estï¿½ pulsado boton_reunion lo desclickamos
					botonAuxPincel.classList.remove("boton_pulsado");
					botonAuxPincel.classList.add("boton_hover");
					botonAuxPincel.classList.toggle("boton_no_pulsado"); 
				}else if ( botonAuxMover.classList.contains("boton_pulsado") ){ //Si estï¿½ pulsado boton_borrar lo desclickamos
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
			
			if ( botonAuxMover.classList.contains("boton_no_pulsado") ){ //Si NO estï¿½ pulsado boton_pincel lo clickamos
				botonAuxMover.classList.remove("boton_hover");
				botonAuxMover.classList.toggle("boton_no_pulsado");
				botonAuxMover.classList.add("boton_pulsado");
				canvas.classList.remove("cursor_none");
				canvas.classList.remove("cursor_borrar");
				canvas.classList.add("cursor_mover");
				document.getElementById("control_grosor").disabled = true;
				document.getElementById("control_color").disabled = true;
				//TODO deshabilitar cursor
				cursorTamanoPincel.visible = false;
				controlPincel = false;
				controlReunion = false;
				controlBorrar = false;
				controlMover = true;
				if ( botonAuxReunion.classList.contains("boton_pulsado") ){ //Si estï¿½ pulsado boton_borrar lo desclickamos
					botonAuxReunion.classList.remove("boton_pulsado");
					botonAuxReunion.classList.add("boton_hover");
					botonAuxReunion.classList.toggle("boton_no_pulsado");
				}else if ( botonAuxPincel.classList.contains("boton_pulsado") ){ //Si estï¿½ pulsado boton_reunion lo desclickamos
					botonAuxPincel.classList.remove("boton_pulsado");
					botonAuxPincel.classList.add("boton_hover");
					botonAuxPincel.classList.toggle("boton_no_pulsado"); 
				}else if ( botonAuxBorrar.classList.contains("boton_pulsado") ){ //Si estï¿½ pulsado boton_borrar lo desclickamos
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
			//var tempImg = project.activelayer.rasterize(300); //rasterize tiene el parï¿½metro "resoluciï¿½n" o paper.proj...
			var mimeType = "image/jpeg";
			var calidad = 1.0; //La calidad mï¿½s alta
			//var dataString = tempImg.toDataURL(mimeType);
			var dataString = document.getElementById("canvas_croquis").toDataURL(mimeType, calidad);
			//tempImg.remove();
			var bajar = document.getElementById("descargar")
			bajar.classList.remove("invisible");
			bajar.href = dataString;
			//downloadme.href = canvasImg.src;
			//window.open(dataString, "toDataURL() image", "width=800, height=200");//Abre en una nueva ventana la imï¿½gen
			
			
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

			var anteriorRadioSinStroke;
			var nuevoRadioSinStroke;
			
			anteriorRadioSinStroke = cursorTamanoPincel.bounds.width / 2;
			if (controlPincel) {
				nuevoRadioSinStroke = (document.getElementById("control_grosor").value - cursorTamanoPincel.strokeWidth) / 2; //Calculamos el nuevo radio sÃ­n la lÃ­nea del cÃ­rculo)
				cursorTamanoPincel.scale(nuevoRadioSinStroke / anteriorRadioSinStroke); //Modificamos el tamaÃ±o del cÃ­rculo
				vectorGrosor = cursorTamanoPincel.bounds.width + cursorTamanoPincel.strokeWidth;//DiÃ¡metro actual = Ancho cÃ­rculo + ancho lÃ­nea cÃ­rculo. AsÃ­ se consigue el diÃ¡metro del cÃ­rculo
			}else if (controlReunion){
				nuevoRadioSinStroke = (document.getElementById("control_grosor").value - cursorTamanoPincel.strokeWidth) / 2;
				cursorTamanoPincel.scale(nuevoRadioSinStroke / anteriorRadioSinStroke); //Modificamos el tamaÃ±o del cÃ­rculo
				reunionRadio = cursorTamanoPincel.bounds.width + cursorTamanoPincel.strokeWidth;//DiÃ¡metro actual = Ancho cÃ­rculo + ancho lÃ­nea cÃ­rculo. AsÃ­ se consigue el diÃ¡metro del cÃ­rculo
			}
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
		
		//Al mover el slider del Zoom
		function setZoom(){
			diferenciaZoom = document.getElementById("control_zoom").value - diferenciaZoom; // - document.getElementById("zoom_texto").value;
			if (diferenciaZoom>0){ //Si es positivo hago zoom
				//for (i=0 ; i < z ; i++){
					setMasZoom(diferenciaZoom);
				//}
			}else{ //Si es negativo quito zoom
				//z*=-1; //Lo convierto a positivo
				//for (i=0 ; i < z ; i++){
					setMenosZoom( Math.abs(diferenciaZoom) );//Lo convierto a positivo
				//}
			}
			//document.getElementById("zoom_texto").value = document.getElementById("control_zoom").value;
			diferenciaZoom = document.getElementById("control_zoom").value;
		}
	
		//Al pulsar - o + del Zoom
		function moverZoom(direccion){
			var controlZoom = document.getElementById("control_zoom");
			if (direccion == "arriba"){
				if (controlZoom.value < upperZoomLimit){
					controlZoom.stepUp(1);
					setMasZoom(1);
				}
			}else if (direccion == "abajo"){
				if (controlZoom.value > lowerZoomLimit){
					controlZoom.stepDown(1);
					setMenosZoom(1);
				}
			}
			//document.getElementById("zoom_texto").value = document.getElementById("control_zoom").value;
			diferenciaZoom = document.getElementById("control_zoom").value;
		}
	
		function setMasZoom(posiciones){
	       	//var children = project.activeLayer.children;
	       	if (paper.view.zoom < upperZoomLimit) { 
	               //scroll up
	               //var point = paper.DomEvent.getOffset(e.originalEvent, $('#canvas_croquis')[0]);
	               
	   			//var point = $('#canvas_croquis').offset(); //var
	   		    //var x = event.clientX - posicionRaton.left; //De la posiciï¿½n del ratï¿½n dentro de la pantalla calculamos la posiciï¿½n X dentro del canvas
	   			//var y =  event.clientY - posicionRaton.top; //De la posiciï¿½n del ratï¿½n dentro de la pantalla calculamos la posiciï¿½n Y dentro del canvas
	   			point = paper.view.viewToProject(imagenRaster.view.center); //point //Convertimos a coordenadas dentro del proyecto
	            var zoomCenter = point.subtract(paper.view.center);
	            var moveFactor = tool.zoomFactor - 1.0;
	            paper.view.zoom *= (tool.zoomFactor * posiciones);
	            paper.view.center = paper.view.center.add(zoomCenter.multiply(moveFactor / tool.zoomFactor));
	            tool.mode = '';
	        }
		}
		
		function setMenosZoom(posiciones){
			if (paper.view.zoom > lowerZoomLimit){ //scroll down
	            //var point = paper.DomEvent.getOffset(e.originalEvent, $('#canvas_croquis')[0]);
	
				//var point = $('#canvas_croquis').offset();
				
				//var x = event.clientX - posicionRaton.left; //De la posiciï¿½n del ratï¿½n dentro de la pantalla calculamos la posiciï¿½n X dentro del canvas
				//var y =  event.clientY - posicionRaton.top; //De la posiciï¿½n del ratï¿½n dentro de la pantalla calculamos la posiciï¿½n Y dentro del canvas
				var point = paper.view.viewToProject(paper.view.center); //point //Convertimos a coordenadas dentro del proyecto
	            var zoomCenter = point.subtract(paper.view.center);   
	            var moveFactor = tool.zoomFactor - 1.0;
	            paper.view.zoom /= (tool.zoomFactor * posiciones);
	            paper.view.center = paper.view.center.subtract(zoomCenter.multiply(moveFactor))
	        }
		}
	
		function resetZoom(){
			//TODO
		}
		
		$("#canvas_croquis").mousewheel(function(event, delta) {
	    	var delta = 0;
	        //var children = project.activeLayer.children;
			//var zTexto = document.getElementById("zoom_texto");
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
			    
				//Más
				//Zoom(1);
				var x = event.clientX - posicionRaton.left; //De la posiciï¿½n del ratï¿½n dentro de la pantalla calculamos la posiciï¿½n X dentro del canvas
				var y =  event.clientY - posicionRaton.top; //De la posiciï¿½n del ratï¿½n dentro de la pantalla calculamos la posiciï¿½n Y dentro del canvas
				var point = paper.view.viewToProject(x,y); //Convertimos a coordenadas dentro del proyecto
	            var zoomCenter = point.subtract(paper.view.center);
	            var moveFactor = tool.zoomFactor - 1.0;
	            paper.view.zoom *= tool.zoomFactor;
	            paper.view.center = paper.view.center.add(zoomCenter.multiply(moveFactor / tool.zoomFactor));
	            tool.mode = '';
	            
	            /*porcentajeZoom = ((ratioZoomFactor + tool.zoomFactor) * porcentajeZoom) / ratioZoomFactor;
	            document.getElementById("zoom_texto").value = porcentajeZoom;*/
	            //porcentajeZoom = Math.abs(1 - ratioZoomFactor);
	            //document.getElementById("zoom_texto").value = (paper.view.zoom * porcentajeZoom) / ratioZoomFactor;
	            //document.getElementById("zoom_texto").value = porcentajeZoom;
	            
	            
	            //zTexto.value = parseInt(zTexto.value) + 1;
	            zControl.value = parseInt(zControl.value) + 1;
	        }
	        else if((delta < 0) && (paper.view.zoom > lowerZoomLimit)){ // && (paper.view.zoom != 1.0000000000000002)){ //scroll down //Como paper.view.zoom se queda en 1.0000000000002 hace un zoom de mï¿½s por lo que lo evito poniï¿½ndolo en las condiciï¿½n
				//TODO cuando llegue al nivel mï¿½ximo de zoom se quede en el medio del canvas 
				
	        	//var point = paper.DomEvent.getOffset(e.originalEvent, $('#canvas_croquis')[0]);
				//var point = $('#canvas_croquis').offset();
				
				//Menos
				//Zoom(2);
				var x = event.clientX - posicionRaton.left; //De la posiciï¿½n del ratï¿½n dentro de la pantalla calculamos la posiciï¿½n X dentro del canvas
				var y =  event.clientY - posicionRaton.top; //De la posiciï¿½n del ratï¿½n dentro de la pantalla calculamos la posiciï¿½n Y dentro del canvas
				var point = paper.view.viewToProject(x,y); //Convertimos a coordenadas dentro del proyecto
	            var zoomCenter = point.subtract(paper.view.center);   
	            var moveFactor = tool.zoomFactor - 1.0;
	            paper.view.zoom /= tool.zoomFactor;
	            paper.view.center = paper.view.center.subtract(zoomCenter.multiply(moveFactor));
	            
	            //redimensionarImagen();
	            //document.getElementById("zoom_texto").value = (paper.view.zoom * porcentajeZoom) / ratioZoomFactor;
	            //document.getElementById("zoom_texto").value = porcentajeZoom;
	            
	            
	            
	            //zTexto.value = parseInt(zTexto.value) - 1; //Cambiamos el texto del zoom
	            zControl.value = parseInt(zControl.value) - 1; //Cambiamos el slider del zoom
	        }
	        
	    });
		
		/*function Zoom(tipo){
			var MAX_WIDTH = $('#canvas_croquis').width();//$('#entorno').width(); //Anchura del div
			var MAX_HEIGHT = $('#canvas_croquis').height();//$('#entorno').height(); //Altura del div
			var tempW = imagenRaster.width;
			var tempH = imagenRaster.height;
			
			if (tempW >= MAX_WIDTH || tempH >= MAX_HEIGHT){ //Si cualquiera de las dimensiones de la imÃ¡gen es mayor que la del canvas que quite nivel de zoom
				//if (tempW >= tempH){ //Comprobamos la dimensiÃ³n que va a predominar. Si el ancho de la imÃ¡gen es mayor que el alto de la imÃ¡gen
				if (tempH >= MAX_HEIGHT){ //Pero si el alto de la imÃ¡gen es mayor que el alto del canvas que se calcule el ratio respecto del alto del canvas
					//porcentajeZoom = Math.abs(MAX_HEIGHT * 100 / tempH);
					ratioZoomFactor = (tempH / MAX_HEIGHT);
				}else{ //Sino que se calcule el ratio respecto del ancho del canvas
					//porcentajeZoom = Math.abs(MAX_WIDTH * 100 / tempW);
					ratioZoomFactor = (tempW / MAX_WIDTH);
				}

			}else{ //Sino que deje el tamaÃ±o de la imÃ¡gen al 100% y en el centro
				ratioZoomFactor = 1;
			}
			
			//Más zoom
			if (tipo = 1){
				
				var x = event.clientX - posicionRaton.left; //De la posiciï¿½n del ratï¿½n dentro de la pantalla calculamos la posiciï¿½n X dentro del canvas
				var y =  event.clientY - posicionRaton.top; //De la posiciï¿½n del ratï¿½n dentro de la pantalla calculamos la posiciï¿½n Y dentro del canvas
				var point = paper.view.viewToProject(x,y); //Convertimos a coordenadas dentro del proyecto
	            var zoomCenter = point.subtract(paper.view.center);
	            var moveFactor = tool.zoomFactor - 1.0;
	            paper.view.zoom *= tool.zoomFactor;
	            paper.view.center = paper.view.center.add(zoomCenter.multiply(moveFactor / tool.zoomFactor));
	            tool.mode = '';
				
			//Menos zoom
			}else{
				
				var x = event.clientX - posicionRaton.left; //De la posiciï¿½n del ratï¿½n dentro de la pantalla calculamos la posiciï¿½n X dentro del canvas
				var y =  event.clientY - posicionRaton.top; //De la posiciï¿½n del ratï¿½n dentro de la pantalla calculamos la posiciï¿½n Y dentro del canvas
				var point = paper.view.viewToProject(x,y); //Convertimos a coordenadas dentro del proyecto
	            var zoomCenter = point.subtract(paper.view.center);   
	            var moveFactor = tool.zoomFactor - 1.0;
	            paper.view.zoom /= tool.zoomFactor;
	            paper.view.center = paper.view.center.subtract(zoomCenter.multiply(moveFactor));
				
			}
			
			//var point = paper.view.viewToProject(paper.view.center); //point //Convertimos a coordenadas dentro del proyecto
			//var zoomCenter = point.subtract(paper.view.center); 
			//var moveFactor = tool.zoomFactor - 1.0;
			paper.view.zoom /= ratioZoomFactor;
	        paper.view.center = paper.view.center.subtract(zoomCenter.multiply(moveFactor));
			
			// now scale the context to counter
	        // the fact that we've manually scaled
	        // our canvas element
	        //contexto.scale(ratio, ratio);
			
			var puntoCentroImagen = new paper.Point(MAX_WIDTH / 2, MAX_HEIGHT / 2);
			imagenRaster.position = puntoCentroImagen;
		}*/
	    
	
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

