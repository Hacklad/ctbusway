@busway:#8CC63F;
@express:#E41A1C;
@local:#377EB8;
@newbritain:#FF7F00;
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
  line-width:3;
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
  line-color:@express;
}

#hartfordbusstopsapri {
}

#localroutesapril222c {
  line-color:@local;
}
