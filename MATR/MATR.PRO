constants
  colorDef   = 7
  colorMatr  = 15
  colorCalc  = 2


domains
  matrStr  = real*
  matrTyp  = matrStr*


predicates 
  print_title
  
  input_format( integer )
  check_format( integer )
  
  input_matr( matrTyp )
  read_matr( matrTyp, integer, integer )
  read_m_str( matrStr, integer, integer, integer )
  
  print_matr( matrTyp, integer )
  print_m_str( matrStr, integer )
  
  my_read_real( real )
  
  calc_multi( matrTyp, real, integer )
  calc_multi_str( matrStr, real, integer )
  
  repeat
  
  check_color( integer )


clauses

  repeat.
  repeat:-repeat.

  print_title:- write( "\n(c)AlexCorp.  Вычисление произведения элементов под главной диагональю\n",
                       "               квадратной матрицы\n" ).
                       
  check_format( MatrFormat ):- 
    MatrFormat < 2, 
    write( "Ошибка ввода, нужна размерность n >= 2\n" ), fail; 
    MatrFormat > 1.

    
  input_format( MatrFormat ):-  
    repeat,                   
      write( "\nВведите размерность квадратной матрицы (n) >" ),
      readint( MatrFormat ),
    check_format( MatrFormat ), !.

    
  input_matr( Matr ):-  
    input_format( MatrFormat ),
    writef( "Введите матрицу [%ux%u] построчно >\n", MatrFormat, MatrFormat ),
    read_matr( Matr, MatrFormat, MatrFormat ).
    
        
  read_matr( [[]], _, 0 ).

  read_matr( Matr, MatrFormat, Count ):-
    CurStrNumb = MatrFormat - Count + 1,    
    read_m_str( MatrStr, MatrFormat, CurStrNumb, MatrFormat ),  
    writef( "\n" ),
    NextNumb = Count -1,        
    
    read_matr( TmpMatr, MatrFormat, NextNumb ),        
    
    Matr = [MatrStr | TmpMatr].
    
    
  my_read_real( ReadReal ):-
    readreal( TmpReal ), ReadReal = TmpReal;
    writef( "Ошибка ввода, повторите ввод элемента\n" ), 
    fail.
    
  read_m_str( [], 0, _, _ ).
  
  read_m_str( MatrStr, Size, CurStrNumb, MatrFormat ):-
    repeat,
      CurPosNumb = MatrFormat - Size + 1,
      writef( "\t[%d,%d] > ", CurStrNumb, CurPosNumb ), 
    my_read_real( CurReal ),
    NextNumb = Size -1,
    
    read_m_str( TmpMatrStr, NextNumb, CurStrNumb, MatrFormat ),
    
    MatrStr = [CurReal | TmpMatrStr].
    
    
  print_matr( [[]], _ ).
  
  print_matr( [Head | Tail], Count ):-
    attribute( colorCalc ),  
    print_m_str( Head, Count ), 
    nl, 
    NextCount = Count + 1,    
    
    print_matr( Tail, NextCount ),
    
    attribute( colorMatr ), !.
    
    
  check_color( Count ):- 
    Count = 0, attribute( colorMatr );
    true.  
    
    
  print_m_str( [], _ ).
  
  print_m_str( [Head | Tail], Count ):-    
    check_color( Count ),  
    writef( " %5g", Head ), 
    NextCount = Count - 1,
    
    print_m_str( Tail, NextCount ).
    
    
  calc_multi( [[]], 1, _ ).
  
  calc_multi( [Head | Tail], Multi, Count ):-    
    calc_multi_str( Head, StrMulti, Count ),
    NextCount = Count + 1,
      
    calc_multi( Tail, TmpMulti, NextCount ),
    
    Multi = TmpMulti * StrMulti.    
    
    
  calc_multi_str( _, 1, 0 ).  
  
  calc_multi_str( [Head | Tail], Multi, Count ):-   
    NextCount = Count - 1,
    
    calc_multi_str( Tail, TmpMulti, NextCount ),    
    
    Multi = TmpMulti * Head.  
   
   
goal

  attribute( colorDef ),  
  print_title,
  
  input_matr( Matr ),
  writef( "\nВведенная матрица:\n" ),
  print_matr( Matr, 0 ),     
  attribute( colorDef ),
  
  calc_multi( Matr, Multi, 0 ),
  
  writef( "\nПроизведение = "),
  attribute( colorCalc ),
  writef( "%g\n", Multi ),
  attribute( colorDef ).
  
  
