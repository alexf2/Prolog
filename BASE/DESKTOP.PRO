
PREDICATES

  nondeterm remove_windows( integer, integer )

CLAUSES

  hint( HintStr ):- trace(off),    
    textmode( Rows, Col ),    
    Y = Rows - 1,
    Col_ = Col - 1,
    makewindow( 100, 0, 0, "", 0, 0, Rows, Col, 0, 255, "      " ),   
    field_str( Y, 1, Col_, HintStr ),
    field_attr( Y, 0, Col, 240 ),
    removewindow( 100, 0 ).
    
    
  check_remov( WinNumb ):- 
    existwindow(WinNumb), 
    gotowindow(WinNumb), 
    removewindow(WinNumb, 0).
   
  make_view_win( Title ):-    
    framewindow( 31, Title, 255, "ɻȼͺ" ),
    hint( " Esc - return to menu   \24\25\26\27 - view text" ), !.

  make_filler_win:- check_remov(wnFiller), fail.    
  make_filler_win:-
    makewindow( wnFiller, 158, 159, "", 5, 10, 15, 60 ), 
    hint( " Esc - Cancel  F4 - change mask  Enter - load" ), !.  
    
  make_main_win:-check_remov(wnMain), fail.
  make_main_win:-
    makewindow( wnMain, 30, 31, "", 0, 0, 24, 80, 1, 255,
		"ɻȼͺ" ),
    loaded_file( File ),
    update_title( File ), 
    remake_main_win, !.

  remake_main_win:-
    hint( " Esc - Exit" ).

  init_desktop:- 
    loaded_file(_),
    blink_set( false ),
    
    make_main_win, !.

  init_desktop:-
    disk( Path ),
    init_filler( Path, "*.dba", "" ),

    blink_set( false ),
  
    make_main_win, !.
    		    

  restore_desktop:-     
    remove_windows( wnHiInd, _ ),        
    blink_set( true ).

   remove_windows( 0, 0 ):- !.
   remove_windows( MaxNumber, Count ):-
     existwindow( MaxNumber ),
     gotowindow( MaxNumber ),
     removewindow,
     NextNumb = MaxNumber - 1,
     remove_windows( NextNumb, NextCont ),
     Count = NextCont + 1.

   remove_windows( MaxNumber, Count ):-
     NextNumb = MaxNumber - 1,
     remove_windows( NextNumb, Count ).


  update_title( FileName ):-
    gotowindow( wnMain ),
    retractall( loaded_file(_) ),
    assert( loaded_file(FileName) ),
    FileName <> "",
    format( PrName, " %s ", FileName ),
    framewindow( 31, PrName, 255, "ɻȼͺ" ), !.

  update_title( _ ):-
    framewindow( 31, " No base loaded ", 255, "ڿ��ĳ" ), !.

  show_win_buf:-
    gotowindow( wnMain ),
    clearwindow,
    main_window( Str ),
    write( Str ).





