domains
  thing = detal( what );
          book( autor, title, year );
          soft( what ).
          
  what, autor, title = symbol.
  year = integer.
  person = symbol.
  
predicates
  owns( person, thing ).
  show_detal.
  show_books.

goal
  show_books.  
  
clauses
  show_detal:- owns( Owner, detal(What) ),
               write( Owner, " ", What ), nl, fail.   
  show_books:- owns( Owner, book(_, Ttl, _) ),
               write( Owner, " ", Ttl ), nl, fail. 
  
  owns( "Серега", detal("монитор высокочасотный") ).
  owns( "Серега", detal("винчестер") ).  		
  owns( "Саша", detal("монитор") ).
  owns( "Саша", detal("винчестер 1G") ).
  owns( "Коля", detal("монитор") ).
  owns( "Коля", detal("винчестер") ).
  owns( "Коля", detal("арвин") ).
  
  owns( "Серега", book("Роджерс", "Машинная графика", 1990) ).
  owns( "Серега", book("Ритчи", "Язык программирования C", 1990) ).  		
  owns( "Саша", book("Роджерс", "Машинная графика", 1990) ).
  owns( "Саша", book("Эйнджел", "Введение в машинную графику", 1989) ).
  owns( "Коля", book("Касаткин", "Язык C", 1991 ) ).
  owns( "Коля", book("Страуструп", "Язык C++", 1991) ).
  owns( "Коля", book("Ритчи", "Язык программирования C", 1990)  ).
  
  owns( "Серега", soft("Photo Shop") ).
  owns( "Серега", soft("Photo finish") ).  		
  owns( "Саша", soft("MS Word 6.0") ).
  owns( "Саша", soft("MS Word 2.0") ).
  owns( "Коля", soft("MS Windows 3.1") ).
  owns( "Коля", soft("MS Word 6.0") ).
  owns( "Коля", soft("Grabber") ).
  
  