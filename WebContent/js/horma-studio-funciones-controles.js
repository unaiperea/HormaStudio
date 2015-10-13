/**
 * 
 * Funciones de los controles de la interfaz que interactúan con el canvas
 * 
 */

		/**
		 * TODO
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
			
			if ( botonAuxPincel.classList.contains("boton_no_pulsado") ){ //Si NO est� pulsado boton_pincel lo clickamos
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
				if ( botonAuxReunion.classList.contains("boton_pulsado") ){ //Si est� pulsado boton_reunion lo desclickamos
					botonAuxReunion.classList.remove("boton_pulsado");
					botonAuxReunion.classList.add("boton_hover");
					botonAuxReunion.classList.toggle("boton_no_pulsado");
				}else if ( botonAuxBorrar.classList.contains("boton_pulsado") ){ //Si est� pulsado boton_borrar lo desclickamos
					botonAuxBorrar.classList.remove("boton_pulsado");
					botonAuxBorrar.classList.add("boton_hover");
					botonAuxBorrar.classList.toggle("boton_no_pulsado");
				}else if ( botonAuxMover.classList.contains("boton_pulsado") ){ //Si est� pulsado boton_borrar lo desclickamos
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
			
			if ( botonAuxReunion.classList.contains("boton_no_pulsado") ){ //Si NO est� pulsado boton_pincel lo clickamos
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
				setGrosor(); //Restauramos el grosor del cursor para el grosor de la reunión
				if ( botonAuxBorrar.classList.contains("boton_pulsado") ){ //Si est� pulsado boton_borrar lo desclickamos
					botonAuxBorrar.classList.remove("boton_pulsado");
					botonAuxBorrar.classList.add("boton_hover");
					botonAuxBorrar.classList.toggle("boton_no_pulsado");
				}else if ( botonAuxPincel.classList.contains("boton_pulsado") ){ //Si est� pulsado boton_reunion lo desclickamos
					botonAuxPincel.classList.remove("boton_pulsado");
					botonAuxPincel.classList.add("boton_hover");
					botonAuxPincel.classList.toggle("boton_no_pulsado");
				}else if ( botonAuxMover.classList.contains("boton_pulsado") ){ //Si est� pulsado boton_borrar lo desclickamos
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
			
			if ( botonAuxBorrar.classList.contains("boton_no_pulsado") ){ //Si NO est� pulsado boton_pincel lo clickamos
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
				if ( botonAuxReunion.classList.contains("boton_pulsado") ){ //Si est� pulsado boton_borrar lo desclickamos
					botonAuxReunion.classList.remove("boton_pulsado");
					botonAuxReunion.classList.add("boton_hover");
					botonAuxReunion.classList.toggle("boton_no_pulsado");
				}else if ( botonAuxPincel.classList.contains("boton_pulsado") ){ //Si est� pulsado boton_reunion lo desclickamos
					botonAuxPincel.classList.remove("boton_pulsado");
					botonAuxPincel.classList.add("boton_hover");
					botonAuxPincel.classList.toggle("boton_no_pulsado"); 
				}else if ( botonAuxMover.classList.contains("boton_pulsado") ){ //Si est� pulsado boton_borrar lo desclickamos
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
			
			if ( botonAuxMover.classList.contains("boton_no_pulsado") ){ //Si NO est� pulsado boton_pincel lo clickamos
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
				if ( botonAuxReunion.classList.contains("boton_pulsado") ){ //Si est� pulsado boton_borrar lo desclickamos
					botonAuxReunion.classList.remove("boton_pulsado");
					botonAuxReunion.classList.add("boton_hover");
					botonAuxReunion.classList.toggle("boton_no_pulsado");
				}else if ( botonAuxPincel.classList.contains("boton_pulsado") ){ //Si est� pulsado boton_reunion lo desclickamos
					botonAuxPincel.classList.remove("boton_pulsado");
					botonAuxPincel.classList.add("boton_hover");
					botonAuxPincel.classList.toggle("boton_no_pulsado"); 
				}else if ( botonAuxBorrar.classList.contains("boton_pulsado") ){ //Si est� pulsado boton_borrar lo desclickamos
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
		
		/*function escribirAccion(ac){
			//Subir y cargar im�gen
			document.getElementById("accion").value = ac;
		}*/
		
		
		
		function loadImagen(e){
			//Quito la propiedad
			document.getElementById("btn_submit").disabled = false;
			//Quito la clase (estilo)
			document.getElementById("btn_submit").classList.remove("disabled");
			
			var fichero = new FileReader();
			//Activamos la capa de la im�gen y la cargamos
			capaImagen.activate();
			
			fichero.onload = function(event){
			
				if (imagenRaster != null){
					console.info("va a borrar la imagen")
					imagenRaster.remove();
					imagenRaster = null;
				}
				contexto.clearRect(0, 0, canvas.width, canvas.height); //Borro todo lo que haya en nuestro lienzo
				
				imagenRaster = new paper.Raster({
			  		source: event.target.result, //rutaImagen,
					selected: false});
				
		        //var img = new Image();
				/*imagenRaster.onload = function(){
					redimensionarImagen();
		        }*/
				
				
				
				//Redimensiona el entorno
				//imagenRaster.onload = function() { //Se ejecuta al cargar por primera vez la imágen 
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
					
					// now scale the context to counter
			        // the fact that we've manually scaled
			        // our canvas element
			        //contexto.scale(ratio, ratio);
					
					var puntoCentroImagen = new paper.Point(MAX_WIDTH / 2, MAX_HEIGHT / 2);
					originalCentro = imagenRaster.position = paper.view.viewToProject(puntoCentroImagen);
					//paper.view.draw;
					
					//document.getElementById("zoom_texto").value =  porcentajeZoom;
					capaVectorial.activate();                                              //***************************************
				//}				
				
				
				
		    }
			fichero.readAsDataURL(e.target.files[0]); //imágen en formato base64
			
			//imagenRaster.selected = false;
			capaVectorial.activate(); //Activa la capa de los vectores y lista para dibujar //***************************************
			controlPincel = true;
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
				nuevoRadioSinStroke = (document.getElementById("control_grosor").value - cursorTamanoPincel.strokeWidth) / 2; //Calculamos el nuevo radio sín la línea del círculo)
				cursorTamanoPincel.scale(nuevoRadioSinStroke / anteriorRadioSinStroke); //Modificamos el tamaño del círculo
				vectorGrosor = cursorTamanoPincel.bounds.width + cursorTamanoPincel.strokeWidth;//Diámetro actual = Ancho círculo + ancho línea círculo. Así se consigue el diámetro del círculo
			}else if (controlReunion){
				nuevoRadioSinStroke = (document.getElementById("control_grosor").value - cursorTamanoPincel.strokeWidth) / 2;
				cursorTamanoPincel.scale(nuevoRadioSinStroke / anteriorRadioSinStroke); //Modificamos el tamaño del círculo
				reunionRadio = cursorTamanoPincel.bounds.width + cursorTamanoPincel.strokeWidth;//Diámetro actual = Ancho círculo + ancho línea círculo. Así se consigue el diámetro del círculo
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
		}
	
		//Al pulsar - o + del Zoom
		function moverZoom(direccion){ 
			document.getElementById("zoom_texto").value = document.getElementById("control_zoom").value;
			document.getElementById("zoom_factor_texto").value = ratioZoomFactor;
			
			var controlZoom = document.getElementById("control_zoom");
			if (direccion == "arriba"){
				if (controlZoom.value < upperZoomLimit){
					controlZoom.stepUp();
					setMasZoom();
				}
			}else if (direccion == "abajo"){
				if (controlZoom.value > lowerZoomLimit){
					controlZoom.stepDown();
					setMenosZoom();
				}
			}
			//document.getElementById("zoom_texto").value = document.getElementById("control_zoom").value;
			diferenciaZoom = document.getElementById("control_zoom").value;
		}
	
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
					}
				}
			}
			return resul;
		}
		
		
		//TODO            QUITAR EL PARÁMETRO SI NO LO UTILIZA
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
	            
	            //document.getElementById("control_zoom").value --; //Cambiamos el slider del zoom
	        }
		}
	
		function resetZoom(){
			
			//TODO centrar todas las capas o el paper ***********************************
			paper.view.zoom = originalZoom;
			//paper.view.center = paper.view.viewToProject(originalCentro);
			//paper.view.center = paper.view.projectToView(originalCentro);
            paper.view.center = originalCentro;
            
            //var puntoCentroImagen = new paper.Point(MAX_WIDTH / 2, MAX_HEIGHT / 2);
			//imagenRaster.position = 
			//paper.view.center = paper.view.projectToView(puntoCentroImagen);
			
			//paper.view.center = paper.view.viewToProject(originalCentro);
			
			/*var tempW = imagenRaster.width;
			var tempH = imagenRaster.height;
			
			var puntoActual = new paper.Point(tempW/2, tempH/2);
			
			for (i=0; i<project.layers.length;i++){
				project.layers[i].position.x = originalCentro.x;
				project.layers[i].position.y = originalCentro.y;
			}*/
			document.getElementById("control_zoom").value = 5;
			
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
	
	        var v = comprobarContenidoCanvas();
	        if (v == true){ // Comprobamos que exista algo dentro del canvas
		        if((delta > 0) && (document.getElementById("control_zoom").value < upperZoomLimit)) { //scroll up. paper.view.zoom
		            //var point = paper.DomEvent.getOffset(e.originalEvent, $('#canvas_croquis')[0]);
					//point = $('#canvas_croquis').offset(); //var
				    
					//M�s
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
		            
		            
		            //zTexto.value = parseInt(zTexto.value) + 1;
		            zControl.value = parseInt(zControl.value) + 1;
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
		            
		            
		            
		            //zTexto.value = parseInt(zTexto.value) - 1; //Cambiamos el texto del zoom
		            zControl.value = parseInt(zControl.value) - 1; //Cambiamos el slider del zoom
		            document.getElementById("zoom_texto").value = paper.view.zoom;
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
		
		
	