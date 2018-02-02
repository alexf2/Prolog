PREDICATES
  summa_int().
    /*summa_real( real, real ).*/
  
CLAUSES 
  summa_int( ):- write( "input numerics: " ), readint(A), readint(B),
    S = A + B, write(  A, " + ", B, " = ", S, "\n" ), !.
    

  