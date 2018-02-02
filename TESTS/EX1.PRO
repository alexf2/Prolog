PREDICATES

  capital( symbol, real, symbol ).
  in( symbol, symbol ).
  part_of_world( symbol, symbol, symbol ).
  peoples( symbol, real, symbol ).
  print_cap().

CLAUSES

  capital( moscow, 10.5, russia ).
  capital( "New york", 12, usa ).
  capital( buenos_aries, 4.5, "Аргентина" ).
  /*in( "Аргентина", america ).
  in( usa, america ).
  in( russia, europe ). */
  part_of_world( X, Y, Z ):- capital( X, _, Z ), in( Z, Y ).
  peoples( X, R, Y ):- capital( X, R, Y).
  in( Capital, Part ):- capital( Capital, _, Part ).
  print_cap():- capital( X, _, _ ), write( X, "\n" ), fail.
  
  