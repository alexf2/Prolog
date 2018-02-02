DOMAINS
  file = work_file

PREDICATES
  find_topic2( dbDom )
  nondeterm list_base2

CLAUSES
  error_handler( Error, FileName ):-
    Error>1100, Error<1110, !,
    consulterror( LineErr, LinePos, FilePos ),
    format( Str, " Bad data in file [%s](line #%g - %d):\n %s", FileName, FilePos,
	    LinePos, LineErr ),
    message( Str, flError ), update_title( "" ), !.

CLAUSES

  load_base( _ ):- hard_ware( _ ), retractall( hard_ware(_) ), fail.
  load_base( FileName ):-
    trap( consult( FileName, computerData ), Err, error_handler(Err, FileName) ),
    update_title( FileName ), !, trace(off).
  load_base( _ ):- !,
    update_title( "" ),
    retractall( hard_ware(_) ),
    retractall( main_window(_) ), !.


  list_base:-  trace(off),
    retractall( main_window(_) ),
    openwrite( work_file, "~swap" ),
    writedevice( work_file ),
    list_base2,
    closefile( work_file ),
    writedevice( screen ),
    get_view( "~swap" ),
    deletefile( "~swap" ), !.

  list_base2:-
    hard_ware(DbDomen),
    write( DbDomen ), nl,
    fail.

  list_base2:- !.

  get_view( FileName ):-
    retractall( main_window(_) ),
    file_str( FileName, Str ),
    assert( main_window(Str) ), !.

  get_view( FileName ):-
    format( Str, "Can't  read file [%s]", FileName ),
    message( Str, flError ), !.

  check_loaded:- hard_ware( _ ).

  find_topic( Query ):-
    openwrite( work_file, "~find" ),
    writedevice( work_file ),
    clear_print,
    find_topic2( Query ),
    clear_print,
    closefile( work_file ),
    writedevice( screen ),
    get_view( "~find" ),
    deletefile( "~find" ), !.

  find_topic( _ ):-
    message( "Query can't prepare - error swaping", flError ),
    closefile( work_file ), !, fail.

  find_topic( _ ):-
    writedevice( screen ), !, fail.

  find_topic2( Query ):- trace(off),
    hard_ware( Query ),
    bound( Query ),
    print_base_domen( Query ),
    fail.

  find_topic2( Query ):-
    bound( Query ), !;
    Query = cpu( "","" ), !.

