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
    output logic ALUSrc, RegDst, RegWrite
    );
    
    logic [1:0] ALUOp;
    logic [5:0] Out;
    
    always_comb
        case (Op)
            6'b000000: {Out, ALUOp} <= 8'b110000_10;
            6'b100011: {Out, ALUOp} <= 8'b101001_00;
            6'b101011: {Out, ALUOp} <= 8'b0X101X_00;
            6'b000100: {Out, ALUOp} <= 8'b0X010X_01;
            default: ;
        endcase
    
    always_comb
        case ({ALUOp, Funct})
            8'b00_XXXXXX: ALUControl <= 3'b010;
            8'bX1_XXXXXX: ALUControl <= 3'b110;
            8'b1X_100000: ALUControl <= 3'b010;
            8'b1X_100010: ALUControl <= 3'b110;
            8'b1X_100100: ALUControl <= 3'b000;
            8'b1X_100101: ALUControl <= 3'b001;
            8'b1X_101010: ALUControl <= 3'b111;
            default: ;
        endcase
    
    assign {RegWrite, RegDst, ALUSrc, Branch, MemWrite, MemtoReg} = Out;
    
endmodule
