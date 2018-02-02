CONSTANTS
  cmExit    = 0
  cmLoad    = 1
  cmDOS     = 2
  cmExit2   = 3
  cmResize  = 4    
  cmView    = 6
  cmViewInt = 7
  cmViewCur = 8
  cmQuery   = 10
  cmGenHelp = 12

GLOBAL DOMAINS

  Choice = cmChoice( integer )

GLOBAL DATABASE - fillerData
  path( string )
  mask( string )
  loaded_file( string )
  main_window( string )

GLOBAL PREDICATES
  choice( Choice, Boolean ) - (i, o)
  init_filler( string, string, string ) - (i, i, i)
  nondeterm view_main_win
  

