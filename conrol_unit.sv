`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.07.2025 14:34:41
// Design Name: 
// Module Name: control_unit
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



module control_unit (
    input  logic [3:0] opcode,      
    input  logic       zero_flag,  
    output logic       alu_en,
    output logic       reg_write_en,
    output logic       mem_write_en,
    output logic       mem_read_en,
    output logic       pc_inc_en,
    output logic       pc_load_en,
    output logic       halt,
    output logic [2:0] alu_op       
);

 
  // alu_op: 000=ADD, 001=SUB, 010=AND, 011=OR, 100=XOR, 101=INC, 110=DEC
  always_comb begin
    
    alu_en        = 0;
    reg_write_en  = 0;
    mem_write_en  = 0;
    mem_read_en   = 0;
    pc_inc_en     = 1;   
    pc_load_en    = 0;
    halt          = 0;
    alu_op        = 3'b000;

    case (opcode)
      4'b0000: begin 
       
      end
      4'b0001: begin 
        reg_write_en = 1;
      end
      4'b0010: begin 
        mem_read_en  = 1;
        reg_write_en = 1;
      end
      4'b0011: begin 
        mem_write_en = 1;
      end
      4'b0100: begin 
        alu_en        = 1;
        alu_op        = 3'b000;
        reg_write_en  = 1;
      end
      4'b0101: begin 
        alu_en        = 1;
        alu_op        = 3'b001;
        reg_write_en  = 1;
      end
      4'b0110: begin 
        alu_en        = 1;
        alu_op        = 3'b010;
        reg_write_en  = 1;
      end
      4'b0111: begin 
        alu_en        = 1;
        alu_op        = 3'b011;
        reg_write_en  = 1;
      end
      4'b1000: begin 
        alu_en        = 1;
        alu_op        = 3'b100;
        reg_write_en  = 1;
      end
      4'b1001: begin 
        alu_en        = 1;
        alu_op        = 3'b101;
        reg_write_en  = 1;
      end
      4'b1010: begin 
        alu_en        = 1;
        alu_op        = 3'b110;
        reg_write_en  = 1;
      end
      4'b1011: begin
        pc_load_en    = 1;
        pc_inc_en     = 0;
      end
      4'b1100: begin 
        if (zero_flag) begin
          pc_load_en = 1;
          pc_inc_en  = 0;
        end
      end
      4'b1110: begin 
        if (!zero_flag) begin
          pc_load_en = 1;
          pc_inc_en  = 0;
        end
      end
      4'b1111: begin 
        halt       = 1;
        pc_inc_en  = 0;
      end
      default: begin
      
       
      end
    endcase
  end

endmodule
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.07.2025 15:51:08
// Design Name: 
// Module Name: control_unit_tb
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
`timescale 1ns/1ps
module control_unit_tb;

    // Testbench signals
    logic [3:0] opcode;
    logic zero_flag;
    logic alu_en, reg_write_en, mem_write_en, mem_read_en;
    logic pc_inc_en, pc_load_en, halt;
    logic [2:0] alu_op;

    // Instantiate DUT
    control_unit dut (
        .opcode(opcode),
        .zero_flag(zero_flag),
        .alu_en(alu_en),
        .reg_write_en(reg_write_en),
        .mem_write_en(mem_write_en),
        .mem_read_en(mem_read_en),
        .pc_inc_en(pc_inc_en),
        .pc_load_en(pc_load_en),
        .halt(halt),
        .alu_op(alu_op)
    );

    // Task for displaying control signals
    task display_signals;
        $display("[%0t] OPCODE=%b | zero_flag=%b || alu_en=%b alu_op=%b reg_wr=%b mem_rd=%b mem_wr=%b pc_inc=%b pc_load=%b halt=%b",
                  $time, opcode, zero_flag, alu_en, alu_op, reg_write_en, mem_read_en, mem_write_en, pc_inc_en, pc_load_en, halt);
    endtask

    // Test sequence
    initial begin
        $display("---- Control Unit Testbench ----");

        // Default case (NOP)
        opcode = 4'b0000; zero_flag = 0; #5; display_signals();

        // ADD
        opcode = 4'b0100; zero_flag = 0; #5; display_signals();

        // SUB
        opcode = 4'b0101; zero_flag = 0; #5; display_signals();

        // AND
        opcode = 4'b0110; zero_flag = 0; #5; display_signals();

        // OR
        opcode = 4'b0111; zero_flag = 0; #5; display_signals();

        // XOR
        opcode = 4'b1000; zero_flag = 0; #5; display_signals();

        // INC
        opcode = 4'b1001; zero_flag = 0; #5; display_signals();

        // DEC
        opcode = 4'b1010; zero_flag = 0; #5; display_signals();

        // LOAD
        opcode = 4'b0010; zero_flag = 0; #5; display_signals();

        // STORE
        opcode = 4'b0011; zero_flag = 0; #5; display_signals();

        // JMP
        opcode = 4'b1011; zero_flag = 0; #5; display_signals();

        // JZ (zero_flag = 1 → Jump)
        opcode = 4'b1100; zero_flag = 1; #5; display_signals();

        // JZ (zero_flag = 0 → No jump)
        opcode = 4'b1100; zero_flag = 0; #5; display_signals();

        // JNZ (zero_flag = 0 → Jump)
        opcode = 4'b1110; zero_flag = 0; #5; display_signals();

        // JNZ (zero_flag = 1 → No jump)
        opcode = 4'b1110; zero_flag = 1; #5; display_signals();

        // HLT
        opcode = 4'b1111; zero_flag = 0; #5; display_signals();

        $display("---- Testbench Completed ----");
        $finish;
    end

endmodule

