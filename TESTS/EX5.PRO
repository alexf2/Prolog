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
  
  owns( "��ॣ�", detal("������ ��᮪�����") ).
  owns( "��ॣ�", detal("�������") ).  		
  owns( "���", detal("������") ).
  owns( "���", detal("������� 1G") ).
  owns( "����", detal("������") ).
  owns( "����", detal("�������") ).
  owns( "����", detal("�ࢨ�") ).
  
  owns( "��ॣ�", book("�������", "��設��� ��䨪�", 1990) ).
  owns( "��ॣ�", book("����", "��� �ணࠬ��஢���� C", 1990) ).  		
  owns( "���", book("�������", "��設��� ��䨪�", 1990) ).
  owns( "���", book("�������", "�������� � ��設��� ��䨪�", 1989) ).
  owns( "����", book("���⪨�", "��� C", 1991 ) ).
  owns( "����", book("��������", "��� C++", 1991) ).
  owns( "����", book("����", "��� �ணࠬ��஢���� C", 1990)  ).
  
  owns( "��ॣ�", soft("Photo Shop") ).
  owns( "��ॣ�", soft("Photo finish") ).  		
  owns( "���", soft("MS Word 6.0") ).
  owns( "���", soft("MS Word 2.0") ).
  owns( "����", soft("MS Windows 3.1") ).
  owns( "����", soft("MS Word 6.0") ).
  owns( "����", soft("Grabber") ).
  
  