@boundary:#999;
@busway:saturate(#8CC63F, 20%);

@express_bus:#084594; //377EB8;

@local_feeder_bus:#9ECAE1; //FF7F00

// Proposed New Local Bus Routes
@busway_local:#FF7F00; //984EA3;
@connector_circulator_bus:#FF7F00; //4DAF4A;

@amtrak:#E41A1C;
@metro_north:#238B45;

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
 
  [zoom = 12] { line-width:1.5;}
  [zoom >= 13] { line-width:2;}

  line-width:1;
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
  
  line-width:1;
  line-color:transparent;
  line-pattern-file:url('img/express_local_1.png');
  
  [zoom >= 12] {line-pattern-file:url('img/express_local_2.png');}
}

/*
#busway {
  [zoom = 12] { 
    marker-width:8; 
    marker-line-width:1.6;
  }
  [zoom >= 13] { 
    marker-width:10; 
    marker-line-width:2.0;
  }

  marker-width:6;
  marker-fill:#c7ef92;
  marker-line-color:#fff;
  marker-opacity:1;
  marker-line-width:1.2;
  marker-line-opacity:0.9
}
*/