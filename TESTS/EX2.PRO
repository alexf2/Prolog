PREDICATES

  type( symbol ).
  is_a( symbol, symbol ).
  lives( symbol, symbol ).
  can_swim( symbol ).
  can_swim2( symbol ).
  
  
CLAUSES
  type( "����⭮�" ).
  type( "�론" ).
  type( "�����������" ).
  
  is_a( "����", "����⭮�" ).
  is_a( "��㫠", "�론" ).
  is_a( "����", "����⭮�" ).
  is_a( "���", "�론" ).
  is_a( "�ப����", "�����������" ).
  is_a( "���誠", "�����������" ).
  
  lives( "����⭮�", "�� �����" ).
  lives( "�론", "� ����" ).
  lives( "�����������", "� ����" ).
  
  can_swim( X ):- is_a( X, Y ), write( Y, " " ), lives( Y, "� ����" );
    is_a( X, "�����������" ); lives( X, "� ����" ). 
    
  can_swim2( X ):- type( Y ), is_a( X, Y ), lives( Y, "� ����" ). 
   
goal
  can_swim( "���" ).
     