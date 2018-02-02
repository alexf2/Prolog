
DOMAINS
  VectorTyp = real*
  MatrTyp   = VectorTyp*
  
  NClm, NStr = integer
  IndexTyp, StaCValue, StaSValue = real
  
  ExtMax, ExtMin = real
  CellTyp = real
  
  
GLOBAL PREDICATES
  input_format( NClm, NStr ) - (o, o)
  
  input_vector( VectorTyp, NClm ) - (o, i)
  input_matr( MatrTyp, NClm, NStr ) - (o, i, i)
  
  init_vector( VectorTyp, NClm, StaCValue ) - (o, i, i)   
  init_matr( MatrTyp, NClm, NStr, StaCValue ) - (o, i, i, i )
  
  print_vector( VectorTyp ) - (i)
  print_matr( MatrTyp ) - (i)

  /*sorte_vector( VectorTyp, VectorTyp ) - (i o)  */
  
  nondeterm find_extent_vec( VectorTyp, ExtMax, ExtMin ) - (i, o, o)
  nondeterm find_extent_matr( MatrTyp, ExtMax, ExtMin ) - (i, o, o)
  
  nondeterm min( ExtMin, ExtMin, ExtMin ) - (i, i, o)
  nondeterm max( ExtMax, ExtMax, ExtMax ) - (i, i, o)
  
  index_of_vec( VectorTyp, IndexTyp, CellTyp  ) - (i, i, o)
  index_of_matr( MatrTyp, IndexTyp, IndexTyp, CellTyp ) - (i, i, i, o)
   
  
  cut_str( MatrTyp, IndexTyp, VectorTyp ) - (i, i, o)
  
  calc_of_vec( VectorTyp, IndexTyp, IndexTyp, CellTyp ) - (i, i, i, o)
  calc_of_matr( MatrTyp, IndexTyp, IndexTyp, IndexTyp, IndexTyp, CellTyp ) -
    (i, i, i, i, i, o)
    
  nondeterm common_list( VectorTyp, VectorTyp, VectorTyp ) - (i, i, o)
  
  nondeterm matr_to_vector( MatrTyp, VectorTyp ) - (i, o)
  
  nondeterm insert_sort( VectorTyp, VectorTyp ) - (i, o)
  insert( CellTyp, VectorTyp, VectorTyp ) - (i, i, o)
  cmp( CellTyp, CellTyp ) - (i, i)
 
  reverse( VectorTyp, VectorTyp ) - (i, o)    
  reverse( VectorTyp, VectorTyp,  VectorTyp ) - (i, i, o)
  

CLAUSES
  input_format( Clm, Str ):-
    write( "Input number of Str. >" ),
    readint( Str ), 
    write( "Input number of Clm. >" ),
    readint( Clm ).
    

  input_vector( [], 0 ):- !.  
  input_vector( Vector, SizeOfVector ):-    
    Count = SizeOfVector - 1,    
    writef( "\t>" ),
    readreal( Cell ),
    input_vector( TmpVec, Count ),
    Vector = [Cell | TmpVec].
  
  
  input_matr( [], _, 0 ):- !.
  input_matr( Matr, Width, Length ):-    
    Count = Length - 1,  
    input_vector( Vec, Width ), nl,
    input_matr( TmpMatr, Width, Count ),
    Matr = [Vec | TmpMatr].
    
  
  init_vector( [], 0, _ ):- !.
  init_vector( Vector, Clm, Value ):-    
    Count = Clm - 1,
    NextValue = Value + 1,
    init_vector( TmpVector, Count, NextValue ),
    Vector = [Value | TmpVector].
  

  init_matr( [], _, 0, _ ):- !.
  init_matr( Matr, Clm, Str, CValue ):-    
    Count = Str - 1,    
    NextValue = CValue * 2,
    init_vector( Vector, Clm, CValue ),
    init_matr( TmpMatr, Clm, Count, NextValue ),
    Matr = [Vector | TmpMatr ].
  
  print_vector( [] ):- !.
  print_vector( [H | T] ):- writef( "%7f ", H ), print_vector( T ).
  
  print_matr( [] ):- !.
  print_matr( [H | T] ):- print_vector( H ), nl, print_matr( T ).
  
  /*sorte_vector( [], [] ):- !.
  sorte_vector( VecInp, VecOut ):-*/
  
  find_extent_vec( [], 0, 65535 ):- !.
  find_extent_vec( [H | T], Max, Min ):-
    find_extent_vec( T, TMax, TMin ),
    max( H, TMax, Max ),
    min( H, TMin, Min ).
  
  find_extent_matr( [], 0, 65535 ):- !.  
  find_extent_matr( [H | T], Max, Min ):-
    find_extent_vec( H, VMax, VMin ),
    find_extent_matr( T, TMax, TMin ),
    max( VMax, TMax, Max ),
    min( VMin, TMin, Min ).
  
  max( V1, V2, Res ):- 
    V1 > V2, Res = V1;
    Res = V2.
    
  min( V1, V2, Res ):-
    V1 < V2, Res = V1;
    Res = V2.

  index_of_vec( [H | _], 0, H ):- !.
  index_of_vec( [_ | T], Ind, Data ):-
    NextInd = Ind - 1,
    index_of_vec( T, NextInd, Data ).
    
  index_of_matr( [H | _], 0, IndClm, Data ):- index_of_vec( H, IndClm, Data ), !. 
  index_of_matr( [_ | T], IndStr, IndClm, Data ):-
    NextInd = IndStr - 1,
    index_of_matr( T, NextInd, IndClm, Data ).
    
  cut_str( [H | _], 0, H ):- !.  
  cut_str( [_ | T], IndStr, Str ):-
    NextInd = IndStr - 1,
    cut_str( T, NextInd, Str ).
    
    
  calc_of_vec( _, Ind1C, Ind2C, 0 ):- Ind1C > Ind2C, !.  
  calc_of_vec( Vec, Ind1C, Ind2C, Res ):-
    NextInd = Ind1C + 1,
    index_of_vec( Vec, Ind1C, Data ),
    calc_of_vec( Vec, NextInd, Ind2C, TRes ),
    Res = Tres + Data.
       
     
  calc_of_matr( _, Ind1S, Ind2S, _, _, 0 ):- Ind1S > Ind2S, !.    
  calc_of_matr( Matr, Ind1S, Ind2S, Ind1C, Ind2C, Res ):-
    NextInd = Ind1S + 1,
    cut_str( Matr, Ind1S, Vec ),
    calc_of_vec( Vec, Ind1C, Ind2C, VRes ),  
    calc_of_matr( Matr, NextInd, Ind2S, Ind1C, Ind2C, TRes ),
    Res = TRes + VRes.
    
  common_list( [], L, L ).
  common_list( [H | L1], L2, [H | L3] ):-
    common_list( L1, L2, L3 ).
    
  matr_to_vector( [], [] ):- !.  
  matr_to_vector( [H | L], Vec ):-
    matr_to_vector( L, TVec ),
    common_list( H, TVec, Vec ).

  insert_sort( [], [] ).
  insert_sort( [X | T], Sorted ):-
    insert_sort( T, SortedT ),
    insert( X, SortedT, Sorted ).
    
  insert( X, [Y | Sorted], [Y | Sorted1] ):-
    cmp( X, Y ), !,
    insert( X, Sorted, Sorted1 ).
  insert( X, Sorted, [X | Sorted] ).
  
  cmp( X, Y ):- X > Y.
      
  reverse( Xs, Ys ):- reverse( Xs, [], Ys ).
  
  reverse( [X | Xs], Acc, Ys ):- reverse( Xs, [X | Acc], Ys ).
  reverse( [], Ys, Ys ).
    
  
GOAL  
  trace(off),
  
  input_format( Clm, Str ),   
  writef( "Input matrix [%ux%u]:\n", Str, Clm ), 
  
  input_matr( Matr, Clm, Str ),
  
  writef( "Matrix [%ux%u]:\n", Str, Clm ), 
  print_matr( Matr ),
  
  find_extent_matr( Matr, ExtMax, ExtMin ),
  writef( "Min = %f Max = %f\n", ExtMin, ExtMax ),
  
  index_of_matr( Matr, 0, 0, Data ),
  
 
  calc_of_matr( Matr, 0, 2, 2, 2, Summ ), 
  trace(off),
  writef( "Cell 0,0: %f; summ in Str 1-2 of 1-2: %f\n", Data, Summ ),
  
   
  init_matr( Matr2, Clm, Str, 1 ),
  writef( "\nInitialized matrix:\n" ), 
  print_matr( Matr2 ),
  
  matr_to_vector( Matr, V2 ),
  writef( "Matrix1 --> vector: [" ),
  print_vector( V2 ),
  writef( "]\n" ),
  
  insert_sort( V2, VSort ),
  writef( "Vector1 --> Sorted: [" ),
  print_vector( VSort ),
  writef( "]\n" ),
 
  trace(on), 
  reverse( V2, VRev ),
  writef( "Vector1 --> Reversed: [" ),
  print_vector( VRev ),
  writef( "]\n" ).
  
  