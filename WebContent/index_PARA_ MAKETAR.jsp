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
		<link rel='stylesheet' type="text/css" href="css/spectrum.css" />
		<link rel="stylesheet" type="text/css" href="css/range_slider.css?v=1.0">
		
		<!-- Responsive Design -->
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
		
		<!-- Bootstrap minified -->
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
	  		/*#barra-menus{background-color: olive;}*/
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
								<li><span id="control_pincel" class="glyphicon glyphicon-pencil boton_pulsado"></span></li>
								<!-- <li><span id="control_pincel" class="fa fa-paint-brush boton_pulsado fa-2x"></span></li> -->
								<li><span id="control_reunion" class="fa fa-dot-circle-o boton_hover boton_no_pulsado lista-margen-arriba"></span></li>
								<li><span id="control_borrar" class="fa fa-eraser boton_hover boton_no_pulsado lista-margen-arriba"></span></li>
								<!-- <li><span id="control_mover" class="fa fa-arrows boton_hover boton_no_pulsado fa-2x lista-margen-arriba"></span></li> -->
								<!-- <li><span class="icon-image" style="font-size: 30px"></span></li> -->
							</ul>
						</div>
					</div>
					<!-- PROPIEDADES -->
					<div class="clearfix">
						<div id="control-propiedades" class="pull-right">
							<ul class="iconos-propiedades">
								<li><input type="color" id="control_color" name="control_color" class="pull_right" name="control_color" onchange="getColor();"></li>
								<!-- 
								<li><input type="range" id="control_grosor" name="control_grosor" class="range vertical-lowest-first round zoom-range" min="2" max="50" onchange="setGrosor();" style="margin-top: 1px"></li>
								-->
								<li>
									<div id="grosor_container" class="inputDiv clearfix">
										<div class=flotar_dcha>
										  	<!-- <span id="grosor_menos" class="fa fa-minus-circle fa-1x flotar_izda" style="color: #FFFFFF;" onclick="moverGrosor('abajo');"></span> -->
										  	<div id="etiqueta-grosor"></div>
										  	<input id="control_grosor" type="range" value="25" min="2" max="50" autocomplete="off" onchange="setGrosor();">
										  	<!-- <span id="grosor_mas" class="fa fa-plus-circle fa-1x flotar_izda" style="color: #FFFFFF;" onclick="moverGrosor('arriba');"></span> -->
										</div>
									</div>
								</li>
	
							</ul>
						</div>
					</div>
					<div class="clearfix">
						<div id="control-dibujo2" class="pull-right">
							<ul id="navigationMenu">
							    <li>
								    <a class="home" href="#">
							            <span>Home</span>
							        </a>
							    </li>
							
							    <li>
							    	<a class="about" href="#">
							            <span>About</span>
							        </a>
							    </li>
							
							    <li>
								     <a class="services" href="#">
							            <span>Services</span>
							         </a>
							    </li>
							
							    <li>
							    	<a class="portfolio" href="#">
							            <span>Portfolio</span>
							        </a>
							    </li>
							
							    <li>
							    	<a class="contact" href="#">
							            <span>Contact us</span>
							        </a>
							    </li>
							</ul>
							<ul class="iconos-dibujo2">
								<li><span id="control_pincel2" class="glyphicon glyphicon-pencil boton_pulsado"></span></li>
								<!-- <li><span id="control_pincel" class="fa fa-paint-brush boton_pulsado fa-2x"></span></li> -->
								<li><span id="control_reunion2" class="fa fa-dot-circle-o boton_hover boton_no_pulsado lista-margen-arriba"></span></li>
								<li><span id="control_borrar2" class="fa fa-eraser boton_hover boton_no_pulsado lista-margen-arriba"></span></li>
								<!-- <li><span id="control_mover" class="fa fa-arrows boton_hover boton_no_pulsado fa-2x lista-margen-arriba"></span></li> -->
								<!-- <li><span class="icon-image" style="font-size: 30px"></span></li> -->
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
				<!-- CANVAS, MENU Y HERRAMIENTAS DCHA-->
				<article id="centro" class="col-xs-10">
					<div class="row">
						<div class="col-xs-8">
							<!-- MENU CANVAS -->
							<div id="barra-menus">
								<nav id="colorNav">
									<ul>
										<li class="green">
											<span class="fa fa-cogs"></span>
											<ul>
												<li><span onclick="abrirDialogo();">Cargar imagen</span></li>
												<li><span>Guardar imagen</span></li>
											</ul>
										</li>
									</ul>
								</nav>
								<div class="text-center">
									<span id="nombre-krokis"></span>
								</div>
							</div>
						</div>
						<aside class="col-xs-2 herramientas-dcha">
							<div class="herramientas-dcha-container color-fondo-gris">
							</div>
						</aside>
					<div class="row">
						<!-- CANVAS -->
						<div id="canvas-container" class="col-xs-8">
							<canvas id="canvas_croquis" class="cursor_none" name="imagen">Su navegador no soporta Canvas. Instale la ultima version de Chrome</canvas>
						</div>
						<!-- UTILIDADES -->
						<aside class="herramientas-dcha-container"> <!-- style="width: 47px;"> -->
							<!-- <div style="width: 20px; margin:auto;">
							<span id="zoom_menos" class="fa fa-minus-circle cursor_hand" style="font-size: 20px; color: #FFFFFF; padding-left: 1px;" onclick="moverZoom('arriba');"></span> -->
							<div id="zoom_container" class="inputDiv">
							  	<!-- <div id="control-div"> -->
							  	<input id="control_zoom" type="range" value="5" min="0" max="10" autocomplete="off" class="vertical" onchange="setZoom();"/>
							  	<!-- </div> -->
								<div id="etiqueta-zoom" class="col-xs-8"></div>
							</div>
							<!-- <span id="zoom_mas" class="fa fa-plus-circle cursor_hand" style="font-size: 20px; color: #FFFFFF; padding-left: 1px;" onclick="moverZoom('abajo');"></span>
							</div> -->
							<div id="zoom-1-1" class="anchura100">
								<!-- <input type="button" id="zoom_restaurar" name="zoom_restaurar" class="btn btn-primary" onclick="resetZoom();" value="1:1"/> -->
								<span id="control_reset" class="fa fa-compress boton_hover boton_no_pulsado cursor_hand"></span>
							</div>
							
							<div id="mover-container" class="anchura100">
								<span id="control_mover" class="fa fa-arrows boton_hover boton_no_pulsado cursor_hand"></span>
							</div>
						</aside>
					</div>
				</article>

				<!-- <article id="centro" class="col-xs-8 clearfix">
					<div id="barra-menus">
						<nav id="colorNav">
							<ul>
								<li class="green">
									<span class="fa fa-cogs"></span>
									<ul>
										<li><span onclick="abrirDialogo();">Cargar imagen</span></li>
										<li><span>Guardar imagen</span></li>
									</ul>
								</li>
							</ul>
						</nav>
						<div class="text-center">
							<span id="nombre-krokis"></span>
						</div>
					</div>
					
					<div id="canvas-container">
						<canvas id="canvas_croquis" class="cursor_none" name="imagen">Su navegador no soporta Canvas. Instale la ultima version de Chrome</canvas>
					</div>
				</article>-->


				<!-- UTILIDADES -->
				<!-- <aside id="herramientas-dcha" class="col-xs-2">
					<div id="herramientas-dcha-container">
						<div id="zoom_container" class="inputDiv">
						  	<input id="control_zoom" type="range" value="5" min="0" max="10" autocomplete="off" class="vertical" onchange="setZoom();"/>
							<div id="etiqueta-zoom" class="col-xs-8"></div>
						</div>
						</div>
						<div id="zoom-1-1" class="anchura100">
							<span id="control_reset" class="fa fa-compress boton_hover boton_no_pulsado cursor_hand"></span>
						</div>
						
						<div id="mover-container" class="anchura100">
							<span id="control_mover" class="fa fa-arrows boton_hover boton_no_pulsado cursor_hand"></span>
						</div>
					</div> -->

					<!-- TODO Incluir un video explicativo -->
				<!-- Elementos ocultos -->
				<div class="hidden">
					<!-- images/* o image/jpeg, image/bmp, image/png, image/gif y atributo disabled -->
					<input type="file" id="control_imagen" accept="image/jpeg" hidden> <!-- onchange="abrirImagen();"> -->
				</div>
				
				
				
				
				
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
		
		<!-- Spectrum Color Picker  - http://bgrins.github.io/spectrum/-->
		<script src="js/spectrum.js"></script>
		
		<!-- Paper.js dibujo en Canvas -->
		<script type="text/javascript" src="js/paper-full.min.js" canvas="canvas_croquis"></script>
		
		<!-- Horma Studio -->
		<script type="text/javascript" src="js/horma-studio.js"></script>
		
		<!-- HormaStudio funciones controles -->
		<script type="text/javascript" src="js/horma-studio-funciones-controles.js"></script>

	</body>
</html>
