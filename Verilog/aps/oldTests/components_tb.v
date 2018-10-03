// TEST MUX2
module testMux2();
	reg[31:0] inA, inB;
        reg s;
	wire[31:0]out;

	mux2 myMux2(inA, inB, s, out);
	initial begin
	 $dumpfile("test");
    	 $dumpvars; 
   	 inA=200;
	 inB=500;
	 s=0;
   	 #10; 
   	 s=1;
	 #20; 
   	 s=0;
	 #50
	 inA = 999;
	 #100
	 s=1;
 	 #160 $finish;
	end
endmodule

// TEST MUX4
module testMux4();
	reg[31:0] inA, inB, inC, inD;
        reg[1:0] s;
	wire[31:0]out;

	mux4 myMux4(inA, inB, inC, inD, s, out);
	initial begin
	 $dumpfile("test");
    	 $dumpvars; 
   	 inA=100;
	 inB=200;
	 inC=300;
	 inD=400;
	 s=0;
   	 #10; 
   	 s=1;
	 #20; 
   	 s=2;
	 #50
	 inA = 999;
	 #100
	 s=3;
 	 #160 $finish;
	end
endmodule

// TEST COMPARATOR
module testComparator();
	reg [31:0] a, b;
	wire res;
	comparator myComparator(a,b,res);
	initial begin
	 $dumpfile("test");
    	 $dumpvars; 
   	 a=2;
	 b=2;
   	 #10; 
   	 a=3;
	 #20; 
   	 a=7;
	 b=7;
 	 #160 $finish;
	end
endmodule

// TEST SIGNED EXTENSION
module testExtensionUnit();
	reg [15:0] a;
	wire [31:0] extended;
	extensionUnit16_32 myExtensionUnit(a,extended);
	initial begin
	$dumpfile("test");
	$dumpvars;
	a=40000;
	#10;
	a=3;
	#10;
	a=1238;
	end

endmodule

// TEST ADD
module testAdder32();
  reg [31:0] a, b;
  reg cIn;
  wire [31:0] sum;
  wire cOut,  OverflowOut;
  adder32 myAdder(a, b, cIn, sum, cOut, OverflowOut);
  initial begin
    $dumpfile("test");
    $dumpvars;
    cIn = 0; 
    a=31'b1100;
    b=31'b1;
    #9 ; 
    a=2;
    b=6;
    cIn=1;
    #19;
    a = 4294967293;
    b = 19;
    #39; 
    a = 1999999999;
    b = 1999999999;
    #160 $finish;
  end
endmodule

// TEST SUBSTRACT // todo
module testSubstract32();
  reg [31:0] a, b;
  reg cIn;
  wire [31:0] sum;
  wire cOut,  OverflowOut;
  substract32 mySubstractor(a, b, cIn, sum, cOut, OverflowOut);
  initial begin
    $dumpfile("test");
    $dumpvars;
    cIn = 0; 
    a=10;
    b=5;
    #9 ; 
    a='sb11110000; // -16
    b= 'sb00010000; // 16
    cIn=0;
    #19;
    a = 4294967293;
    b = 19;
    #39; 
    a = 1999999999;
    b = 1999999999;
    #160 $finish;
  end

endmodule

// TEST MULTIPLY
module testMultiply4();
	reg [31:0] a;
	wire[31:0] res;
	multiply4 myMultiplicator(a,res);
	initial begin
	 $dumpfile("test");
    	 $dumpvars; 
   	 a=2;
   	 #10; 
   	 a=3;
	 #20; 
   	 a=7;
 	 #160 $finish;
	end
endmodule

// TEST SHIFT LEFT
module testShiftLeft();
	reg [31:0] a;
	reg[4:0] sh;
	wire[31:0] res;
	shiftLeft myShiftLeft(a,sh,res);
	initial begin
	 $dumpfile("test");
    	 $dumpvars; 
   	 a=2;
	 sh=1;
   	 #10; 
   	 sh=2;
	 #20; 
   	 sh=3;
	 #30
	 sh=4;
	 #40
	 sh=5;
	 #50
	 a=3;
 	 #160 $finish;
	end
endmodule

// TEST SHIFT RIGHT LOGICAL
module testShiftRightLogical();
	reg [31:0] a;
	reg[4:0] sh;
	wire[31:0] res;
	shiftRightLogical myShiftRightLogical(a,sh,res);
	initial begin
	 $dumpfile("test");
    	 $dumpvars; 
   	 a=1024;
	 sh=1;
   	 #10; 
   	 sh=2;
	 #20; 
   	 sh=3;
	 #30
	 sh=4;
	 #40
	 sh=5;
	 #50
	 a=4000000000;
 	 #160 $finish;
	end
endmodule

// TEST SHIFT RIGHT ARITHMETICAL
module testShiftRightArithmetical();
	reg [31:0] a;
	reg[4:0] sh;
	wire[31:0] res;
	shiftRightArithmetical myShiftRightArithmetical(a,sh,res);
	initial begin
	 $dumpfile("test");
    	 $dumpvars; 
   	 a=3000000000;
	 sh=1;
   	 #10; 
   	 sh=2;
	 #20; 
   	 sh=3;
	 #30
	 sh=4;
	 #40
	 sh=5;
	 #50
	 a=512;
 	 #160 $finish;
	end
endmodule

// TEST REGISTER32
module testReg32();
	reg [31:0] data_in;
	reg clk, reset;
	wire[31:0] out;

	reg32 myReg32(data_in, clk, reset, out);
	initial begin
	 $dumpfile("test");
    	 $dumpvars; 
   	 data_in = 37;
	 clk = 1;
	 reset = 0;

   	 #1
	 data_in = 60;

	 #2
	 data_in = 70;
	 clk = 0;

	 #3
	 clk = 1;

	 #4
	 data_in = 80;
	 clk = 1;

	 #5
	 data_in = 90;
	 clk = 0;

	 #6
	 data_in = 100;
	 clk = 1;
	 reset = 1;

	 #7
	 clk = 0;
	 reset = 0;

	 #8
	 clk = 1;	 
 	 #16 $finish;
	end
endmodule

// TEST REGISTER 32x32
module testReg32x32();
	reg[4:0] a1, a2, a3;
	reg we, clk;
	reg[31:0] wd;
	wire[31:0] rd1 ,rd2;

	reg32x32 myReg32x32(a1,a2,a3,we,clk,wd,rd1,rd2);
	initial begin
	 $dumpfile("test");
    	 $dumpvars; 
   	 a1 = 5;
	 a2 = 15;
	 a3 = 15;
	 we=1;
	 clk=1;
	 wd=999;

	 #1
	 clk = 0;

	 a3 = 5;
	 wd = 111;

	 #2
	 clk =1;

   	 #3
	 clk = 0; 
	 a1=15;
	 a3 = 20;
	 wd = 333;

	 #4
	 clk = 1;

	 #5
//	 clk = 0;

	 #6
//	 clk = 1;
	 a1 =5;
	a2 = 15;
	 #7
//	 clk = 0;
	 we=0;
	 wd=334;
	 a2 = 5;
	 a1 = 15;

	 #8
//	 clk = 1;
	 we=1;
	 a2 = 15;
	 a1 = 5;

	 #9
//	 clk = 0;
	 a1 = 0;
	 a2 = 5;
 	 #100 $finish;
	end
endmodule

//TEST ALU UNIT
module testAlu();
	reg[31:0] srcA, srcB;
	reg[3:0] op;
	wire[31:0] ALUResult;
	wire zero, carry, overflow;

	alu32  myALU(srcA, srcB, op, ALUResult, zero, carry, overflow);
	initial begin
	 $dumpfile("test");
    	 $dumpvars; 
	 srcA=37;
	 srcB=10;
	 op='b0010; // +
	 #1
	 op='b0110; // -
	 #2
	 op=0; // &
	 #3
	 op=1; // |
	 #4
	 op=3; // ^
	 #5
	 op='b0111; // a < b
	 #6
	 srcA = 50;
	 srcB = 60;
	 #7
	 op='b1000; // 4x unsigned soucet
	 srcA = 'b00110000111111110000001011111111;
	 srcB = 'b00000110111111110000000111111111;
	 #8
	 op='b1001; // 4x saturated soucet
	 srcA = 'b11111111;
	 srcB = 'b00000001;
	 #9
	 op='b1001; // 4x saturated soucet
	 srcA = 'b00111111;
	 srcB = 'b00000011;

 	 #100 $finish;
	end
endmodule

// TEST CONTROL UNIT
module testControlUnit();
	reg[5:0] Opcode, Funct;
	reg[4:0] Shamt;
	wire Jal, Jr, RegWrite, MemToReg, MemWrite, ALUSrc, RegDst, Branch;
	wire[3:0] ALUControl;

	controlUnit  myControlUnit(Opcode, Funct, Shamt,
	      		           Jal, Jr, RegWrite, MemToReg, MemWrite, ALUSrc, RegDst, Branch, ALUControl );
	initial begin
	 $dumpfile("test");
    	 $dumpvars;
	 
//	 Opcode = 6'b100011;

//	 #2
//	 Opcode = 6'b101011;

//	 #3
//	 Opcode = 6'b000100;

//	 #4
//	 Opcode = 6'b001000;

//	 #5
//	 Opcode = 6'b000011;

//	 #6
//	 Opcode = 6'b000111;

//	 #7
//	 Opcode = 6'b011111; //11
//	 Funct  = 6'b010000;
//	 Shamt  = 5'b00000;

//	 #8
//	 Opcode = 6'b011111; //11
//	 Funct  = 6'b010000;
//	 Shamt  = 5'b00100;

	 #1
	 Opcode = 6'b000000;	//10
	 Funct  = 6'b100000;

	 #2
	 Opcode = 6'b000000;	//10
	 Funct  = 6'b100010;
	 #3
	 Opcode = 6'b000000;	//10
	 Funct  = 6'b100100;

	 #4
	 Opcode = 6'b000000;	//10
	 Funct  = 6'b100101;
 
         #5
 	 Opcode = 6'b000000;	//10
	 Funct  = 6'b101010;

 	 #100 $finish;
	end
endmodule


// TEST OF PROCESSOR
module testProcessor();
	reg clk, reset;
	reg[31:0] instruction;
	reg[31:0] data_from_mem;

	wire write_enable;
	wire[31:0] pc, address_to_mem, data_to_mem;

	processor CPU(clk, reset, pc, instruction, write_enable, address_to_mem, data_to_mem, data_from_mem);
  
	initial begin
	 $dumpfile("test");
    	 $dumpvars;

	 clk = 1;
	 reset = 0;
	 data_from_mem = 0;
	 //                       ssssstttttiiiiiiiiiiiiiiii
//	 instruction = 32'b 0010 0000 0000 0001 0000 0000 0000 0011;	 //R1<-3+R0
	 #1 
	 clk = 0;
	 #2 
	 clk = 1;
	 //                       ssssstttttiiiiiiiiiiiiiiii
//	 instruction = 32'b 0010 0000 0000 0010 0000 0000 0000 0101;	 //R2<-5+R0
	 #3 
	 clk = 0;
	 #4
	 clk = 1;
	 //                       ssssstttttiiiiiiiiiiiiiiii
//	 instruction = 32'b 0010 0000 0000 0011 0000 0000 0000 1000;	 //R3<-8+R0
	 #5 
	 clk =0;
	 #6
	 clk=1;
	 //                 oooo ooss ssst tttt dddd dxxx xxff ffff
//	 instruction = 32'b 0000 0000 0010 0010 0010 0000 0010 0000;  // R4<-R1+R2	 
	 #7
	 clk=0;
	 #8
	 clk=1;
	 //                 oooo ooss ssst tttt iiii iiii iiii iiii
//	 instruction = 32'b 0001 0000 0110 0100 0000 0000 0000 0101;	// beq R3 == R4 ; PC->+5*4 
	#9
	clk = 0;
	#10
	clk = 1;

	 #100 $finish;
	end
endmodule

//  TEST BENCH *************************************
module testbench();
    reg         clk;
    reg         reset;
    wire [31:0] writedata, dataadr, data_to_mem, address_to_mem;
    wire        memwrite;
    
    top simulated_system (clk, reset, data_to_mem, address_to_mem, write_enable);

    initial    begin
        $dumpfile("test");
        $dumpvars;
        reset<=1; # 2; reset<=0;
        #100; $finish;
    end

    // generate clock
    always    begin
        clk<=1; # 1; clk<=0; # 1;
    end
endmodule
