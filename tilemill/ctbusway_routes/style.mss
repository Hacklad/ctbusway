@boundary:#454545;
@busway:saturate(#8CC63F, 20%);
// Express Bus
@express_bus:#084594;

@local_feeder_bus:#9ECAE1;

// Proposed New Local Bus Routes
@busway_local:#FF7F00;
@connector_circulator_bus:#FF7F00; //4DAF4A;

@amtrak:#E41A1C;
@metro_north:#238B45;

@texthalo: #f1f1f1;
@text: #444;
@importanttextsize:14;

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
}

.routes {
  ::interactionbuffer {
    line-width:8;
    line-opacity:0.0;
  }

  [zoom = 12] { line-width:1.5;}
  [zoom >= 13] { line-width:2;}

  line-width:1;
  line-opacity:1;
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

  [name='BX2 Cheshire Express'] {
    line-dasharray: 4,8;
    line-width:2;
    line-color:#fff;
  }
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