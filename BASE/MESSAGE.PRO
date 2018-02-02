
PREDICATES
  make_message( string, string, char, char )

CLAUSES
  message( StrToPrint, flError ):-
    make_message( StrToPrint, " Error ", 79, 78 ), !.
  message( StrToPrint, flMessage ):-
    make_message( StrToPrint, " Message ", 240, 249 ), !.

  make_message( StrToPrint, Title, Atr1, Atr2 ):-
    str_len( StrToPrint, Len ),
    textmode( TRows, TCols ),
    Control = TCols - 6,
    Len <= Control,
    Column = (TCols - Len - 6) / 2,
    LenW = Len + 6,
    Rows = (Trows - 7) / 2,
    makewindow( 100, Atr1, Atr2, Title, Rows, Column, 5, LenW, 1, 255,
		"ɻȼͺ" ),    
    writef( "\n  %s", StrToPrint ),
    hint( "Accept this window" ),
    readchar( _ ),
    removewindow, 
    remake_main_win, !.

  make_message( StrToPrint, Title, Atr1, Atr2 ):-    
    makewindow( 100, Atr1, Atr2, Title, 7, 4, 9, 72, 1, 255,
		"ɻȼͺ" ), 
    hint( "Esc - return to menu  \24\25\26\27, PgUp, PgDown, Home, End - scroll window" ),
    display( StrToPrint ),
    removewindow, 
    remake_main_win, !.
    
  
  