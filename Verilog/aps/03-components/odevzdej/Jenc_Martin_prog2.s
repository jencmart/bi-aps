#define res $2
#define x $4
#define t0 $8
#define t1 $9

lw    x,   8($0)
addi  t0,  $0,  23   
addi  t1,  $0,  127    
srlv  res, x,   t0   // shift by 23 bites
sub   res, res, t1   // exponent do primeho kodu (-127)
sw    res, 4($0)     // Save result to memory
 
