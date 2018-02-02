domains
  what, state, part = symbol.
  hard = symbol.
  info = one( what );
         two( what, state ).

predicates

  computer_part( part ).
  computer( part, info ).  

  print_cmos.
  print_cmos_sys.
  print_old_hard.
  print_old_hard_sys.
  print_new_hard.
  print_new_hard_sys.
  print_floppy.
  print_floppy_sys.
  print_disk_a.
  print_disk_a_sys.
  print_disk_b.
  print_disk_b_sys.
  print_all.
  
  state_of_part( part ).
  
  can_hard_boot( part ).
  
  windows_fast( part ).
  
  is_hard( part ).
  
/*goal
  print_all.*/

clauses
   computer_part( cmos ).
   computer_part( old_hard ).
   computer_part( new_hard ).
   computer_part( disk_a ).
   computer_part( disk_b ).
   computer_part( floppy ).
   computer_part( third_hard ).

   computer( cmos, two("конфигурация винчестера с загрузочным сектором", "неправильно установлена") ).
   computer( cmos, two("загрузка", "с винчестера") ).  

   computer( old_hard, two("boot сектор", "испорчен") ).
   computer( old_hard, two("boot сектор", "имеет") ).
   computer( old_hard, two("режим работы", "slave") ).
   computer( old_hard, two("32-х битовый доступ", "не поддерживает") ).
   
   computer( third_hard, two("boot сектор", "не испорчен") ).
   computer( third_hard, two("boot сектор", "имеет") ).
   computer( third_hard, two("режим работы", "master") ).
   computer( third_hard, two("32-х битовый доступ", "поддерживает") ).
            
   computer( new_hard, two("32-х битовый доступ", "поддерживает") ).
   computer( new_hard, two("boot сектор", "не имеет") ).
   computer( new_hard, two("режим работы", "master") ).

   computer( disk_a, one("не имеет floppy") ).
   computer( disk_a, one("исправен") ).

   computer( disk_b, one("имеет floppy") ).
   computer( disk_b, one("исправен") ).
   
   computer( floppy, one("загрузочная") ).
   computer( floppy, one("корректеная") ).


   /* ------------------- Правила для печати ------------------- */
   
   print_cmos_sys:- write( "\nCMOS:\n" ).
   print_cmos:- print_cmos_sys, !, computer( cmos, two(What, State) ),
     write( What, " - ", State ), nl, fail.

   print_old_hard_sys:- write( "\nСтарый винчестер:\n" ).
   print_old_hard:- print_old_hard_sys, !, computer( old_hard, two(What, State )),
     write( What, " - ", State ), nl, fail.

   print_new_hard_sys:- write( "\nНовый винчестер:\n" ).
   print_new_hard:- print_new_hard_sys, !, computer( new_hard, two(What, State )),
     write( What, " - ", State ), nl, fail.

   print_disk_a_sys:- write( "\nДисковод A:\n" ).
   print_disk_a:- print_disk_a_sys, !, computer( disk_a, one(What) ),
     write( What ), nl, fail.

   print_disk_b_sys:- write( "\nДисковод B:\n" ).
   print_disk_b:- print_disk_b_sys, !, computer( disk_b, one(What) ),
     write( What ), nl, fail.

   print_floppy_sys:- write( "\nДискетта:\n" ).
   print_floppy:- print_floppy_sys, !, computer( floppy, one(What) ),
     write( What ), nl, fail.

   print_all:- print_cmos; not(readchar(_));
	       print_old_hard; not(readchar(_));
	       print_new_hard; not(readchar(_));
	       print_floppy; not(readchar(_));
	       print_disk_a; not(readchar(_));
	       print_disk_b; not(readchar(_)).
	         
   /* ------------------- Правила для запросов ------------------- */
      
   state_of_part( Part ):- computer_part( Part ), 
          
     computer( Part, two(What, State) ),
     write( "Элемент ", Part, ": ", What, " - ", State ), nl, fail; !,
     
     computer( Part, one(What) ),
     write( "Элемент ", Part, ": ", What ), nl, fail.
	
   is_hard( H ):- H = old_hard; H = new_hard; H = third_hard.	   
   can_hard_boot( Hard ):- computer_part( Hard ), 
     is_hard( Hard ),
     computer( Hard, two( _, "master" ) ), 
     computer( Hard, two("boot сектор", "имеет") ), 
     computer( Hard, two("boot сектор", "не испорчен") ).
     
   windows_fast( Hard ):- computer_part( Hard ),
     computer( Hard, two( "32-х битовый доступ", "поддерживает" ) ).
   
