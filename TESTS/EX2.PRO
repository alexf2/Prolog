PREDICATES

  type( symbol ).
  is_a( symbol, symbol ).
  lives( symbol, symbol ).
  can_swim( symbol ).
  can_swim2( symbol ).
  
  
CLAUSES
  type( "копытное" ).
  type( "рыба" ).
  type( "земноводное" ).
  
  is_a( "зебра", "копытное" ).
  is_a( "акула", "рыба" ).
  is_a( "конь", "копытное" ).
  is_a( "ерш", "рыба" ).
  is_a( "крокодил", "земноводное" ).
  is_a( "лягушка", "земноводное" ).
  
  lives( "копытное", "на земле" ).
  lives( "рыба", "в воде" ).
  lives( "земноводное", "в воде" ).
  
  can_swim( X ):- is_a( X, Y ), write( Y, " " ), lives( Y, "в воде" );
    is_a( X, "земноводное" ); lives( X, "в воде" ). 
    
  can_swim2( X ):- type( Y ), is_a( X, Y ), lives( Y, "в воде" ). 
   
goal
  can_swim( "ерш" ).
     