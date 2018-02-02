/* project "map"

global predicates
  calc_bytes( integer, string ) - (i,o) language asm */

constants

  mCBNotLast = 'M'
  mCBLast    = 'Z'

domains
    
  segment, offset = integer
  name            = string
  size            = integer
  name_record     = prog_info(name, segment, size)
  name_list       = name_record*
  
predicates
  
  get_first_mcb( segment )
  
  next_name( segment, name )
  get_name_mcb( segment, offset, name )
  
  scan_mcb
  scan_mcb( segment, name_list )
  
  print_list( name_list )
    
  is_ascii_name( name )
  
  insert_name( name_list, name_record, name_list )

  
clauses
  
  get_first_mcb( Segm ):- 
    AX = $5200, bios( $21, reg(AX, 0, 0, 0, 0, 0, 0, 0), 
    reg(_, BX, _, _, _, _, _, ES) ), 
    Offs = BX - 2, memword( ES, Offs, Tmps ),
    Segm = Tmps.
              
  scan_mcb:- 
    get_first_mcb( CurMCB ), 
    scan_mcb( CurMCB, ListOfNames ),  

    writedevice( stdout ),
        
    writef( "    (c)AlexCorp.  List of loaded programs.  V1.0 1994.\n" ),
    writef( "    Created  by Turbo Prolog V2.0.\n\n" ),
    writef( "    ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿\n" ),
    writef( "    ³  Root para  ³   Size of    ³  Short name  ³\n" ),
    writef( "    ³             ³  root block  ³              ³\n" ),
    writef( "    ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´\n" ),       
    
    print_list( ListOfNames ),
    
    writef( "    ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ\n" ).
        
      
  scan_mcb( CurMCB, [] ):- 
    membyte( CurMCB, 0, TypeByte ),
    TypeByte <> mCBLast, 
    TypeByte <> mCBNotLast,     
    !.
    
  scan_mcb( CurMCB, ListOfNames ):-   
    next_name( CurMCB, Name ),     
    memword( CurMCB, 3, SizeBlc ), 
    NextMCB = CurMCB + SizeBlc + 1,     
    
    scan_mcb( NextMCB, PartList ),
    
    ProgMCB = CurMCB + 1,
    ProgInfo = prog_info( Name, ProgMCB, SizeBlc ),    
    insert_name( ListOfNames, ProgInfo, PartList ).
    
   
  insert_name( ListOfName, prog_info( Name, Segment, Size ), PartList ):-
     Name = "", ListOfName = PartList;  
     is_ascii_name( Name ),
     ListOfName = [prog_info( Name, Segment, Size ) | PartList];
     ListOfName = PartList.
     
              
  is_ascii_name( "" ).        
  
  is_ascii_name( Name ):-
    frontchar( Name, FirstChar, PartName ),    
    FirstChar <> 0,
    
    is_ascii_name( PartName ),
    
    FirstChar >= $20, 
    FirstChar <= $7E.
    
          
  print_list( [] ).
  print_list( [prog_info(Name, Segment, Size) | Tail] ):- 
    /*calc_bytes( Size, SizeInBytes ),  */
    writef( "    ³ %9xh  ³  %10u  ³  %-11s ³\n", Segment, Size, Name ),       
    print_list( Tail ).  
              
  next_name( Segm, Name ):- 
    memword( Segm, 1, Owner ), Owner = 0, Name = "";    
    memword( Segm, 1, Owner ), Owner <> Segm + 1, Name = "";
    Offs = 8, get_name_mcb( Segm, Offs, Name ).
    
  get_name_mcb( Segm, Offs, "" ):- 
    membyte( Segm, Offs, NextChar ), NextChar = 0, !;
    Offs >= 15, !.
    
  get_name_mcb( Segm, Offs, Name ):- 
    NextOffs = Offs + 1, 
    membyte( Segm, Offs, NextChar ),     
    
    get_name_mcb( Segm, NextOffs, PartName ),    
    
    frontchar( Name, NextChar, PartName).
    
    
goal  
  scan_mcb.
  