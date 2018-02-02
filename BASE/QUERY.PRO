CONSTANTS
  qExit      = 0
  qMainBoard = 1
  qCPU       = 2
  qHd        = 3
  qExit2     = 5

  qMBoardFirma = 1
  qMBoardSpec  = 2
  qMBoardMakeQ = 4
  qMBoardExit2 = 5

  qCPUFirma = 1
  qCPUSpec  = 2
  qCPUMakeQ = 4
  qCPUExit2 = 5

  qHardFirma = 1
  qHardSize  = 2
  qHardAcess = 3
  qHardTrack = 4
  qHardChace = 5
  qHardMakeQ = 7
  qHardExit2 = 8


DOMAINS
  Query = qTopic( integer );
	  qMBoard( integer );
	  qCPU_( integer );
	  qHard( integer )


  FixedD     = main_board_firma( string );
	       main_board_specif( string );

	       cpu_firma( string );
	       cpu_specif( string );

	       hard_firma( string );
	       hard_size( integer );
	       hard_acess( integer );
	       hard_track( real );
	       hard_chace( string )


DATABASE - query_fix
  fixed_attr( FixedD )


PREDICATES
  topic_query( Query, Boolean )

  q_main_board( Query, Boolean )
  q_main_board2
  q_main_board3( string, string )

  q_cpu( Query, Boolean )
  q_cpu2
  q_cpu3( string, string )

  q_hard( Query, Boolean )
  q_hard2
  q_hard3( string, integer, integer, real, string )

  check_show( integer )


CLAUSES
  query:-
    repeat,
      retractall( fixed_attr(_) ),
      menu( 8, 49, 240, 240,

	    [ "Mather board...",
	      "CPU...",
	      "Hard...",
	      "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ",
	      "Return to main menu"
	    ],

	    " Topic for query ",
	    1,
	    Select ),
      topic_query( qTopic(Select), FlEx ),
      FlEx = true, !.

  topic_query( qTopic(qExit), FlEx ):- FlEx = true, !.
  topic_query( qTopic(qExit2), FlEx ):- topic_query( qTopic(qExit), FlEx ), !.

  topic_query( qTopic(qMainBoard), FlEx ):-
    repeat,
      menu( 8, 49, 240, 240,
	    [ "”¨à¬ ",
	      "‘¯¥æ¨ä¨ª æ¨ï",
	      "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ",
	      "Make query",
	      "Return"
	    ],

	    " Mather boards ",
	    1,
	    Select ),
      q_main_board( qMBoard(Select), FlEx2 ),
      check_show( Select ),
      FlEx2 = true, FlEx = false, !.

  topic_query( qTopic(qCPU), FlEx ):-
    repeat,
      menu( 8, 49, 240, 240,
	    [ "”¨à¬ ",
	      "‘¯¥æ¨ä¨ª æ¨ï",
	      "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ",
	      "Make query",
	      "Return"
	    ],

	    " CPU ",
	    1,
	    Select ),
      q_cpu( qCPU_(Select), FlEx2 ),
      check_show( Select ),
      FlEx2 = true, FlEx = false, !.

  topic_query( qTopic(qHd), FlEx ):-
    repeat,
      menu( 8, 49, 240, 240,
	    [ "”¨à¬ ",
	      " §¬¥à",
	      "‚à¥¬ï ¤®áâã¯ ",
	      "‚à¥¬ï ¤®áâã¯  track to track",
	      " §¬¥à ªíè ",
	      "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ",
	      "Make query",
	      "Return"
	    ],

	    " Hard ",
	    1,
	    Select ),
      q_hard( qHard(Select), FlEx2 ),
      check_show( Select ),
      FlEx2 = true, FlEx = false, !.


  q_main_board( qMBoard(qExit), FlEx2 ):- FlEx2 = true, !.
  q_main_board( qMBoard(qMBoardExit2), FlEx2 ):- FlEx2 = true, !.
  q_main_board( qMBoard(qMBoardFirma), FlEx2 ):-
    writef( "\nInput name of firm >" ),

    readln( Firma ),
    assertz( fixed_attr( main_board_firma(Firma)) ),
    FlEx2 = false, !.
  q_main_board( qMBoard(qMBoardSpec), FlEx2 ):-
    writef( "\nInput spec >" ),
    readln( Spec ),
    assertz( fixed_attr( main_board_specif(Spec)) ),
    FlEx2 = false, !.

  q_main_board( qMBoard(qMBoardMakeQ), FlEx ):-
    clear_print,
    q_main_board2, FlEx = false;
    FlEx = false, !.

  q_main_board2:-
    fixed_attr( main_board_firma(Firma) ),
    fixed_attr( main_board_specif(Spec) ),
    q_main_board3( Firma, Spec ), fail;

    fixed_attr( main_board_specif(Spec) ),
    q_main_board3( Firma, Spec ), fail;

    fixed_attr( main_board_firma(Firma) ),
    q_main_board3( Firma, Spec ), fail;

    fail.

  q_main_board3( Firma, Spec ):-
    hard_ware( main_board(Firma,Spec) ),
    print_base_domen( main_board(Firma,Spec) ),
    fail.


  q_cpu( qCPU_(qExit), FlEx2 ):- FlEx2 = true, !.
  q_cpu( qCPU_(qCPUExit2), FlEx2 ):- FlEx2 = true, !.
  q_cpu( qCPU_(qCPUFirma), FlEx2 ):-
    writef( "\nInput name of firm >" ),
    readln( Firma ),
    assertz( fixed_attr( cpu_firma(Firma)) ),
    FlEx2 = false, !.
  q_cpu( qCPU_(qCPUSpec), FlEx2 ):-
    writef( "\nInput spec >" ),
    readln( Spec ),
    assertz( fixed_attr( cpu_specif(Spec)) ),
    FlEx2 = false, !.

  q_cpu( qCPU_(qMBoardMakeQ), FlEx ):-
    clear_print,
    q_cpu2, FlEx = false;
    FlEx = false, !.

  q_cpu2:-
    fixed_attr( cpu_firma(Firma) ),
    fixed_attr( cpu_specif(Spec) ),
    q_cpu3( Firma, Spec ), fail;

    fixed_attr( cpu_specif(Spec) ),
    q_cpu3( Firma, Spec ), fail;

    fixed_attr( cpu_firma(Firma) ),
    q_cpu3( Firma, Spec ), fail;

    fail.

  q_cpu3( Firma, Spec ):-
    hard_ware( cpu(Firma,Spec) ),
    print_base_domen( cpu(Firma,Spec) ),
    fail.



  q_hard( qHard(qExit), FlEx2 ):- FlEx2 = true, !.
  q_hard( qHard(qHardExit2), FlEx2 ):- FlEx2 = true, !.
  q_hard( qHard(qHardFirma), FlEx2 ):-
    writef( "\nInput name of firm >" ),
    readln( Firma ),
    assertz( fixed_attr( hard_firma(Firma)) ),
    FlEx2 = false, !.

  q_hard( qHard(qHardSize), FlEx2 ):-
    writef( "\nInput size >" ),
    readint( Size ),
    assertz( fixed_attr( hard_size(Size)) ),
    FlEx2 = false, !.

   q_hard( qHard(qHardAcess), FlEx2 ):-
    writef( "\nInput acess time >" ),
    readint( Acess ),
    assertz( fixed_attr( hard_acess(Acess)) ),
    FlEx2 = false, !.

   q_hard( qHard(qHardTrack), FlEx2 ):-
    writef( "\nInput track to track time >" ),
    readreal( Track ),
    assertz( fixed_attr( hard_acess(Track)) ),
    FlEx2 = false, !.

   q_hard( qHard(qHardChace), FlEx2 ):-
    writef( "\nInput chace >" ),
    readln( Chace ),
    assertz( fixed_attr( hard_chace(Chace)) ),
    FlEx2 = false, !.

  q_hard( qHard(qHardMakeQ), FlEx ):-
    clear_print,
    q_hard2, FlEx = false;
    FlEx = false, !.

  q_hard2:-
    fixed_attr( hard_firma(Firma) ),
    fixed_attr( hard_size(Size) ),
    fixed_attr( hard_acess(Acess) ),
    fixed_attr( hard_track(Track) ),
    fixed_attr( hard_chace(Chace) ),
    q_hard3( Firma, Size, Acess, Track, Chace ), fail;

    fixed_attr( hard_firma(Firma) ),
    q_hard3( Firma, Size, Acess, Track, Chace ), fail;

    fixed_attr( hard_size(Size) ),
    q_hard3( Firma, Size, Acess, Track, Chace ), fail;

    fixed_attr( hard_acess(Acess) ),
    q_hard3( Firma, Size, Acess, Track, Chace ), fail;

    fixed_attr( hard_track(Track) ),
    q_hard3( Firma, Size, Acess, Track, Chace ), fail;

    fixed_attr( hard_chace(Chace) ),
    q_hard3( Firma, Size, Acess, Track, Chace ), fail;

    fail.

  q_hard3( Firma, Size, Acess, Track, Chace ):-
    hard_ware( hard(Firma, Size, Acess, Track, Chace) ),
    print_base_domen( hard(Firma, Size, Acess, Track, Chace) ),
    fail.


  check_show( Q ):-
    Q = qMBoardMakeQ, fail;
    Q = qCPUMakeQ, fail;
    !.

  check_show( _ ):-
   show_win_buf, !.
