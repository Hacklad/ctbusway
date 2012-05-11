@boundary:#999;
@busway:saturate(#8CC63F, 20%);
@express_bus:#4DAF4A;
@busway_local:#FF7F00;
@local_feeder_bus:#984EA3;
@connector_circulator_bus:#E41A1C;

@amtrak:#377EB8;
@metro_north:#A65628;
@default:#999;

#towns {
  line-color:@boundary;
  line-dasharray:1,2;
  line-width:0.5;
}

.routes {
  ::interactionbuffer {
    line-width:8;
    line-opacity:0.0;
  }
  
  line-join:round;
  line-cap:round;
  line-width:2;
  line-opacity:1;
}

.routes [type='local_feeder_bus'] {
  [zoom >= 12] { line-width:1;}
  [zoom >= 13] { line-width:1.3;}
  [zoom >= 14] { line-width:1.6;}
  
  line-width:0.6;
  line-color:@local_feeder_bus;
}

.routes [type='busway_local'] {

  line-color:@busway_local;
}

.routes [type='connector_circulator_bus'] {
  line-color:@connector_circulator_bus;
}

.routes [type='express_bus'] {
  line-color:@express_bus;
}

.routes [type='amtrak'] {

  line-color:@amtrak;
}

.routes [type='metro_north'] {

  line-color:@metro_north;
}

.routes::on_top[type='busway'] {
  ::outline {
    [zoom >= 12] { line-width:5;}
    [zoom >= 13] { line-width:5.5;}
    [zoom >= 14] { line-width:6;}

    
    line-color:darken(@busway, 30%);
    line-opacity:0.8;
    line-width:4.5;
  }

  [zoom >= 12] { line-width:3.5;}
  [zoom >= 13] { line-width:4;}
  [zoom >= 14] { line-width:4.5;}

  line-width:3;
  line-color:@busway;
}
