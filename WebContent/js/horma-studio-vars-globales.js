/**
 * 
 * Variables globales de HormaStudio para interactuar entre las funciones de la aplicación
 * y las funciones de los controles de la interfaz
 * 
 */

	
	var canvas; //Para getMousePos(); sino meterlo dentro de onload
  	var contexto;
	var imagenRaster;
	
	//controles de ....
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
    var originalZoom;
    var originalCentro;
    var ratioZoomFactor;
    var diferenciaZoom;
    
    var capaImagen;
	var capaVectorial;