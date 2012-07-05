@busway:#bbe386;
@amtrak:#E41A1C;
@metro_north:#9e1114;
@texthalo: #e3f0cb;
@text: #444;

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
  [zoom < 12] {
    // A lot of work to hide something
    text-fill:transparent;
    text-halo-fill:transparent;
    text-size:0;
    text-character-spacing: 0;
  }
  [zoom = 12] {
    text-dx:8;
    text-dy:2;
    marker-width:8;
    marker-line-width:1.6;
    
    [name='Downtown New Britain'] {
      text-dx:4;
      text-dy:8;
    }
    [name='Union Station'] {
      text-dy:-4;
      text-dx:-7;
    }
    [name='Sigourney Street'] {
      text-dy:-2;
      text-dx:-8;
    }
  }
  [zoom >= 13] {
    text-dx:10;
    text-dy:3;
    text-size:12;
    marker-width:10;
    marker-line-width:2.0;
    
    [name='Downtown New Britain'] {
      text-dx:4;
      text-dy:10;
    }
    [name='Union Station'] {
      text-dy:-10;
      text-dx:-2;
    }
    [name='Sigourney Street'] {
      text-dy:-10;
      text-dx:-2;
    }
  }

  marker-width:6;
  marker-fill:@busway;
  marker-line-color:#444;
  marker-opacity:1;
  marker-line-width:1.2;
  marker-line-opacity:0.9;
  
  text-name:'[name]';
  text-face-name:'Helvetica Neue Medium', 'HelveticaNeue Medium';
  text-fill:@text;
  text-character-spacing: 0.5;
  text-halo-fill:@texthalo;
  text-halo-radius:3;
  text-allow-overlap: true;
}

.poi {
  [Type='Mall'] { point-file: url('img/maki/shop-12.png')}
  [Type='Shopping'] { point-file: url('img/maki/shop-12.png')}
  [Type='Medical'] { point-file: url('img/maki/hospital-12.png')}
  [Type='College/University/Adult'] { point-file: url('img/maki/college-18.png')}
}

.parking[Status='Active'] {
  point-file: url('img/maki/parking-18.png');
}