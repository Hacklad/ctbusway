@boundary:#999;
@busway:#c7ef92;
@amtrak:#E41A1C;
@metro_north:#9e1114;

.stops {
  ::interactionbuffer {
    marker-width:8;
    marker-opacity:0.0;
    marker-line-opacity:0.0;
  }

  [zoom = 12] { marker-width:4; }
  [zoom >= 13] { marker-width:5; }

  marker-width:3;
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
    marker-width:8;
    marker-line-width:1.6;
  }
  [zoom >= 13] {
    marker-width:10;
    marker-line-width:2.0;
  }

  marker-width:6;
  marker-fill:@busway;
  marker-line-color:#fff;
  marker-opacity:1;
  marker-line-width:1.2;
  marker-line-opacity:0.9;
}

.poi {
  [Type='Mall'] { point-file: url('img/maki/shop-12.png')}
  [Type='Medical'] { point-file: url('img/maki/hospital-12.png')}
  [Type='College/University/Adult'] { point-file: url('img/maki/college-18.png')}
}