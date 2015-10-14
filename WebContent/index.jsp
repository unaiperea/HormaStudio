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
		<link rel="stylesheet" type="text/css" href="css/range_slider.css?v=1.0">
		<link rel="stylesheet" type="text/css" href="js/bootstrap-slider-master/css/bootstrap-slider.css">
		
		<!-- Responsive Design -->
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
		
		<!-- Bootstrap minified CSS -->
		<link rel="stylesheet" href="js/bootstrap-3.3.5-dist/css/bootstrap.min.css">
		
		<!-- Font Awesome -->		
		<link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.4.0/css/font-awesome.min.css">
		
		<!-- TODO crear style.css -->
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
	  		#herramientas-dcha{background-color: #424242;}
	  		footer{background-color: silver;}
	  		
		</style>
	  
	</head>
	
	<body>
	<!-- for others: use <body oncontextmenu="return false;"> to prevent browser context menus from appearing on right click. -->
	
		<header id="cabecera">
			<div class="container clearfix">
				<span id="titulo" class="">
					<h1>Horma Studio</h1>
				</span>
				<span id="subtitulo" class="">
					<h4>Climbing Tools</h4>
				</span>
			</div>
		</header>
		
		<nav class="menu-wrapper">
			<div class="menu">
				<h2>menu</h2>
			</div>
		</nav>
		
		<div class="container-fluid">
			
			<section id="entorno" class="main row">
			
				<aside id="herramientas-izda" class="col-xs-2">
					<!-- SUBIR FICHEROS -->
					<!-- Formulario -->
					<!-- @see: http://www.tutorialspoint.com/servlets/servlets-file-uploading.htm -->
					<form action="/HormaStudio/imagen" enctype="multipart/form-data" method="post" role="form">
						<div id="control-archivo">
							<ul>
								<li>
									<input type="text" id="accion" name="accion" value="1">
									<input type="text" id="texto" name="t">
									<!-- images/* o image/jpeg, image/bmp, image/png, image/gif y atributo disabled -->
									<input type="file" id="control_imagen" name="control_imagen" accept="image/jpeg"> <!-- onchange="abrirImagen();"> -->
									<!-- onclick="return escribirAccion(< %=Constantes.ACCION_SUBIR_IMAGEN%>);" -->
									<input type="submit" id="btn_submit" class="btn btn-outline btn-primary disabled" disabled="" value="Subir">
								</li>
								<li><span id="control_guardar" class="btn btn-default">Guardar imágen</span></li>
								<li><a id="descargar" href="#" target="_blank" class="invisible">Descargar imágen</a></li>
							</ul>
						</div>
					</form>
					<!-- CONTROLES -->
					<div class="clearfix">
						<div id="control-dibujo" class="pull-right">
							<ul class="iconos-dibujo">
								<li><span id="control_pincel" class="fa fa-paint-brush boton_pulsado fa-2x"></span></li>
								<li><span id="control_reunion" class="fa fa-dot-circle-o boton_hover boton_no_pulsado fa-2x lista-margen-arriba"></span></li>
								<li><span id="control_borrar" class="fa fa-eraser boton_hover boton_no_pulsado fa-2x lista-margen-arriba"></span></li>
								<!-- <li><span id="control_mover" class="fa fa-arrows boton_hover boton_no_pulsado fa-2x lista-margen-arriba"></span></li> -->
								<!-- <li><span class="icon-image" style="font-size: 30px"></span></li> -->
							</ul>
						</div>
					</div>
					<!-- PROPIEDADES -->
					<div class="clearfix">
						<div id="control-propiedades" class="pull-right">
							<ul class="iconos-dibujo pull-right">
								<li><input type="color" id="control_color" name="control_color" onchange="getColor();"></li>
								<!-- <li><input type="text" id="grosor_texto" size="1" readonly></li> -->
								<li><span id="grosor_menos" class="fa fa-minus-circle fa-1x" style="color: #FFFFFF;" onclick="moverGrosor('abajo');"></span></li>
								<li><input type="range" id="control_grosor" name="control_grosor" class="range vertical-lowest-first round zoom-range s" min="2" max="50" onchange="setGrosor();" style="margin-top: 1px"></li></li>
								<!-- 
								<li><input type="range" id="control_grosor" name="control_grosor" class="range vertical-lowest-first round zoom-range" min="2" max="50" onchange="setGrosor();" style="margin-top: 1px"></li>
								-->
								
								<!-- <li><input id="ex17a" type="text"/></li> -->
	      						
								
								<li><span id="grosor_mas" class="fa fa-plus-circle fa-1x" style="color: #FFFFFF;" onclick="moverGrosor('arriba');"></span></li>
							</ul>
						</div>
					</div>
					
				</aside>
				
				<!-- 
				<div id="control-propiedades" class="clearfix">
					<input type="range" id="control_grosor" name="control_grosor" class="range vertical-lowest-first round zoom-range s" min="2" max="50" onchange="setGrosor();" style="margin-top: 1px"></li>
				</div>
				-->
				
				<!-- <div class="clearfix visible-sm-block"></div> -->
				<!-- CANVAS -->
				<article id="centro" class="col-xs-8">
					<div id="barra-menus">
						<p>
							<!-- TODO Incluir un video explicativo -->
							Pig salami kielbasa, turducken hamburger turkey strip steak shankle ham hock tenderloin cupim. Pork loin tenderloin doner strip steak beef turkey. Tail shank swine tri-tip alcatra pig cupim filet mignon meatball capicola jerky chuck ham venison. Chuck salami shank, tenderloin alcatra ball tip brisket corned beef flank pig short ribs pork loin t-bone meatloaf cupim.
						</p>
					</div>
					
					<div id="canvas-container">
						<canvas id="canvas_croquis" class="cursor_none" name="imagen">Su navegador no soporta Canvas. Instale la ultima version de Chrome</canvas>
					</div>
				</article>

				<!-- UTILIDADES -->
				<!-- colocar a la izda -->
				<aside id="herramientas-dcha" class="col-xs-2">
					<div id="herramientas-dcha-container" style="width: 47px;">
						<div style="width: 20px; margin:auto;">
							<span id="zoom_menos" class="fa fa-minus-circle cursor_hand" style="font-size: 20px; color: #FFFFFF; padding-left: 1px;" onclick="moverZoom('arriba');"></span>
							<!-- <input type="range" id="control_zoom" name="control_zoom" class="bar cursor_hand" onchange="setZoom();" style="margin-top: 1px;"/> -->
							<!-- <input type="range" id="control_zoom" name="control_zoom" min="0" max="10" step="1" onchange="setZoom();"/> ERA EL BUENO -->
							<input id="control_zoom" type="text" id="control_zoom" name="control_zoom" onchange="setZoom();"/>
							<!-- <div id="zoom-slider">
								<input class="bar" type="range" id="rangeinput" value="10" onchange="rangevalue.value=value"/>
								<span class="highlight"></span>
								<output id="rangevalue">50</output>
							</div> -->
							<span id="zoom_mas" class="fa fa-plus-circle cursor_hand" style="font-size: 20px; color: #FFFFFF; padding-left: 1px;" onclick="moverZoom('abajo');"></span>
						</div>
						
						<div id="zoom-1-1" class="cursor_hand">
							<input type="button" id="zoom_restaurar" name="zoom_restaurar" class="btn btn-primary" onclick="resetZoom();" value="1:1"/>
						</div>
						
						<div id="mover-container" class="text-center">
							<span id="control_mover" class="fa fa-arrows boton_hover boton_no_pulsado fa-2x cursor_hand"></span>
						</div>
					</div>

					<!-- TODO Incluir un video explicativo -->
				</aside>
				
				
				
				
				
				
				<!-- Colocar bien y mirar los estilos -->
				<div id="controles" class="row">
					<div id="zoom" class="col-xs-12">
						<p>Zoom:
							<input type="text" id="zoom_texto" size="2" readonly/>
						</p>
						<p>ratioZoomFactor:
							<input type="text" id="zoom_factor_texto" size="20" readonly/>
						</p>
					
						<!-- <i class="col-xs-1 fa fa-minus-square-o" style="font-size: 15px"> -->
						<!-- <input type="range" id="control_zoom" name="control_zoom"  onchange="setZoom();"/> --> 
						<!-- <i class="col-xs-1 fa fa-plus-square-o" style="font-size: 15px"> -->
					</div>
				</div>
			</section>
			
			<footer>
				<div class="container">
					<h3>pie de pagina</h3>
				</div>
			</footer>
		
		</div>
				
		
		<!--  jQuery -->
		<script src="js/jquery-2.1.4.min.js"></script>
		
		<!-- JQuery MouseWheel -->
		<script type='text/javascript' src='js/jquery.mousewheel.min.js'></script>
		
		<!-- Bootstrap minified JavaScript -->
	  	<script src="js/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
		
		<!-- Slider for Bootstrap -->
	  	<script src="js/bootstrap-slider-master/js/bootstrap-slider.js"></script>
		
		<!-- Paper.js dibujo en Canvas -->
		<script type="text/javascript" src="js/paperjs-v0.9.23/dist/paper-full.js" canvas="canvas_croquis"></script>
		
		<!-- Horma Studio -->
		<script type="text/javascript" src="js/horma-studio.js"></script>
		
		<!-- HormaStudio funciones controles -->
		<script type="text/javascript" src="js/horma-studio-funciones-controles.js"></script>
			      
	</body>
</html>
