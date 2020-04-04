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
    output logic ALUSrc,
    output logic [1:0] RegDst,
    output logic RegWrite,
    output logic [1:0] PCSrc, Shift,
    output logic Link, Sign
    );
    
    logic [2:0] ALUOp;
    logic [6:0] Out;
    
    assign {RegWrite, RegDst[1:0], ALUSrc, MemWrite, MemtoReg, Sign} = Out;
    
    always_comb
        case (Op)
            6'b000000: {Out, ALUOp} <= 'b1_01_000X_011;     //R-type
            6'b100011: {Out, ALUOp} <= 'b1_00_1011_010;     //lw
            6'b101011: {Out, ALUOp} <= 'b0_XX_11X1_010;     //sw
            6'b000100: {Out, ALUOp} <= 'b0_XX_00X1_110;     //beq
            6'b001000: {Out, ALUOp} <= 'b1_00_1001_010;     //addi
            6'b000010: {Out, ALUOp} <= 'b0_XX_X0XX_XXX;     //jump
            6'b000101: {Out, ALUOp} <= 'b0_XX_00X1_110;     //bne
            6'b000011: {Out, ALUOp} <= 'b1_10_X0XX_XXX;     //jal
            6'b001010: {Out, ALUOp} <= 'b1_00_1001_111;     //slti
            6'b001100: {Out, ALUOp} <= 'b1_00_1000_000;     //andi
            6'b001011: {Out, ALUOp} <= 'b1_00_1000_001;     //ori
            default: ;
        endcase
    
    always_comb
        case ({ALUOp, Funct})
            9'b011_100000: ALUControl <= 3'b010;     //add
            9'b011_100010: ALUControl <= 3'b110;     //subtract
            9'b011_100100: ALUControl <= 3'b000;     //and
            9'b011_100101: ALUControl <= 3'b001;     //or
            9'b011_101010: ALUControl <= 3'b111;     //set less than
            9'b011_001000: ALUControl <= 3'b010;     //jr
            9'b011_000000: ALUControl <= 3'b010;     //sll
            9'b011_000010: ALUControl <= 3'b010;     //srl
            9'b011_000011: ALUControl <= 3'b010;     //sra
            default: ALUControl <= ALUOp[2:0];
        endcase
    
    always_comb
    begin
        if (Op==6'b000010||Op==6'b000011) PCSrc <= 2'b10;
        else if (Op==6'b000000&&Funct==6'b001000) PCSrc <= 2'b11;
        else if (Op==6'b000100&&Zero || Op==6'b000101&&~Zero) PCSrc <= 2'b01;
        else PCSrc <= 2'b00;
    end
    
    always_comb
    begin
        if ({Op, Funct}==12'b000000_000000) Shift <= 2'b01;              //sll
        else if ({Op, Funct}==12'b000000_000010) Shift <= 2'b10;         //srl
        else if ({Op, Funct}==12'b000000_000011) Shift <= 2'b11;         //sra
        else Shift <= 2'b00;
    end
    
    always_comb
        if (Op==6'b000011) Link <= 1'b1;
        else Link <= 1'b0;
    
endmodule
