`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.07.2025 15:48:43
// Design Name: 
// Module Name: alu_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu_tb;
logic [3:0]opcode;
logic [7:0] A;
logic [7:0] B;
logic [7:0] result;
logic zero_flag,carry_flag;
alu dut(
.opcode(opcode),
.A(A),
.B(B),
.result(result),
.zero_flag(zero_flag),
.carry_flag(carry_flag)
);
task run_test(input [3:0] op ,input [7:0] a,input [7:0]b );
begin
opcode = op;
A = a;
B = b;
#1;
$display(" OPCODE = %04b | A = %d |B =%d ||result=%d |Zero_flag=%b|carry_flag=%b",opcode,A,B,result,zero_flag,carry_flag);
end 
endtask
initial begin
$display("starting testbench");
//addition
run_test(4'b0000,8'd100,8'd120);
run_test(4'b000,8'd200,8'd100);
run_test(4'b000,8'd200,8'd56);
//subtraction

    run_test(4'b0001, 8'd100, 8'd50);     
    run_test(4'b0001, 8'd50, 8'd100);
    
    
    run_test(4'b0010, 8'b11001100, 8'b10101010); // AND
    run_test(4'b0011, 8'b11001100, 8'b10101010); // OR
    run_test(4'b0100, 8'b11001100, 8'b10101010); // XOR

    // NOT
    run_test(4'b0101, 8'b10101010, 8'd0);        // NOT A
run_test(4'b0110, 8'd0, 8'd123);             // PASS B
    // INC, DEC
    run_test(4'b0110, 8'd255, 8'd0);             // INC (overflow)
    run_test(4'b0111, 8'd0, 8'd0);               // DEC (underflow)

   
    // Zero test
    run_test(4'b0001, 8'd10, 8'd10);
       $display(" Testbench completed.");
    $finish;
  end  

  
endmodule
