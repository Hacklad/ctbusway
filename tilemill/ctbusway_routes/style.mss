@boundary:#454545;
@busway:saturate(#8CC63F, 20%);
// Express Bus
@express_bus:#084594;

@local_feeder_bus:#9ECAE1;

// Proposed New Local Bus Routes
@busway_local:#FF7F00;
@connector_circulator_bus:#FF7F00;

@amtrak:#E41A1C;
@metro_north:#9e1114;

@trail:#000;

@texthalo: #f1f1f1;
@text: #444;

@importanttextsize:15;

.routes {
  ::interactionbuffer {
    line-width:6;
    line-opacity:0.0;
  }

  [zoom = 12] { line-width:1.5;}
  [zoom >= 13] { line-width:2;}

  line-width:1;
  line-opacity:1;
  line-smooth:0.5;
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
  [zoom = 11] { line-width:1.5;}
  [zoom = 12] { line-width:2;}
  [zoom >= 13] { line-width:2.5;}
}

.routes [type='amtrak'] {
  ::dashes {
    line-color:@amtrak;
    line-dasharray: 1,6;
    [zoom = 11] { line-width:4;}
    [zoom = 12] { line-width:5;}
    [zoom >= 13] { line-width:6;}
  }
  
  /* no busway, but parallel */
  line-color:@amtrak;
  [zoom = 11] { line-width:2;}
  [zoom = 12] { line-width:2.5;}
  [zoom >= 13] { line-width:3;}
}

.routes [type='metro_north'] {
  ::dashes {
    line-color:@metro_north;
    line-dasharray: 1,6;
    [zoom = 11] { line-width:4;}
    [zoom = 12] { line-width:5;}
    [zoom >= 13] { line-width:6;}
  }

  /* no busway */
  line-color:@metro_north;
  [zoom = 11] { line-width:2;}
  [zoom = 12] { line-width:2.5;}
  [zoom >= 13] { line-width:3;}
}

.routes::on_top[type='busway'] {
  ::outline[name!='CTfastrak Downtown Loop'] {
    [zoom = 11] { line-width:12;}
    [zoom = 12] { line-width:16;}
    [zoom >= 13] { line-width:18;}

    line-color:@busway;
    line-opacity:0.4;
    line-width:10;
  }

  line-width:1;
  line-color:transparent;
  line-pattern-file:url('img/express_local_1.png');

  [zoom >= 12] {line-pattern-file:url('img/express_local_2.png');}
}

#mulitusetrail {
  line-width:1;
  line-color:transparent;
  line-pattern-file:url('img/multiusetrail_1.png');
  
  [zoom >= 12] {line-pattern-file:url('img/multiusetrail_2.png');}
}

#towns {
  line-color:@boundary;
  line-dasharray:1,2;
  line-width:0.5;
  line-opacity:0.5;

  text-name:'[NAME10]';
  text-face-name:'Helvetica Neue Medium';
  text-fill:@text;
  text-character-spacing: 0.5;
  text-halo-fill:@texthalo;
  text-halo-radius:2;
  text-size:10;

  [NAME10='Hartford'] {
    text-size:@importanttextsize;
    [zoom = 11] { text-dx:17; text-dy:-12; }
    [zoom = 12] { text-dx:30; text-dy:-25; }
    [zoom = 13] { text-dx:50; text-dy:-45; }
  }

  [NAME10='West Hartford'] {
    text-size:@importanttextsize;
  }

  [NAME10='Newington'] {
    text-size:@importanttextsize;
    text-horizontal-alignment:left;
    [zoom = 11] { text-dx:45; }
    [zoom = 12] { text-dx:35; text-dy:15; }
  }

  [NAME10='Waterbury'] {
    text-size:@importanttextsize;
  }
  
  [NAME10='New Britain'] {
    text-size:@importanttextsize;
    text-horizontal-alignment:left;
    [zoom = 11] { text-dx:15; }
  }

  [NAME10='New Haven'] {
    text-size:@importanttextsize;
  }

  [NAME10='Meriden'] {
    [zoom = 11] { text-dx:5; }
  }

  [NAME10='Berlin'] {
    text-horizontal-alignment:left;
    [zoom = 11] { text-dx:5; }
  }
  
  [NAME10='County subdivisions not defined'] {
    text-fill:transparent;
    text-halo-fill:transparent;
  }
}
