
GLOBAL DOMAINS
  FIRMA, SPECIF = string

  ACESS_TIME_NS, ACESS_TIME_MS = integer
  TRACK_TO_TRACK = real
  SIZE = integer
  SIZE_FLOP = real

  MEMORY_S = string

  SLOT_MB = string

  PARITY_ =  string

  CHACE  = string

  FLOPPY_FORM = string

  HARD_CONTR  = string
  PORTS       = string
  PortsList   = PORTS*
  MODE        = integer
  ModesList   = MODE*
  PIXEL_RES   =  real
  ELT_TRACE   =  string
  COLOR       =  string
  MAX_NON_INTER_MODE = integer

  MemorySize   = integer
  BoxTyp       = string
  BusTyp       = string


  MainBoardTyp = main_board( FIRMA, SPECIF )
  CPUTyp       = cpu( FIRMA, SPECIF )
  MemoryTyp    = memory( FIRMA, ACESS_TIME_NS, SLOT_MB, PARITY_ )
  HardTyp      = hard( FIRMA, SIZE, ACESS_TIME_MS, TRACK_TO_TRACK, CHACE )
  FloppyTyp    = floppy( FIRMA, FLOPPY_FORM, SIZE_FLOP )
  FloppyList   = FloppyTyp*
  MultiCardTyp = multi( FIRMA, HARD_CONTR, PortsList, BusTyp )
  VideoCardTyp = video( FIRMA, MEMORY_S, ModesList, BusTyp )
  MonitorTyp   = monitor( SIZE, PIXEL_RES, ELT_TRACE, COLOR, MAX_NON_INTER_MODE )  


  dbDom = main_board(FIRMA, SPECIF); cpu( FIRMA, SPECIF );
	  memory( FIRMA, ACESS_TIME_NS, SLOT_MB, PARITY_ );
	  hard( FIRMA, SIZE, ACESS_TIME_MS, TRACK_TO_TRACK, CHACE );
	  floppy( FIRMA, FLOPPY_FORM, SIZE_FLOP );
	  multi( FIRMA, HARD_CONTR, PortsList, BusTyp );
	  video( FIRMA, MEMORY_S, ModesList, BusTyp );
	  monitor( SIZE, PIXEL_RES, ELT_TRACE, COLOR, MAX_NON_INTER_MODE )


GLOBAL DATABASE - computerData

  hard_ware( dbDom )

GLOBAL DOMAINS
  list_str = string*

GLOBAL PREDICATES
  load_base( string ) - (i)
  nondeterm check_loaded
  error_handler( integer, string ) - (i, i)
  nondeterm list_base
  nondeterm common_line
  get_view( string ) - (i)
  common_list( list_str, string ) - (i, o)

  find_topic( dbDom ) - (o) (i)
 


