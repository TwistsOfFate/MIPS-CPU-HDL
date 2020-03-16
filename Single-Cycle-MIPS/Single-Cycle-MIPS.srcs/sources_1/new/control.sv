`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/09 11:36:05
// Design Name: 
// Module Name: control
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


module control(
    input logic [5:0] Op, Funct,
    output logic MemtoReg, MemWrite, Branch,
    output logic [2:0] ALUControl,
    output logic ALUSrc, RegDst, RegWrite, Jump
    );
    
    logic [1:0] ALUOp;
    logic [6:0] Out;
    
    always_comb
        case (Op)
            6'b000000: {Out, ALUOp} <= 9'b1100000_10;   //R-type
            6'b100011: {Out, ALUOp} <= 9'b1010010_00;   //rw
            6'b101011: {Out, ALUOp} <= 9'b0X101X0_00;   //sw
            6'b000100: {Out, ALUOp} <= 9'b0X010X0_01;   //beq
            6'b001000: {Out, ALUOp} <= 9'b1010000_00;   //addi
            6'b000010: {Out, ALUOp} <= 9'b0XXX0X1_XX;   //jump
            default: ;
        endcase
    
    always_comb
        casex ({ALUOp, Funct})
            8'b00_XXXXXX: ALUControl <= 3'b010;
            8'bX1_XXXXXX: ALUControl <= 3'b110;
            8'b1X_100000: ALUControl <= 3'b010;
            8'b1X_100010: ALUControl <= 3'b110;
            8'b1X_100100: ALUControl <= 3'b000;
            8'b1X_100101: ALUControl <= 3'b001;
            8'b1X_101010: ALUControl <= 3'b111;
            default: ;
        endcase
    
    assign {RegWrite, RegDst, ALUSrc, Branch, MemWrite, MemtoReg, Jump} = Out;
    
endmodule
