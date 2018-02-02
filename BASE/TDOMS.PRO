
/****************************************************************/
/* In order to use the tools, the following domain declarations */
/* should be included in the start of your program		*/
/****************************************************************/
CONSTANTS
  false = 0
  true = 1

GLOBAL DOMAINS
  ROW, COL, LEN, ATTR   = INTEGER
  STRINGLIST = STRING*
  INTEGERLIST = INTEGER*
  REALLIST = REAL*
  LIST = SYMBOL*
  CHARLIST = CHAR*
  KEY  = cr; esc; break; tab; btab; del; bdel; ctrlbdel; ins;
         end ; home ; fkey(INTEGER) ; up ; down ; left ; right ;
  	 ctrlleft; ctrlright; ctrlend; ctrlhome; pgup; pgdn; 
  	 ctrlpgup; ctrlpgdn; char(CHAR) ; otherspec
  	 
 
  Boolean = integer
