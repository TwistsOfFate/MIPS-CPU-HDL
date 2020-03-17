`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/07 11:48:17
// Design Name: 
// Module Name: mips
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


module mips #(parameter ADDRLEN=32, DATALEN=32) (
    input logic clk,
    input logic reset,
    output logic [ADDRLEN-1:0] pc,
    input logic [DATALEN-1:0] instr,
    output logic memwrite,
    output logic [ADDRLEN-1:0] aluout,
    output logic [DATALEN-1:0] writedata,
    input logic [DATALEN-1:0] readdata
    );
    
    logic [ADDRLEN-1:0] next_PC, PC;
    logic [DATALEN-1:0] Instr, SrcA, SrcB, ALUResult, ReadData, WriteData, SignImm, Result, PCPlus4, PCBranch, mux2_pcsrc_y;
    logic [2:0] ALUControl;
    logic RegWrite, MemWrite, ALUSrc, MemtoReg, RegDst, Zero, Branch, Jump, BranchN;
    logic [4:0] WriteReg;
    logic [1:0] PCSrc;
    
    assign Instr = instr;
    assign ReadData = readdata;
    
    pcounter pcounter(.clk(clk), .reset(reset), .next_pc(next_PC), .cur_pc(PC));
    regfile regfile(.clk(clk), .reset(reset), .we3(RegWrite), .a1(Instr[25:21]), .a2(Instr[20:16]), .a3(WriteReg), .rd1(SrcA), .rd2(WriteData), .wd3(Result));
    signext signext(.in(Instr[15:0]), .out(SignImm));
    alu alu(.a(SrcA), .b(SrcB), .f(ALUControl), .zf(Zero), .y(ALUResult));
    adder adder_pcplus4(.a(PC), .b(4), .y(PCPlus4));
    mux2 mux2_alusrc(.d0(WriteData), .d1(SignImm), .s(ALUSrc), .y(SrcB));
    mux2 mux2_memtoreg(.d0(ALUResult), .d1(ReadData), .s(MemtoReg), .y(Result));
    mux2 #(5) mux2_regdst(.d0(Instr[20:16]), .d1(Instr[15:11]), .s(RegDst), .y(WriteReg));
    adder adder_pcbranch(.a({SignImm[DATALEN-3:0], 2'b00}), .b(PCPlus4), .y(PCBranch));
    mux4 mux4_pcsrc(.d0(PCPlus4), .d1(PCBranch), .d2({PCPlus4[31:28], Instr[25:0], 2'b00}), .d3(Result), .s(PCSrc), .y(next_PC));
    control control(.Op(Instr[31:26]), .Funct(Instr[5:0]), .Zero(Zero), .MemtoReg(MemtoReg), .MemWrite(MemWrite),
                     .ALUControl(ALUControl), .ALUSrc(ALUSrc), .RegDst(RegDst), .RegWrite(RegWrite), .PCSrc(PCSrc));
        
    assign pc = PC;
    assign memwrite = MemWrite;
    assign aluout = ALUResult;
    assign writedata = WriteData;
    
    
endmodule
