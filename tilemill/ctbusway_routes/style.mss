@boundary:#999;
@busway:saturate(#8CC63F, 20%);
@express_bus:#E41A1C;
@busway_local:#984EA3;
@local_feeder_bus:#FF7F00;
@connector_circulator_bus:#4DAF4A;

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
 
  [zoom = 12] { line-width:2;}
  [zoom >= 13] { line-width:3;}

  line-width:1.3;
  line-opacity:0.8;
}

.routes [type='local_feeder_bus'] {
  /* no busway */
  line-color:@local_feeder_bus;
}

.routes [type='busway_local'] {
  /* all busway */
  line-color:@busway_local;
}

.routes [type='connector_circulator_bus'] {
  /* no busway */
  line-color:@connector_circulator_bus;
}

.routes [type='express_bus'] {
  /* all busway */
  line-color:@express_bus;
}

.routes [type='amtrak'] {
  /* no busway, but parallel */
  line-color:@amtrak;
}

.routes [type='metro_north'] {
  /* no busway */
  line-color:@metro_north;
}

.routes::on_top[type='busway'] {
  ::outline {
    [zoom = 11] { line-width:15;}
    [zoom = 12] { line-width:20;}
    [zoom >= 13] { line-width:23;}
    
    line-color:@busway;
    line-opacity:0.5;
    line-width:10;
  }
  
  line-width:10;
  /* line-color:@busway; */
  line-color:transparent;
  line-pattern-file:url('img/express_local_1.png');
  
  [zoom >= 12] {line-pattern-file:url('img/express_local_2.png');}
}
/*
#busway {
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
*/