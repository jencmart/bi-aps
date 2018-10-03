#define v0 $2

#define a0 $4
#define a1 $5

#define t0 $8
#define t1 $9
#define t2 $10
#define t3 $11
#define t4 $12

#define ra $31

start:
  lw   a1, 8($0)   // Cnt - 3. radek ramky
  addi a0, $0, 12  //first addr ptr - 4. radek ramky

  
  jal findMax  // Call subroutine
  
  sw v0, 4($0) // Save result to data mem

  jal exit     // jump to end...

findMax:
  add  t3, $0, ra  // save ret. addr
                   // ARR_SIZE (A1)
  lw   t4, 0(a0)   // CURR_EL  (T4)
  addi t2, $0, 0   // CURR_POS (T2)
  addi v0, t4, 0   // CURR_MAX (V0)
                   // CURR_PTR (A0)
  while:
    slt  t0, t2, a1
    beq  t0, $0, done  // while curr pos < num of elems
   
    slt  t0, v0, t4    // if maxVal < currElem 
    beq  t0, $0, else  // if maxVal < currElem is false, --> else
    addi v0, t4, 0     // maxVal < currElem == true -> save curr elem to maxElem
    else:
     
    addi t2, t2, 1  // CurrPos++
    addi a0, a0, 4  // ptr++	
    lw   t4, 0(a0)  // *ptr					   			
    jal  while

  done:
    add ra, $0, t3    
    jr ra

exit:
