@busway:#8CC63F;
@express:#E41A1C;
@local:#377EB8;
@newbritain:#FF7F00;
@amtrak:#FFFF33;
@metronorth:#984EA3;
@default:#aaa;

.stops {
  marker-fill:darken(@default, 10%);
  marker-line-color:darken(@default, 20%);
  marker-width:1;
  marker-opacity:0.8;
  marker-allow-overlap:true;
  
  [zoom<13] {
    marker-width:0;
  }
}

.routes {
  line-width:1;
}

#busway {  
  line-width:4;
  line-color:@busway;
}

#buswaystops {
  marker-width:2;
  marker-fill:darken(@busway, 10%);
  marker-line-color:darken(@busway, 20%);
}

#new20britain20routes {
  line-color:@newbritain;
}

#new20britain20stops2 {
  marker-fill:darken(@newbritain, 10%);
  marker-line-color:darken(@newbritain, 20%);
}

#expressroutesapril22 {
  line-width:2;
  line-color:@express;
}

#hartfordbusstopsapri {
}

#localroutesapril222c {
  line-color:@local;
}

#btsamtraklines {
  line-color:@amtrak;
}

#btsamtraksta {
  marker-fill:darken(@amtrak, 10%);
  marker-line-color:darken(@amtrak, 20%);
}

#statect3780000002010 {
  line-color:#594;
  line-width:0.5;
  polygon-opacity:1;
  polygon-fill:none;
}

#townct3780000002010s {
  line-color:@default;
  line-width:0.5;
  polygon-opacity:0;
}

#metronorthrrroutes10 {
  line-color:@metronorth;
}


#metronorthrrstops100 {
  marker-fill:darken(@metronorth, 10%);
  marker-line-color:darken(@metronorth, 20%);
}
