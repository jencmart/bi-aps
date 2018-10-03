//*************************** BASIC COMPONENTS *******************************
// MUX 2
module mux2
	# (parameter width = 32)
	(input[width-1:0] d0, d1, input s, output [width-1:0] y);	
	assign y = s == 0 ? d0 : d1; 
endmodule

//MUX 4
//module mux4(input[31:0] d0, d1, d2, d3, input [1:0] s, output reg [31:0] y);
//	always@(*)
//		if( s == 0 )
//			y <= d0;
//		else if( s == 1 )
//			y <= d1;
//		else if(s[1] && ~ s[0] )
//			y <= d2;
//		else
//			y <= d3;
//endmodule

//MUX 4 3 bit input
module mux4_3bitIn(input[31:0] d0, d1, d2, d3, input [2:0] s, output reg [31:0] y);
	always@(*)
		if( s == 3'b100 )
			y <= d0;
		else if( s == 3'b010 )
			y <= d1;
		else if(s == 3'b001 )
			y <= d2;
		else
			y <= d3;
endmodule




// COMPARE
//module comparator
//	# (parameter width = 32)
//	(input [width-1:0] a, b, output y);
//	assign y = a == b ? 1 : 0;
//endmodule

// SIGNED EXTENSION 16->32
module extensionUnit16_32
	# (parameter widthIn = 16, widthOut = 32)
	(input [widthIn - 1:0] in, output [widthOut-1:0] out);
	assign out = in[widthIn - 1] == 0 ? {16'b0, in} : {16'b1111111111111111, in};  
endmodule

// ADD
module adder32(input [31:0] A, B, input CIn, output [31:0] Sum, output Carry, Overflow);
	wire[31:0] tmpRes;
	assign {Carry, tmpRes} = A + B + CIn;
	assign Sum = tmpRes;
	assign Overflow = ( A[31] == B[31] ) && ( A[31] != tmpRes[31] ) ? 1 : 0;
endmodule

// SUUBSTRACT
module substract32(input[31:0] A, B, input CIn, output[31:0] Sum, output Carry, Overflow);
	wire[31:0] tmpRes;
	wire[31:0] tmpB = ~B + 1;
	assign {Carry, tmpRes} = A + tmpB + CIn;
	assign Sum = tmpRes;
	assign Overflow = ( A[31] == tmpB[31] ) && ( A[31] != tmpRes[31] ) ? 1 : 0;
endmodule

// MULTIPY  *4
module multiply4
	# (parameter shiftBy = 2 )
	(input [31:0] in, output[31:0] out);
	assign out = in << shiftBy;
endmodule

module multiply4_26bits
	# (parameter shiftBy = 2 )
	(input [25:0] in, output[25:0] out);
	assign out = in << shiftBy;
endmodule	

// SHIFT LEFT
module shiftLeft
	(input [31:0] in, input[4:0] shiftBy, output [31:0] out);
	assign out = in << shiftBy;
endmodule

/// SHIFT LOGICAL RIGHT
module shiftRightLogical(input[31:0] in,  input[4:0] shiftBy, output[31:0] out);
	assign out = in >> shiftBy;
endmodule

// SHIFT ARITHMETICAL RIGHT
module shiftRightArithmetical(input[31:0] in,  input[4:0] shiftBy, output[31:0] out);
	assign out =  $signed(in) >>> shiftBy;
endmodule

//******************************** REGISTERS  *************************************
// REGISTER 32bit
module reg32 (input[31:0] data_in, input clk, reset, output [31:0] data_out);
	reg [31:0] out_nxt;
	assign data_out = out_nxt;
	initial begin
		out_nxt <= 32'b0;
	end

	always@ (posedge clk) // or negedge reset
	begin
		if (reset) // if !reset
			out_nxt <= 32'b0;
		else	
			out_nxt =  data_in; // {out_nxt, data_in}
	end
endmodule

// REGISTER 32 x 32bit
module reg32x32(input [4:0] a1, a2, a3, input we, clk, input [31:0] wd, output [31:0] rd1, rd2);
	reg [31:0] register32[31:0];
	reg [31:0] rd1_nxt, rd2_nxt;
	assign rd1 = rd1_nxt;
	assign rd2 = rd2_nxt;

	initial begin
		register32[0] = 32'b0;
		rd1_nxt <= 32'b0;
	  	rd2_nxt <= 32'b0;
	end

	always@(*)
	begin
	  rd1_nxt <= register32[a1];
	  rd2_nxt <= register32[a2];
	end

	always@ (posedge clk)
	begin
		if ( we == 1 && a3 != 5'b0)
		begin
			register32[a3] = wd;	
		end
	end
endmodule

//ADD 8
module adder8(input [7:0] A, B, output [7:0] Sum, output Carry);
	assign {Carry, Sum} = A + B;
endmodule

// four unsigned sums
module fourUnsigned(input[31:0] a, b, output[31:0] res, output c);
	wire[7:0] s0, s1, s2, s3;
	wire c0, c1, c2, c3;

	adder8 sum1(a[7:0], b[7:0], s0, c0);
	adder8 sum2(a[15:8], b[15:8], s1, c1);
	adder8 sum3(a[23:16], b[23:16], s2, c2);
	adder8 sum4(a[31:24], b[31:24], s3, c3);

	assign res = {s3, s2, s1, s0};
	assign c = c0 == 1 || c1 == 1 || c2 == 1 || c3 == 1 ? 1 : 0;
endmodule

// four saturated sums
module fourSaturated(input[31:0] a, b, output[31:0] res, output c);
	wire[7:0] s0, s1, s2, s3;
	wire c0, c1, c2, c3;

	adder8 sum1(a[7:0], b[7:0], s0, c0);
	adder8 sum2(a[15:8], b[15:8], s1, c1);
	adder8 sum3(a[23:16], b[23:16], s2, c2);
	adder8 sum4(a[31:24], b[31:24], s3, c3);

	wire[7:0] ss0, ss1, ss2, ss3, ss4;

	assign ss0 = c0 == 1 ? 8'b11111111 : s0;
	assign ss1 = c1 == 1 ? 8'b11111111 : s1;
	assign ss2 = c2 == 1 ? 8'b11111111 : s2;
	assign ss3 = c3 == 1 ? 8'b11111111 : s3;

	assign res = {ss3, ss2, ss1, ss0};
	assign c = c0 == 1 || c1 == 1 || c2 == 1 || c3 == 1 ? 1 : 0;
endmodule

//********************************** ALU UNIT *****************************************
module alu32(input [31:0]srcA, srcB, input [3:0] ALUControl, output [31:0] ALUResult,  output Zero, Carry, Overflow);
	reg[31:0] r_nxt;
	reg z_nxt, c_nxt, o_nxt;

	assign ALUResult = r_nxt;
	assign Zero = z_nxt;
	assign Carry = c_nxt;
	assign Overflow = o_nxt;

	wire[31:0] add_r, sub_r, fourUnsigned_r, fourSaturated_r, sll_r, srl_r, sra_r;
	wire add_c, add_o, sub_c, sub_o, fourUnsigned_c, fourSaturated_c;
	
	adder32                myAdder(srcA, srcB, 1'b0, add_r, add_c, add_o);
	substract32 	       mySubstract(srcA, srcB, 1'b0, sub_r, sub_c, sub_o);
	fourUnsigned           myFourUnsigned(srcA, srcB, fourUnsigned_r, fourUnsigned_c);
	fourSaturated          myFourSaturated(srcA, srcB, fourSaturated_r, fourSaturated_c);

	shiftLeft              myShiftLeft(srcB, srcA[4:0], sll_r );
	shiftRightLogical      myShiftRightLogical(srcB, srcA[4:0], srl_r );
	shiftRightArithmetical myShiftRightArithmetical(srcB, srcA[4:0], sra_r);
	always@(*)
	  case(ALUControl)
		  4'b0010: // A + B
		  begin 
		    r_nxt <= add_r;
	            c_nxt <= add_c;
	            o_nxt <= add_o;	    
		    z_nxt <= (add_r == 0);
		  end	
		  4'b0110: // A - B 		 
		  begin 
		    r_nxt <= sub_r;
	            c_nxt <= sub_c;			//carry takto?
	            o_nxt <= sub_o;	    
		    z_nxt <= (sub_r == 0);
		  end
		  4'b0000: // A & B
		  begin
		    r_nxt <= (srcA & srcB);
		    z_nxt <= (srcA & srcB) == 0;	//zero?
		  end	
		  4'b0001: // A | B
		  begin
		    r_nxt <= (srcA | srcB);
		    z_nxt <= (srcA | srcB) == 0;	//zero?
		  end		
		  4'b0011: // A ^ B
		  begin
		    r_nxt <= (srcA ^ srcB);
		    z_nxt <= (srcA ^ srcB) == 0;	//zero?
		  end		
		  4'b0111: // A < B
		  begin
		    r_nxt <= ( $signed(srcA) < $signed(srcB ));
	            z_nxt <=  ( $signed(srcA) < $signed(srcB )) == 0;
 	    
		 //  if( srcA[31] == 1 && srcB[31] == 0) begin r_nxt <= 1; z_nxt <= 1; end
		 //  else if( srcA[31] == 0 && srcB[31] == 1) begin r_nxt <= 0; z_nxt <= 0; end
		 //  else if( srcA[31] == 0 && srcB[31] == 0) begin r_nxt <= srcA < srcB; z_nxt <= r_nxt; end
		 //  else  begin r_nxt <= srcA > srcB; z_nxt <= r_nxt; end

		  end		
		  4'b1000: // four unsigned sums
		  begin
		     r_nxt <= fourUnsigned_r;
		     c_nxt <= fourUnsigned_c;
		     z_nxt <= (fourUnsigned_r == 0);	//carry?
		  end
  		  4'b1001: // four saturated sums
		  begin
		     r_nxt <= fourSaturated_r;
		     c_nxt <= fourSaturated_c;
		     z_nxt <= (fourSaturated_r == 0);	//carry?
		  end
		  4'b1010: // <<
		  begin
		     r_nxt <= sll_r;
		     z_nxt <= sll_r == 0;  
	          end		 
		  4'b1011: // >> logical
		  begin
		     r_nxt <= srl_r;
		     z_nxt <= srl_r == 0;  
	          end		
		  4'b1100: // >> arithmetical
		  begin
		     r_nxt <= sra_r;
		     z_nxt <= sra_r == 0;  
	          end		  
	endcase
endmodule

module mainDecoder(input[5:0] Opcode,output reg Jal, Jr, RegWrite, MemToReg, MemWrite,  ALUSrc, RegDst, Branch, output reg[1:0] ALUOp );

	always@(*)
	  case(Opcode)
		  6'b00000: begin //1
		    RegWrite <= 1;
		    RegDst   <= 1;
		    ALUSrc   <= 0;
		    ALUOp    <= 2'b10;
		    Branch   <= 0;
		    MemWrite <= 0;
		    MemToReg <= 0;
		    Jal      <= 0;
		    Jr       <= 0;
		  end
      		 6'b100011: begin //2
		    RegWrite <= 1;
		    RegDst   <= 0;
		    ALUSrc   <= 1;
		    ALUOp    <= 2'b00;
		    Branch   <= 0;
		    MemWrite <= 0;
		    MemToReg <= 1;
		    Jal      <= 0;
		    Jr       <= 0;
		  end	
		  6'b101011: begin //3
		    RegWrite <= 0;
		   // RegDst   <= 1;
		    ALUSrc   <= 1;
		    ALUOp    <= 2'b00;
		    Branch   <= 0;
		    MemWrite <= 1;
		   // MemToReg <= 0;
		    Jal      <= 0;
		    Jr       <= 0;
		  end	
		  6'b000100: begin  //4
		    RegWrite <= 0;
		    //RegDst   <= 1;
		    ALUSrc   <= 0;
		    ALUOp    <= 2'b01;
		    Branch   <= 1;
		    MemWrite <= 0;
		   // MemToReg <= 0;
		    Jal      <= 0;
		    Jr       <= 0;
		  end	
		  6'b001000: begin  //5
		    RegWrite <= 1;
		    RegDst   <= 0;
		    ALUSrc   <= 1;
		    ALUOp    <= 2'b00;
		    Branch   <= 0;
		    MemWrite <= 0;
		    MemToReg <= 0;
		    Jal      <= 0;
		    Jr       <= 0;
		  end	
		  6'b000011: begin //6
		    RegWrite <= 1;
		   // RegDst   <= 1;
		   // ALUSrc   <= 0;
		   // ALUOp    <= 2'b10;
		   // Branch   <= 0;
		    MemWrite <= 0;
		   // MemToReg <= 0;
		    Jal      <= 1;
		    Jr       <= 0;
		  end	
		  6'b000111: begin //7
		    RegWrite <= 0;
		   // RegDst   <= 1;
		   // ALUSrc   <= 0;
		   // ALUOp    <= 2'b10;
		   // Branch   <= 0;
		    MemWrite <= 0;
		   // MemToReg <= 0;
		    Jal      <= 0;
		    Jr       <= 1;
		  end	
		  6'b011111: begin //8
		    RegWrite <= 1;
		    RegDst   <= 1;
		    ALUSrc   <= 0;
		    ALUOp    <= 2'b11;
		    Branch   <= 0;
		    MemWrite <= 0;
		    MemToReg <= 0;
		    Jal      <= 0;
		    Jr       <= 0;
		  end	
	endcase

endmodule

module aluOpDecoder(input[1:0] ALUOp, input[5:0] Funct, input[4:0] Shamt, output reg [3:0] ALUControl);
	always@(*)
	  case(ALUOp)
		  2'b00: 
		  begin				//  aluop 00 
		    ALUControl <= 4'b0010;  
		  end
		  2'b01: 
		  begin				// aluop 01 
		    ALUControl <= 4'b0110;   
		  end
		  2'b10: 			//aluop 10
		  begin 
		    if( Funct == 6'b100000 )     ALUControl <= 4'b0010;
	            else if( Funct == 6'b100010) ALUControl <= 4'b0110;
		    else if( Funct == 6'b100100) ALUControl <= 4'b0000;
		    else if( Funct == 6'b100101) ALUControl <= 4'b0001; 
		    else if( Funct == 6'b000100) ALUControl <= 4'b1010; //sll
		    else if( Funct == 6'b000110) ALUControl <= 4'b1011; //srl
	            else if( Funct == 6'b000111) ALUControl <= 4'b1100; //sra		    
		    else 			 ALUControl <= 4'b0111;
		  end	
		  2'b11:			//aluop 11 
		  begin
		    if     (Funct == 6'b010000 && Shamt == 5'b00000) ALUControl <= 4'b1000;
		    else if(Funct == 6'b010000 && Shamt == 5'b00100) ALUControl <= 4'b1001;  
	    	  end 
	endcase

endmodule
//***************************** CONTROL UNIT *************************************
module controlUnit(input [5:0] Opcode, Funct, 
		   input [4:0] Shamt, 
		   output  Jal, Jr, RegWrite, MemToReg, MemWrite,  ALUSrc, RegDst, Branch, 
		   output[3:0] ALUControl);

	   wire[1:0] ALUOp;
	   mainDecoder myMainDecoder(Opcode, Jal, Jr,RegWrite,  MemToReg, MemWrite,  ALUSrc, RegDst, Branch, ALUOp );
	   aluOpDecoder myAluOpDecoder(ALUOp, Funct, Shamt, ALUControl );
endmodule

//******************************* PROCESSOR **************************************

module processor( input         clk, reset, // clk, reset
                  output [31:0] PC, 					// out - PC
                  input  [31:0] instruction, // instruction
                  output        WE,					// out - WE done 
                  output [31:0] address_to_mem,				// out address_to_mem - done
                  output [31:0] data_to_mem,			        // out data_to_mem - done
                  input  [31:0] data_from_mem); // data from mem

// 2. DECODE INSTRUCTION

	  wire[4:0]  RS     = instruction[25:21];  
	  wire[4:0]  RT     = instruction[20:16]; 
	  wire[4:0]  RD     = instruction[15:11];
	  wire[15:0] Imm    = instruction[15:0];
	  wire[25:0] Target = instruction[25:0];


	  wire[3:0] ALUControl;
          wire Jal, Jr, RegWrite, MemToReg, MemWrite,  ALUSrc, RegDst, Branch;
	  wire Zero, Carry, Overflow;
	  wire[31:0] SignImm, ALUOut, SignImmMult;

	  assign WE = MemWrite;

	  extensionUnit16_32 signExt(Imm,SignImm);


	  wire [4:0]  A3;
	  wire [31:0] WD3;
	  wire [31:0] RD1, RD2;


	  controlUnit cunit(instruction[31:26], // opcode 
			    instruction[5:0],   // funct
			    instruction[10:6],  // shamt
			    Jal, Jr, RegWrite, MemToReg, MemWrite,  ALUSrc, RegDst, Branch, ALUControl);

// PC LOGIC
	  wire[31:0] NextPC;
   	  wire[31:0]  curr_pc;
	  assign PC = curr_pc; // ted prvne vyplivnu 0, pri NextPC vyplivnu uz PC+4 napr...

	  reg32 PC_reg(NextPC, clk, reset, curr_pc);

	  wire[31:0] PCPlus4;
	  wire[31:0] PCBranch;
	  wire[31:0] PCJal;
	  wire BranchIt = Zero == 1 && Branch == 1 ? 1 : 0;

	  //PC+4
          adder32 add_4_to_PC(curr_pc, 32'b100, 1'b0, PCPlus4, tmp, tmp);
	  //PCBranch
	  multiply4 multiply_SignImm(SignImm, SignImmMult);
	  adder32 add_SignImmMult_to_PCPlus4(SignImmMult, PCPlus4, 1'b0, PCBranch, tmp, tmp );
	  //PCJa;
	  wire[25:0] TargetShifted;
	  multiply4_26bits multiply_targer(Target, TargetShifted);

	  assign PCJal = {PCPlus4[31:28], TargetShifted}; // NextPC = PCSrcJal ? PCJal todo 
	  // MUX 4 ->  NEXT PC  
	  mux4_3bitIn mux_jr_jal_eq_plus(RD1, PCJal, PCBranch, PCPlus4, {Jr, Jal, BranchIt}, NextPC);	
 
// 3. EXECUTE

  // REG FILE
	  // A3
	  // tmpA3 = RegDst ? rd : rt
	  wire[4:0] tmpA3;
	  mux2 #(5) mux2_RT_RD(RT, RD, RegDst, tmpA3); 
	  // A3 = PCSrcJal ? 32 : tmpA3;
	  mux2 #(5) mux2_tmpA3_32(tmpA3, 5'b11111, Jal, A3); 

	  // WD3
	  wire[31:0] tmpWD3;
	  // tmpWD3 = MemToReg ? data_from_mem : ALUOut
	  mux2  mux2_ALUOut_MemData(ALUOut, data_from_mem, MemToReg, tmpWD3);  
	  // WD3 = PCSrcJal ? PCPlus4 : tmpWD3
	  mux2  mux_tmpWD3_PCPlus4(tmpWD3, PCPlus4, Jal,WD3);
	  // data_to_mem = RD2;
     	  assign data_to_mem = RD2;
 
	  reg32x32 registers(RS,RT,A3,RegWrite, clk, WD3, RD1, RD2);


  // ALU 
	  wire[31:0] srcA, srcB;

	  //adress_to_mem = ALUOut
	  assign address_to_mem = ALUOut;

	  // srcB = ALUSrc ? SignImm : RD2
	  mux2 mux2_RD2_IMM(RD2, SignImm, ALUSrc, srcB);

	  // srcA = RD1;
	  assign srcA = RD1;

	  alu32 ALU(srcA,srcB, ALUControl, ALUOut, Zero,Carry, Overflow);
endmodule

//----------------- TOP ------------------------------------------
module top (    input         clk, reset,
        output [31:0] data_to_mem, address_to_mem,
        output        write_enable);

    wire [31:0] pc, instruction, data_from_mem;

    inst_mem  imem(pc[7:2], instruction);
    data_mem  dmem(clk, write_enable, address_to_mem, data_to_mem, data_from_mem);
    processor CPU(clk, reset, pc, instruction, write_enable, address_to_mem, data_to_mem, data_from_mem);
endmodule

//----------------- DATA MEMORY ------------------------------------------------
module data_mem (input clk, we,
         input  [31:0] address, wd,
         output [31:0] rd);

    reg [31:0] RAM[63:0];

    initial begin
        $readmemh ("bin/data_p2.hex",RAM,0,63);
    end

    assign rd=RAM[address[31:2]]; // word aligned

    always @ (posedge clk)
        if (we)
            RAM[address[31:2]]<=wd;
endmodule

//------------------- INSTRUCTION MEMORY -------------------------------------------
module inst_mem (input  [5:0]  address,
         output [31:0] rd);

    reg [31:0] RAM[63:0];
    initial begin
        $readmemh ("bin/Jenc_Martin_prog2.hex",RAM,0,63);
    end
    assign rd=RAM[address]; // word aligned
endmodule

