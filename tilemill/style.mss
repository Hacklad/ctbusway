@busway:#8CC63F;
@express:#E41A1C;
@local:#377EB8;
@newbritain:#FF7F00;
@amtrak:#FFFF33;
@metronorth:#984EA3;
@all:#F781BF;
@default:#aaa;

.stops {
  marker-fill:darken(@default, 10%);
  marker-line-color:darken(@default, 20%);
  marker-width:0;
  marker-opacity:1;
  marker-allow-overlap:true;  
}

.routes {
  line-width:1;
}

#busway {  
  line-width:4;
  line-color:@busway;
}

#buswaystops {
  marker-width:3;
  marker-fill:darken(@busway, 5%);
  marker-line-color:@busway;
}

.stops[zoom>12] {
  marker-width:1;
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

#allroutesbusway {
  line-color:@all;
}
