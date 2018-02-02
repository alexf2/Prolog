domains
  name, party = symbol

predicates
  prezident( name, party ).

clauses
  prezident( eisenhower, republican ).
  prezident( kennedy, democrat ).
  prezident( johnson, democrat ).
  prezident( nixon, republican ).
  prezident( ford, republican ).
  prezident( carter, democrat ).
  
goal
  prezident( X, democrat ), write( X ), nl, fail.
     