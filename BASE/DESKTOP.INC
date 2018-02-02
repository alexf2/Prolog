CONSTANTS
  wnMain       = 1
  wnMainHint   = 2
  wnFiller     = 3
  wnFillerHint = 4
  wnViewHint   = 5
  wnHiInd      = 5

GLOBAL PREDICATES
  nondeterm init_desktop
  nondeterm restore_desktop
  update_title( string ) - (i) 
  nondeterm make_view_win( string ) - (i)
  nondeterm make_filler_win
  nondeterm make_main_win
  remake_main_win
  check_remov( integer ) - (i)
  hint( string ) - (i)
  nondeterm show_win_buf
