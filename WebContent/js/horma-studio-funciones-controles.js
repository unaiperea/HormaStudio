/**
 * 
 * Funciones de los controles de la interfaz que interactúan con el canvas
 * 
 */

/**
 * TODO QUITAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAR (no se usa)
 */
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
	if (tempW >= MAX_WIDTH || tempH >= MAX_HEIGHT){ //Si cualquiera de las dimensiones de la imágen es mayor que la del canvas que quite nivel de zoom
		//if (tempW >= tempH){ //Comprobamos la dimensión que va a predominar. Si el ancho de la imágen es mayor que el alto de la imágen
		if (tempH >= MAX_HEIGHT){ //Pero si el alto de la imágen es mayor que el alto del canvas que se calcule el ratio respecto del alto del canvas
			porcentajeZoom = Math.abs(MAX_HEIGHT * 100 / tempH);
			ratioZoomFactor = (tempH / MAX_HEIGHT);
		}else{ //Sino que se calcule el ratio respecto del ancho del canvas
			porcentajeZoom = Math.abs(MAX_WIDTH * 100 / tempW);
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
		rutaImagen = "http://localhost:8080/HormaStudio/img/aspe1600x1550.jpg";//le paso una im�gen para probar ya que el proceso ser�a: 1.- Escalara al tama�o del canvas 2.- subirlo a la web

		cargarImagen(rutaImagen);
	}
}*/

control_pincel.onclick = function( event ){
	var botonAuxPincel = document.getElementById("control_pincel");
	var botonAuxReunion = document.getElementById("control_reunion");
	var botonAuxBorrar = document.getElementById("control_borrar");
	var botonAuxMover = document.getElementById("control_mover");
	
	if ( botonAuxPincel.classList.contains("boton_no_pulsado") ){ //Si NO esta pulsado boton_pincel lo clickamos
		botonAuxPincel.classList.remove("boton_hover");
		botonAuxPincel.classList.toggle("boton_no_pulsado");
		botonAuxPincel.classList.add("boton_pulsado");
		canvas.classList.remove("cursor_mover");
		canvas.classList.remove("cursor_borrar");
		canvas.classList.add("cursor_none");
		
		document.getElementById("control_grosor").disabled = false;
		document.getElementById("control_grosor").value = vectorGrosor;
		document.getElementById("etiqueta-grosor").innerHTML = "Tamaño pincel: " + vectorGrosor;
		$("#control-color").spectrum("enable");
		$("#control-color").spectrum("set", vectorColor);
		
		controlPincel = true;
		controlReunion = false;
		controlBorrar = false;
		controlMover = false;
		setGrosor(); //Restauramos el grosor del cursor para el grosor del vector
		if ( botonAuxReunion.classList.contains("boton_pulsado") ){ //Si esta pulsado boton_reunion lo desclickamos
			botonAuxReunion.classList.remove("boton_pulsado");
			botonAuxReunion.classList.add("boton_hover");
			botonAuxReunion.classList.toggle("boton_no_pulsado");
		}else if ( botonAuxBorrar.classList.contains("boton_pulsado") ){ //Si esta pulsado boton_borrar lo desclickamos
			botonAuxBorrar.classList.remove("boton_pulsado");
			botonAuxBorrar.classList.add("boton_hover");
			botonAuxBorrar.classList.toggle("boton_no_pulsado");
		}else if ( botonAuxMover.classList.contains("boton_pulsado") ){ //Si esta pulsado boton_borrar lo desclickamos
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
	
	if ( botonAuxReunion.classList.contains("boton_no_pulsado") ){ //Si NO esta pulsado boton_pincel lo clickamos
		botonAuxReunion.classList.remove("boton_hover");
		botonAuxReunion.classList.toggle("boton_no_pulsado");
		botonAuxReunion.classList.add("boton_pulsado");
		canvas.classList.remove("cursor_mover");
		canvas.classList.remove("cursor_borrar");
		canvas.classList.add("cursor_none");
		
		document.getElementById("control_grosor").disabled = false;
		document.getElementById("control_grosor").value = reunionRadio;
		document.getElementById("etiqueta-grosor").innerHTML = "Tamaño pincel: " + reunionRadio;
		$("#control-color").spectrum("enable");
		$("#control-color").spectrum("set", reunionColor);

		controlPincel = false;
		controlReunion = true;
		controlBorrar = false;
		controlMover = false;
		setGrosor(); //Restauramos el grosor del cursor para el grosor de la reunión
		if ( botonAuxBorrar.classList.contains("boton_pulsado") ){ //Si esta pulsado boton_borrar lo desclickamos
			botonAuxBorrar.classList.remove("boton_pulsado");
			botonAuxBorrar.classList.add("boton_hover");
			botonAuxBorrar.classList.toggle("boton_no_pulsado");
		}else if ( botonAuxPincel.classList.contains("boton_pulsado") ){ //Si esta pulsado boton_reunion lo desclickamos
			botonAuxPincel.classList.remove("boton_pulsado");
			botonAuxPincel.classList.add("boton_hover");
			botonAuxPincel.classList.toggle("boton_no_pulsado");
		}else if ( botonAuxMover.classList.contains("boton_pulsado") ){ //Si esta pulsado boton_borrar lo desclickamos
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
	
	if ( botonAuxBorrar.classList.contains("boton_no_pulsado") ){ //Si NO esta pulsado boton_pincel lo clickamos
		botonAuxBorrar.classList.remove("boton_hover");
		botonAuxBorrar.classList.toggle("boton_no_pulsado");
		botonAuxBorrar.classList.add("boton_pulsado");
		canvas.classList.remove("cursor_none");
		canvas.classList.remove("cursor_mover");
		canvas.classList.add("cursor_borrar");

		document.getElementById("control_grosor").disabled = true;
		$("#control-color").spectrum("disable");
		
		controlPincel = false;
		controlReunion = false;
		controlBorrar = true;
		controlMover = false;
		cursorTamanoPincel.visible = false;
		if ( botonAuxReunion.classList.contains("boton_pulsado") ){ //Si esta pulsado boton_borrar lo desclickamos
			botonAuxReunion.classList.remove("boton_pulsado");
			botonAuxReunion.classList.add("boton_hover");
			botonAuxReunion.classList.toggle("boton_no_pulsado");
		}else if ( botonAuxPincel.classList.contains("boton_pulsado") ){ //Si esta pulsado boton_reunion lo desclickamos
			botonAuxPincel.classList.remove("boton_pulsado");
			botonAuxPincel.classList.add("boton_hover");
			botonAuxPincel.classList.toggle("boton_no_pulsado"); 
		}else if ( botonAuxMover.classList.contains("boton_pulsado") ){ //Si esta pulsado boton_borrar lo desclickamos
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
	
	if ( botonAuxMover.classList.contains("boton_no_pulsado") ){ //Si NO esta pulsado boton_pincel lo clickamos
		botonAuxMover.classList.remove("boton_hover");
		botonAuxMover.classList.toggle("boton_no_pulsado");
		botonAuxMover.classList.add("boton_pulsado");
		canvas.classList.remove("cursor_none");
		canvas.classList.remove("cursor_borrar");
		canvas.classList.add("cursor_mover");
		
		document.getElementById("control_grosor").disabled = true;
		$("#control-color").spectrum("disable");
		
		//TODO deshabilitar cursor
		cursorTamanoPincel.visible = false;
		controlPincel = false;
		controlReunion = false;
		controlBorrar = false;
		controlMover = true;
		if ( botonAuxReunion.classList.contains("boton_pulsado") ){ //Si esta pulsado boton_borrar lo desclickamos
			botonAuxReunion.classList.remove("boton_pulsado");
			botonAuxReunion.classList.add("boton_hover");
			botonAuxReunion.classList.toggle("boton_no_pulsado");
		}else if ( botonAuxPincel.classList.contains("boton_pulsado") ){ //Si esta pulsado boton_reunion lo desclickamos
			botonAuxPincel.classList.remove("boton_pulsado");
			botonAuxPincel.classList.add("boton_hover");
			botonAuxPincel.classList.toggle("boton_no_pulsado"); 
		}else if ( botonAuxBorrar.classList.contains("boton_pulsado") ){ //Si esta pulsado boton_borrar lo desclickamos
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

control_reset.onclick = function ( event ){
	//TODO centrar todas las capas o el paper. bORRAR LAS VARIABLES GLOBALES QUE UTILIZO AQUÍ (loadImagen(e)) ***********************************
	paper.view.zoom = originalZoom;
	//paper.view.center = paper.view.viewToProject(originalCentro);
	//paper.view.center = paper.view.projectToView(originalCentro);
	paper.view.center = originalCentro;
	tool.zoomFactor = originalMoveFactor;
	//Fuerzo el update ya que no lo hace automaticamente en este caso
	//paper.view.update();//Comprobar que sea imprescindible ********************************************
	/*var point = paper.view.viewToProject(paper.view.center); //point //Convertimos a coordenadas dentro del proyecto
	var zoomCenter = point.subtract(paper.view.center); 
	var moveFactor = tool.zoomFactor - 1.0;
	paper.view.zoom /= ratioZoomFactor;
    paper.view.center = paper.view.center.subtract(zoomCenter.multiply(moveFactor));
	*/
	
	document.getElementById("control_zoom").value = 5;
}

/*Abre el cuadro de dialogo de cargar imágen*/
function abrirDialogo(){
	document.getElementById('control_imagen').click();
}

function loadImagen(e){
	var fichero = new FileReader();

	//Trigger del fichero cargado desde el cuadro de dialogo
	fichero.onload = function(event){
		//canvas.classList.remove("cursor_none");
		//canvas.classList.add("cursor_wait");
		
		//Activamos la capa de la imagen y la cargamos
		capaImagen.activate();
		
		if (imagenRaster != null){
			console.info("va a borrar la imagen")
			imagenRaster.remove();
			imagenRaster = null;
			hayImagen = false;

			//Borramos el contenido de las capas imagen y vectorial
			capaImagen.removeChildren();
			capaVectorial.removeChildren();
			contexto.clearRect(0, 0, canvas.width, canvas.height);
		}
			//Cargamos la imagen elegida
			imagenRaster = new paper.Raster({
		  		source: event.target.result, //rutaImagen,
				selected: false});
			
			//Redimensiona el entorno
			var MAX_WIDTH = $('#canvas_croquis').width();//$('#entorno').width(); //Anchura del div
			var MAX_HEIGHT = $('#canvas_croquis').height();//$('#entorno').height(); //Altura del div
			var tempW = imagenRaster.width;
			var tempH = imagenRaster.height;
			paper.view.zoom = ratioZoomFactor = 1;
			//porcentajeZoom = 0;

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
			
			var puntoCentroImagen = new paper.Point(MAX_WIDTH / 2, MAX_HEIGHT / 2);
			originalCentro = imagenRaster.position = paper.view.viewToProject(puntoCentroImagen);
			originalMoveFactor = tool.zoomFactor; //Para PROBARRRRRRRRRRRRRRRRRRRRRRRRRR
			originalCentro = zoomCenter; //Para PROBARRRRRRRRRRRRRRRRRRRRRRRRRR
			//paper.view.draw;
			
			//document.getElementById("zoom_texto").value =  porcentajeZoom;
			document.getElementById("control_zoom").disabled = false;
			nombreKrokis = controlImagen.files[0].name;
			document.getElementById("nombre-krokis").innerHTML = "[" + nombreKrokis + "]";
			//canvas.classList.remove("cursor_wait");
			//canvas.classList.add("cursor_none");
			capaVectorial.activate(); //Activa la capa de los vectores y lista para dibujar //***************************************
			controlPincel = true;
			hayImagen = true;
    }
	if (e.target.files.length != 0){
		fichero.readAsDataURL(e.target.files[0]); //imágen en formato base64
	}
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
	//var tempImg = project.activelayer.rasterize(300); //rasterize tiene el par�metro "resoluci�n" o paper.proj...
	var mimeType = "image/jpeg";
	var calidad = 1.0; //La calidad m�s alta
	//var dataString = tempImg.toDataURL(mimeType);
	var dataString = document.getElementById("canvas_croquis").toDataURL(mimeType, calidad);
	//tempImg.remove();
	var bajar = document.getElementById("descargar")
	bajar.classList.remove("invisible");
	bajar.href = dataString;
	//downloadme.href = canvasImg.src;
	//window.open(dataString, "toDataURL() image", "width=800, height=200");//Abre en una nueva ventana la im�gen
	
	
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

function setColor(){
	if (controlPincel){
		vectorColor = $("#control-color").val(); //document.getElementById("control-color").value;
	}else if (controlReunion){
		reunionColor = $("#control-color").val(); //document.getElementById("control-color").value;
	}
}

function setGrosor(){
	document.getElementById("etiqueta-grosor").innerHTML = "Tamaño pincel: " + document.getElementById("control_grosor").value;

	var anteriorRadioSinStroke;
	var nuevoRadioSinStroke;
	
	anteriorRadioSinStroke = cursorTamanoPincel.bounds.width / 2;
	if (controlPincel) {
		nuevoRadioSinStroke = (document.getElementById("control_grosor").value - cursorTamanoPincel.strokeWidth) / 2; //Calculamos el nuevo radio sín la línea del círculo)
		cursorTamanoPincel.scale(nuevoRadioSinStroke / anteriorRadioSinStroke); //Modificamos el tamaño del círculo
		vectorGrosor = cursorTamanoPincel.bounds.width + cursorTamanoPincel.strokeWidth;//Diámetro actual = Ancho círculo + ancho línea círculo. Así se consigue el diámetro del círculo
	}else if (controlReunion){
		nuevoRadioSinStroke = (document.getElementById("control_grosor").value - cursorTamanoPincel.strokeWidth) / 2;
		cursorTamanoPincel.scale(nuevoRadioSinStroke / anteriorRadioSinStroke); //Modificamos el tamaño del círculo
		reunionRadio = cursorTamanoPincel.bounds.width + cursorTamanoPincel.strokeWidth;//Diámetro actual = Ancho círculo + ancho línea círculo. Así se consigue el diámetro del círculo
	}
}

/*function moverGrosor(direccion){
	if (controlPincel || controlReunion){
		if (direccion == "arriba"){
			document.getElementById("control_grosor").stepUp(1);
		}else if (direccion == "abajo"){
			document.getElementById("control_grosor").stepDown(1);
		}
		setGrosor();
	}
}*/

//Al mover el slider del Zoom
function setZoom(){
	if (hayImagen){
		diferenciaZoom = document.getElementById("control_zoom").value - diferenciaZoom; // - document.getElementById("zoom_texto").value;
		if (diferenciaZoom > 0){ //Si es positivo hago zoom
			for (i=0 ; i < diferenciaZoom ; i++){
				setMasZoom(); //setMasZoom(diferenciaZoom);
			}
		}else{ //Si es negativo quito zoom
			diferenciaZoom = Math.abs(diferenciaZoom);
			//z*=-1; //Lo convierto a positivo
			for (i=0 ; i < diferenciaZoom ; i++){
				setMenosZoom(); //setMenosZoom( Math.abs(diferenciaZoom) );//Lo convierto a positivo
			}
		}
		//document.getElementById("zoom_texto").value = document.getElementById("control_zoom").value;
		document.getElementById("zoom_factor_texto").value = diferenciaZoom;
		
		diferenciaZoom = document.getElementById("control_zoom").value;//Esta siiiiiii
		
		document.getElementById("zoom_texto").value = diferenciaZoom;
	}else{
		document.getElementById("control_zoom").value = 5;
	}
}

//Al pulsar - o + del Zoom
/*function moverZoom(direccion){ 
	document.getElementById("zoom_texto").value = document.getElementById("control_zoom").value;
	document.getElementById("zoom_factor_texto").value = ratioZoomFactor;
	
	var controlZoom = document.getElementById("control_zoom");
	if (direccion == "arriba"){
		if (controlZoom.value < upperZoomLimit){
			setMasZoom();
		}
	}else if (direccion == "abajo"){
		if (controlZoom.value > lowerZoomLimit){
			setMenosZoom();
		}
	}
	//document.getElementById("zoom_texto").value = document.getElementById("control_zoom").value;
	diferenciaZoom = document.getElementById("control_zoom").value;
}*/

/**
 * Si el canvas contiene algo dibujado o una imágen que haga Scroll
 */
function comprobarContenidoCanvas(){
	var resul = false;
	//Recorre todas las capas
	for (i=0; i<project.layers.length;i++){
		//Si contiene hijos: líneas, puntos, imágenes
		if (project.layers[i].name != "capa del cursor" && project.layers[i].name != "capa generica"){
			if (project.layers[i].hasChildren()){
				resul = true;
				break;
			}
		}
	}
	return resul;
}

function setMasZoom(){
   	//var children = project.activeLayer.children;
   	//Scroll up

	if (comprobarContenidoCanvas && document.getElementById("control_zoom").value <= upperZoomLimit) { //paper.view.zoom < upperZoomLimit 

        //var point = paper.DomEvent.getOffset(e.originalEvent, $('#canvas_croquis')[0]);
           
		//var point = $('#canvas_croquis').offset(); //var
	    //var x = event.clientX - posicionRaton.left; //De la posici�n del rat�n dentro de la pantalla calculamos la posici�n X dentro del canvas
		//var y =  event.clientY - posicionRaton.top; //De la posici�n del rat�n dentro de la pantalla calculamos la posici�n Y dentro del canvas
		point = paper.view.viewToProject(imagenRaster.view.center); //point //Convertimos a coordenadas dentro del proyecto
        var zoomCenter = point.subtract(paper.view.center);
        var moveFactor = tool.zoomFactor - 1.0;
        paper.view.zoom *= tool.zoomFactor;
        paper.view.center = paper.view.center.add(zoomCenter.multiply(moveFactor / tool.zoomFactor));
        tool.mode = '';

        //document.getElementById("control_zoom").slider('setValue', 9);
        //document.getElementById("control_zoom").value ++; //Cambiamos el slider del zoom
    }
}

function setMenosZoom(){
	//scroll down
	if (document.getElementById("control_zoom").value >= lowerZoomLimit){ //paper.view.zoom > lowerZoomLimit
        //var point = paper.DomEvent.getOffset(e.originalEvent, $('#canvas_croquis')[0]);

		//var point = $('#canvas_croquis').offset();
		
		//var x = event.clientX - posicionRaton.left; //De la posici�n del rat�n dentro de la pantalla calculamos la posici�n X dentro del canvas
		//var y =  event.clientY - posicionRaton.top; //De la posici�n del rat�n dentro de la pantalla calculamos la posici�n Y dentro del canvas
		var point = paper.view.viewToProject(paper.view.center); //point //Convertimos a coordenadas dentro del proyecto
        var zoomCenter = point.subtract(paper.view.center);   
        var moveFactor = tool.zoomFactor - 1.0;
        paper.view.zoom /= tool.zoomFactor;
        paper.view.center = paper.view.center.subtract(zoomCenter.multiply(moveFactor))
        
        //document.getElementById("control_zoom").setValue(9);
        //document.getElementById("control_zoom").value --; //Cambiamos el slider del zoom
    }
}

$("#canvas_croquis").mousewheel(function(event, delta) {
	if (hayImagen){
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
	
	    //var v = comprobarContenidoCanvas();
	    if (comprobarContenidoCanvas()){ // Comprobamos que exista algo dentro del canvas
	        if((delta > 0) && (document.getElementById("control_zoom").value < upperZoomLimit)) { //scroll up. paper.view.zoom
	            //var point = paper.DomEvent.getOffset(e.originalEvent, $('#canvas_croquis')[0]);
				//point = $('#canvas_croquis').offset(); //var
			    
				//Mas
				//Zoom(1);
				var x = event.clientX - posicionRaton.left; //De la posici�n del rat�n dentro de la pantalla calculamos la posici�n X dentro del canvas
				var y =  event.clientY - posicionRaton.top; //De la posici�n del rat�n dentro de la pantalla calculamos la posici�n Y dentro del canvas
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
	            
	            document.getElementById("control_zoom").value++;
	            etiquetaZoom.innerHTML = "Zoom: " + document.getElementById("control_zoom").value;
	            //zTexto.value = parseInt(zTexto.value) + 1;
	            //zControl.value = parseInt(zControl.value) + 1;
	            document.getElementById("zoom_texto").value = paper.view.zoom;
	        }
	        else if((delta < 0) && (document.getElementById("control_zoom").value > lowerZoomLimit)){ // (paper.view.zoom > lowerZoomLimit) && (paper.view.zoom != 1.0000000000000002)){ //scroll down //Como paper.view.zoom se queda en 1.0000000000002 hace un zoom de m�s por lo que lo evito poni�ndolo en las condici�n
				//TODO cuando llegue al nivel m�ximo de zoom se quede en el medio del canvas 
				
	        	//var point = paper.DomEvent.getOffset(e.originalEvent, $('#canvas_croquis')[0]);
				//var point = $('#canvas_croquis').offset();
				
				//Menos
				//Zoom(2);
				var x = event.clientX - posicionRaton.left; //De la posici�n del rat�n dentro de la pantalla calculamos la posici�n X dentro del canvas
				var y =  event.clientY - posicionRaton.top; //De la posici�n del rat�n dentro de la pantalla calculamos la posici�n Y dentro del canvas
				var point = paper.view.viewToProject(x,y); //Convertimos a coordenadas dentro del proyecto
	            var zoomCenter = point.subtract(paper.view.center);   
	            var moveFactor = tool.zoomFactor - 1.0;
	            paper.view.zoom /= tool.zoomFactor;
	            paper.view.center = paper.view.center.subtract(zoomCenter.multiply(moveFactor));
	            
	            //redimensionarImagen();
	            //document.getElementById("zoom_texto").value = (paper.view.zoom * porcentajeZoom) / ratioZoomFactor;
	            //document.getElementById("zoom_texto").value = porcentajeZoom;
	            
	            
	            document.getElementById("control_zoom").value--;
	            etiquetaZoom.innerHTML = "Zoom: " + document.getElementById("control_zoom").value;
	            //zTexto.value = parseInt(zTexto.value) - 1; //Cambiamos el texto del zoom
	            //zControl.value = parseInt(zControl.value) - 1; //Cambiamos el slider del zoom
	            document.getElementById("zoom_texto").value = paper.view.zoom;
	        }
	    }
	}
});

/*function Zoom(tipo){
	var MAX_WIDTH = $('#canvas_croquis').width();//$('#entorno').width(); //Anchura del div
	var MAX_HEIGHT = $('#canvas_croquis').height();//$('#entorno').height(); //Altura del div
	var tempW = imagenRaster.width;
	var tempH = imagenRaster.height;
	
	if (tempW >= MAX_WIDTH || tempH >= MAX_HEIGHT){ //Si cualquiera de las dimensiones de la imágen es mayor que la del canvas que quite nivel de zoom
		//if (tempW >= tempH){ //Comprobamos la dimensión que va a predominar. Si el ancho de la imágen es mayor que el alto de la imágen
		if (tempH >= MAX_HEIGHT){ //Pero si el alto de la imágen es mayor que el alto del canvas que se calcule el ratio respecto del alto del canvas
			//porcentajeZoom = Math.abs(MAX_HEIGHT * 100 / tempH);
			ratioZoomFactor = (tempH / MAX_HEIGHT);
		}else{ //Sino que se calcule el ratio respecto del ancho del canvas
			//porcentajeZoom = Math.abs(MAX_WIDTH * 100 / tempW);
			ratioZoomFactor = (tempW / MAX_WIDTH);
		}

	}else{ //Sino que deje el tamaño de la imágen al 100% y en el centro
		ratioZoomFactor = 1;
	}
	
	//M�s zoom
	if (tipo = 1){
		
		var x = event.clientX - posicionRaton.left; //De la posici�n del rat�n dentro de la pantalla calculamos la posici�n X dentro del canvas
		var y =  event.clientY - posicionRaton.top; //De la posici�n del rat�n dentro de la pantalla calculamos la posici�n Y dentro del canvas
		var point = paper.view.viewToProject(x,y); //Convertimos a coordenadas dentro del proyecto
        var zoomCenter = point.subtract(paper.view.center);
        var moveFactor = tool.zoomFactor - 1.0;
        paper.view.zoom *= tool.zoomFactor;
        paper.view.center = paper.view.center.add(zoomCenter.multiply(moveFactor / tool.zoomFactor));
        tool.mode = '';
		
	//Menos zoom
	}else{
		
		var x = event.clientX - posicionRaton.left; //De la posici�n del rat�n dentro de la pantalla calculamos la posici�n X dentro del canvas
		var y =  event.clientY - posicionRaton.top; //De la posici�n del rat�n dentro de la pantalla calculamos la posici�n Y dentro del canvas
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




