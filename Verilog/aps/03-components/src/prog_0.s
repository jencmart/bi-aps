/// values for function returns and expression eval
#define v0 $2
#define v1 $3

/// function arguments
#define a0 $4
#define a1 $5
#define a2 $6
#define a3 $7

/// temporaries
#define t0 $8
#define t1 $9
#define t2 $10
#define t3 $11
#define t4 $12
#define t5 $13
#define t6 $14
#define t7 $15

#define ra $31
#define end $30

start:

  addi a0, $0, 4 //  A
  addi a1, $0, 3 //  B
  
  addi end, $0, 100
  jal mult

  sw v0, 4, $0; // save to mem
  jal finish // jum to end

mult:
  addi t0, $0, 8     // t0  = 8
  addi t1, $0, 0     // i   = 0
  addi v0, $0, 0     // res = 0
  addi t3, $0, 1    // var to use

  add t4, $0, ra   // save return address

  while:
    beq  t1, t0, done  // If t1==t0, end the cycle
    and  t2, a1, t3    
    beq  t2, $0, else   // if a1 first bit == 1
    add  v0, v0, a0 	// add a0 to result
    else:
	  
    sllv  a0, a0, t3 // shify a0 to left (A)
    srlv  a1, a1, t3 // shify a1 to right (B)
	  
    addi  t1, t1, 1  // i++  
					   			
    jal while

done:
add ra $0, t4    
jr ra

finish:

