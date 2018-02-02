
code = 3000

/*project "base"*/

include "tdoms.pro"
include "tpreds.pro"


include "dbase.inc"
include "print.inc"
include "desktop.inc"
include "handle.inc"
include "menu2.inc"
include "message.inc"
include "query.inc"


include "print.pro"
include "message.pro"
include "dbase.pro"
include "menu2.pro"
include "desktop.pro"
include "handle.pro"
include "query.pro"


PREDICATES
  main

CLAUSES

  main:-      
    writef( "(c)AlexCorp.  Database on computer components.  V1.0a 1994\n" ),       
    init_desktop,    
    repeat,           
      menu( 8, 49, 240, 240,
      
	    [ "Load database...",
              "DOS Shell",	   
              "Exit", 
              "Resize main window",
              "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ",
	      "View the database",
	      "View internal base",
	      "View current consist",
	      "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ",	      
	      "Query the database...",
	      "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ",
	      "How to use it ?"	      
	    ],
	    
	    " Main Menu ",
	    1,
	    Select ),            
      choice( cmChoice(Select), FlEx ),
      FlEx = true,
      restore_desktop,
      writef( "Return to DOS\n" ), !.


GOAL 
  trace(off),
  main.


