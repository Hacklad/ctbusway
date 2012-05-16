@boundary:#999;
@busway:saturate(#8CC63F, 20%);
@express_bus:#4DAF4A;
@busway_local:#FF7F00;
@local_feeder_bus:#984EA3;
@connector_circulator_bus:#E41A1C;

@amtrak:#377EB8;
@metro_north:#A65628;
@default:#999;

.stops {
  ::interactionbuffer {
    marker-width:8;
    marker-opacity:0.0;
    marker-line-opacity:0.0;
  }
  
  [zoom = 12] { marker-width:2.5; }
  [zoom >= 13] { marker-width:3; }
  
  marker-width:2;
  marker-fill:@default;
  marker-line-color:@default;
  marker-allow-overlap:true;
}

.stops [type='amtrak'] {
  marker-fill:@amtrak;
  marker-line-color:@amtrak;
}

.stops [type='metro_north'] {
  marker-fill:@metro_north;
  marker-line-color:@metro_north;
}

.stops[type='busway'] {   
  [zoom = 12] { 
    marker-width:14; 
    marker-line-width:2;
  }
  [zoom >= 13] { 
    marker-width:16; 
    marker-line-width:3;
  }

  marker-width:8;
  marker-fill:@busway;
  marker-line-color:#fff;
  marker-opacity:1;
  marker-line-width:1.5;
  marker-line-opacity:0.9
}