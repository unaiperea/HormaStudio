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
			
			//TODO En vez de escalar la im�gen al cargarla que le haga Zoom y que el tama�o del canvas no se modifique nunca******************
			
			//while (tempW > MAX_WIDTH || tempH > MAX_HEIGHT){
				/*$('#canvas_croquis').width();
					for (i=0 ; i < 10 ; i++){
						setMenosZoom();
						$('#canvas_croquis').width();
					}*/

				//document.getElementById("zoom_texto").value = document.getElementById("control_zoom").value;
			//}
			
			
			
			if (tempW >= tempH){ //Si la anchura de la im�gen es mayor que la altura de la im�gen se coge la anchura de la im�gen
				if (tempW >= MAX_WIDTH){ //Si la im�gen es mayor (en cuanto a anchura) que la del canvas, que permanezca la anchura del canvas
					//Pero si la altura sigue siendo m�s grande que el canvas se reduce con respecto a lo alto del canvas
					if (Math.floor((tempH * MAX_WIDTH) / tempW) > MAX_HEIGHT){
						//Reducir im�gen seg�n altura del canvas
						//tempW = Math.floor((tempW * MAX_HEIGHT) / tempH);
						//imagenRaster.height = tempH = MAX_HEIGHT;
						//canvas.width = imagenRaster.width = tempW;
						//canvas.style.width = tempW + 'px'; //Le da m�s calidad
						
			            //paper.view.zoom /= tool.zoomFactor;
			            //var ratioZoomFactor = ((MAX_WIDTH / MAX_HEIGHT) / 1) * (tempW / tempH);
			            var ratioZoomFactor = (tempH / MAX_HEIGHT);
			            
					}else{
						//Reducir im�gen seg�n anchura del canvas
						tempH = Math.floor((tempH * MAX_WIDTH) / tempW); //Redondeo hacia abajo el redimensionamiento
						imagenRaster.width = tempW = MAX_WIDTH; //OJO CON EL MARCO DEL CANVAS
						canvas.height = imagenRaster.height = tempH;
						canvas.style.height = tempH + 'px';
					}
				}else{ //Reducir canvas
					canvas.width = tempW;
					canvas.style.width = tempW + 'px'; //Le da m�s calidad
					canvas.height = tempH;
					canvas.style.height = tempH + 'px'; //Le da m�s calidad
				}
			}else{ //Si la altura de la im�gen es mayor que la anchura de la im�gen se coge la altura de la im�gen
				if (tempH > MAX_HEIGHT){ //Si la im�gen es mayor (en cuanto a altura) que la del canvas, que permanezca la altura del canvas
					//Pero si la anchura sigue siendo m�s grande que el canvas se reduce con respecto a lo ancho del canvas
					if (Math.floor((tempW * MAX_HEIGHT) / tempH) > MAX_HEIGHT){
						//Reducir im�gen
						tempW = Math.floor((tempW * MAX_HEIGHT) / tempH);
						imagenRaster.height = tempH = MAX_HEIGHT;
						canvas.width = imagenRaster.width = tempW;
						canvas.style.width = tempW + 'px'; //Le da m�s calidad
					}else{
						//Reducir im�gen seg�n anchura del canvas
						tempH = Math.floor((tempH * MAX_WIDTH) / tempW); //Redondeo hacia abajo el redimensionamiento
						imagenRaster.width = tempW = MAX_WIDTH; //OJO CON EL MARCO DEL CANVAS
						canvas.height = imagenRaster.height = tempH;
						canvas.style.height = tempH + 'px';
					}
				}else{ //Reducir canvas
					canvas.width = tempW;
					canvas.style.width = tempW + 'px'; //Le da m�s calidad
					canvas.height = tempH;
					canvas.style.height = tempH + 'px'; //Le da m�s calidad
				}
			}
			
			var point = paper.view.viewToProject(paper.view.center); //point //Convertimos a coordenadas dentro del proyecto
			var zoomCenter = point.subtract(paper.view.center); 
			var moveFactor = tool.zoomFactor - 1.0;
			paper.view.zoom /= ratioZoomFactor;
            paper.view.center = paper.view.center.subtract(zoomCenter.multiply(moveFactor));
			
			// now scale the context to counter
	        // the fact that we've manually scaled
	        // our canvas element
	        /*contexto.scale(ratio, ratio);
			
			var puntoCentroImagen = new paper.Point(tempW / 2, tempH / 2);
			imagenRaster.position = puntoCentroImagen;
			paper.view.draw;*/
		}