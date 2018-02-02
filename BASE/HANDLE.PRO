
/*include "handle.inc"
include "message.inc"
include "message.pro"*/


CLAUSES
  init_filler( _, _, _ ):- 
    retractall( path(_) ), retractall( mask(_) ), retractall( loaded_file(_) ),
    retractall( main_window(_) ),
    fail.
  init_filler( Path, Mask, File ):- 
    assert( path(Path) ), assert( mask(Mask) ), assert( loaded_file(File) ), !.
  

  choice( cmChoice(cmExit), FlEx ):- FlEx = true, !.
  choice( cmChoice(cmExit2), FlEx ):- choice( cmChoice(cmExit), FlEx ), !.


  choice( cmChoice(cmDOS), FlEx ):-
    system( "" ),
    remake_main_win,
    FlEx = false, !.
  choice( cmChoice(cmDOS), FlEx ):-
    message( "Cann't  execute OS shell", flError ), FlEx = false, !.

  choice( cmChoice(cmLoad), FlEx ):-
    path( Path ), mask( Mask ),

    make_filler_win,
    dir( Path, Mask, Fname, 1, 1, 1 ),
    removewindow,
    remake_main_win,

    init_filler( Path, Mask, Fname ),
    load_base( Fname ),
    clearwindow,    trace(off),
    list_base,
    show_win_buf,
    FlEx = false, !;

    removewindow,
    remake_main_win, FlEx = false, !.

  choice( cmChoice(cmView), FlEx ):-
    check_loaded,
    find_topic( _ ),
    show_win_buf,
    FlEx = false,
    !.

  choice( cmChoice(cmView), FlEx ):-
    message( "Base not loaded", flMessage ), FlEx = false, !.

  choice( cmChoice(cmResize), FlEx ):- trace(off),
    resizewindow,
    remake_main_win,
    FlEx = false, !.

  choice( cmChoice(cmViewInt), FlEx ):-
    check_loaded,
    list_base,
    view_main_win,
    FlEx = false, !.

  choice( cmChoice(cmViewInt), FlEx ):-
    message( "Base not loaded", flMessage ), FlEx = false, !.

  choice( cmChoice(cmQuery), FlEx ):-
    check_loaded,
    query,
    FlEx = false, !.

  choice( cmChoice(cmQuery), FlEx ):-
    message( "Base not loaded", flMessage ), FlEx = false, !.

  choice( cmChoice(cmViewCur), FlEx ):-
     main_window( _ ),
     view_main_win, FlEx = false, !.

  choice( cmChoice(cmViewCur), FlEx ):-
     message(  "Main nothing text consist", flMessage ), FlEx = false, !.

  choice( cmChoice(cmGenHelp), FlEx ):-
     get_view( "base.hlp" ),
     main_window( _ ),
     view_main_win, FlEx = false, !.

  choice( cmChoice(cmGenHelp), FlEx ):-
     message(  "File  base.hlp not found", flError ), FlEx = false, !.


  view_main_win:-
    main_window( GetStr ),
    hint( "Esc - return to menu  \24\25\26\27, PgUp, PgDown, Home, End scroll text" ),
    display( GetStr ),
    remake_main_win.

