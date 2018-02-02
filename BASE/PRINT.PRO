DOMAINS
  ac_domain =
    ac_main_board(Boolean);
    ac_cpu(Boolean);
    ac_memory(Boolean);
    ac_hard(Boolean);
    ac_floppy(Boolean);
    ac_multi(Boolean);
    ac_video(Boolean);
    ac_monitor(Boolean)

DATABASE - print_control
  acessed( ac_domain )

PREDICATES
  line_str( integer, char )
  write_mid( string, integer )

  print_base_domen_main_board
  print_base_domen_cpu
  print_base_domen_memory
  print_base_domen_hard
  print_base_domen_floppy
  print_base_domen_multi
  print_base_domen_video
  print_base_domen_monitor

CLAUSES

  clear_print:-
    retractall( acessed(_) ).

  line_str( Count, _ ):- Count < 1, !.
  line_str( Count, Ch ):-
    write( Ch ),
    NextCount = Count - 1,
    line_str( NextCount, Ch ).

  write_mid( Str, Field ):-
    str_len( Str, Len ),
    Field > Len,
    Left = (Field - Len) / 2,
    Right = Field - Len - Left,
    line_str( Left, ' ' ),
    write( Str ),
    line_str( Right, ' ' ), !;

    write( Str ), !.


  print_base_domen( main_board(_, _) ):-
    not(acessed( ac_main_board(_) )),
    print_base_domen_main_board, fail.
  print_base_domen( main_board(Firma, Specif) ):-
    writef( " %-20s   %-20s\n", Firma, Specif ), !.

  print_base_domen( cpu(_, _) ):-
    not(acessed( ac_cpu(_) )),
    print_base_domen_cpu, fail.
  print_base_domen( cpu(Firma, Specif) ):-
    writef( "%-20s   %-20s\n", Firma, Specif ), !.


  print_base_domen( memory(_, _, _, _) ):-
    not(acessed( ac_memory(_) )),
    print_base_domen_memory, fail.
  print_base_domen( memory(Firma, Acess, Slot, Parity) ):-
    writef( "%-20s   %-7d   %-5s   %-10s\n", Firma, Acess, Slot, Parity ), !.

  print_base_domen( hard(_, _, _, _, _) ):-
    not(acessed( ac_hard(_) )),
    print_base_domen_hard, fail.
  print_base_domen( hard(Firma, Size, Acess, Track, Chace) ):-
    writef( "%-20s   %-7d   %-6d   %-7g   %-7s\n", Firma, Size, Acess, Track, Chace ), !.

  print_base_domen( floppy(_, _, _) ):-
    not(acessed( ac_floppy(_) )),
    print_base_domen_floppy, fail.
  print_base_domen( floppy(Firma, Form, Size) ):-
    writef( "%-20s   %-7s   %-7g\n", Firma, Form, Size ), !.

  print_base_domen( multi(_, _, _, _) ):-
    not(acessed( ac_multi(_) )),
    print_base_domen_multi, fail.
  print_base_domen( multi(Firma, HardContr, Ports, Bus) ):-
    writef( "%-15s   %-7s", Firma, HardContr ),
    print_list_str( Ports ),
    writef( "   %-7s\n", Bus ), !.

  print_base_domen( video(_, _, _, _) ):-
    not(acessed( ac_video(_) )),
    print_base_domen_video, fail.
  print_base_domen( video(Firma, Memory, Modes, Bus) ):-
    writef( "%-20s   %-7s", Firma, Memory ),
    print_list_int( Modes ),
    writef( "   %-7s\n", Bus ), !.

  print_base_domen( monitor(_, _, _, _, _) ):-
    not(acessed( ac_monitor(_) )),
    print_base_domen_monitor, fail.
  print_base_domen( monitor(Size, PixelRes, Elt, Color, MaxNonIntMode) ):-
    writef( "%-7d   %-7g   %-7s   %-7s   %-5d\n", Size, PixelRes, Elt, Color, MaxNonIntMode ), !.


  print_list_str( [] ):- !.
  print_list_str( [H|T] ):-
    writef( "%s ", H ),
    print_list_str( T ).

  print_list_int( [] ):- !.
  print_list_int( [H|T] ):-
    writef( "%x ", H ),
    print_list_int( T ).


  print_base_domen_main_board:-
    nl, nl,
    write_mid( "Материнские платы", 42 ), nl,
    line_str( 42, '─' ), nl,
    write_mid( "Фирма", 20 ), write( "   " ),
    write_mid( "Спецификация", 20 ), nl,
    line_str( 42, '─' ), nl,
    assert( acessed( ac_main_board(true) ) ).

  print_base_domen_cpu:-
    nl, nl,
    write_mid( "Процессоры", 42 ), nl,
    line_str( 42, '─' ), nl,
    write_mid( "Фирма", 20 ), write( "   " ),
    write_mid( "Спецификация", 20 ), nl,
    line_str( 42, '─' ), nl,
    assert( acessed( ac_cpu(true) ) ).

  print_base_domen_memory:-
    nl, nl,
    write_mid( "Память", 54 ), nl,
    line_str( 54, '─' ), nl,
    write_mid( "Фирма", 20 ), write( "   " ),
    write_mid( "Доступ", 7 ),write( "   " ),
    write_mid( "Слот", 5 ), write( "   " ),
    write_mid( "Паритет", 10 ), nl,
    line_str( 54, '─' ), nl,
    assert( acessed( ac_memory(true) ) ).

  print_base_domen_hard:-
    nl, nl,
    write_mid( "Жесткие диски", 67 ), nl,
    line_str( 67, '─' ), nl,
    write_mid( "Фирма", 20 ), write( "   " ),
    write_mid( "Емкость", 7 ),write( "   " ),
    write_mid( "Доступ", 6 ), write( "   " ),
    write_mid( "Между дорожками", 15 ), write( "   " ),
    write_mid( "Кеш", 7 ), nl,
    line_str( 67, '─' ), nl,
    assert( acessed( ac_hard(true) ) ).

  print_base_domen_floppy:-
    nl, nl,
    write_mid( "Флопы", 42 ), nl,
    line_str( 42, '─' ), nl,
    write_mid( "Фирма", 20 ), write( "   " ),
    write_mid( "Тип", 7 ),write( "   " ),
    write_mid( "Емкость", 7 ), nl,
    line_str( 42, '─' ), nl,
    assert( acessed( ac_floppy(true) ) ).

  print_base_domen_multi:-
    nl, nl,
    write_mid( "Мульти карты", 67 ), nl,
    line_str( 67, '─' ), nl,
    write_mid( "Фирма", 20 ), write( "   " ),
    write_mid( "Протокол", 7 ),write( "   " ),
    write_mid( "Порты", 20 ), write( "   " ),
    write_mid( "Шина", 7 ), nl,
    line_str( 67, '─' ), nl,
    assert( acessed( ac_multi(true) ) ).

  print_base_domen_video:-
    nl, nl,
    write_mid( "Видео карты", 67 ), nl,
    line_str( 67, '─' ), nl,
    write_mid( "Фирма", 20 ), write( "   " ),
    write_mid( "Память", 7 ),write( "   " ),
    write_mid( "Режимы", 20 ), write( "   " ),
    write_mid( "Шина", 7 ), nl,
    line_str( 67, '─' ), nl,
    assert( acessed( ac_video(true) ) ).

  print_base_domen_monitor:-
    nl, nl,
    write_mid( "Мониторы", 72 ), nl,
    line_str( 72, '─' ), nl,
    write_mid( "Размер", 7 ), write( "   " ),
    write_mid( "Точка", 7 ),write( "   " ),
    write_mid( "Развертка", 7 ), write( "   " ),
    write_mid( "Тип", 7 ), write( "   " ),
    write_mid( "Макс. режим без чередования", 7 ), nl,
    line_str( 72, '─' ), nl,
    assert( acessed( ac_monitor(true) ) ).

