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
    input logic Zero,
    output logic MemtoReg, MemWrite,
    output logic [2:0] ALUControl,
    output logic ALUSrc, RegDst, RegWrite,
    output logic [1:0] PCSrc
    );
    
    logic [1:0] ALUOp;
    logic [4:0] Out;
    
    always_comb
        case (Op)
            6'b000000: {Out, ALUOp} <= 'b11000_10;   //R-type
            6'b100011: {Out, ALUOp} <= 'b10101_00;   //rw
            6'b101011: {Out, ALUOp} <= 'b0X11X_00;   //sw
            6'b000100: {Out, ALUOp} <= 'b0X00X_01;   //beq
            6'b001000: {Out, ALUOp} <= 'b10100_00;   //addi
            6'b000010: {Out, ALUOp} <= 'b0XX0X_XX;   //jump
            6'b000101: {Out, ALUOp} <= 'b0X00X_01;     //bne
            default: ;
        endcase
    
    always_comb
        casex ({ALUOp, Funct})
            8'b00_XXXXXX: ALUControl <= 3'b010;     //add
            8'bX1_XXXXXX: ALUControl <= 3'b110;     //subtract
            8'b1X_100000: ALUControl <= 3'b010;     //add
            8'b1X_100010: ALUControl <= 3'b110;     //subtract
            8'b1X_100100: ALUControl <= 3'b000;     //and
            8'b1X_100101: ALUControl <= 3'b001;     //or
            8'b1X_101010: ALUControl <= 3'b111;     //set less than
            8'b1X_001000: ALUControl <= 3'b010;     //jr
            default: ;
        endcase
    
    always_comb
    begin
        if (Op==6'b000010) PCSrc <= 2'b10;
        else if (Op==6'b000000&&Funct==6'b001000) PCSrc <= 2'b11;
        else if (Op==6'b000100&&Zero || Op==6'b000101&&~Zero) PCSrc <= 2'b01;
        else PCSrc <= 2'b00;
    end
    
    assign {RegWrite, RegDst, ALUSrc, MemWrite, MemtoReg} = Out;
    
endmodule
