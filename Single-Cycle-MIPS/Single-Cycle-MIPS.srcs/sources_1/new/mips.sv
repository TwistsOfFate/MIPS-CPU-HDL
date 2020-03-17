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
    logic [DATALEN-1:0] Instr, SrcA, SrcB, ALUResult, ReadData, WriteData, ExtImm, Result, PCPlus4, PCBranch, mux2_pcsrc_y, ShiftResult, RegData;
    logic [2:0] ALUControl;
    logic RegWrite, MemWrite, ALUSrc, MemtoReg, Zero, Link, Sign;
    logic [4:0] WriteReg;
    logic [1:0] PCSrc, RegDst, Shift;
    
    assign Instr = instr;
    assign ReadData = readdata;
    
    pcounter pcounter(.clk(clk), .reset(reset), .next_pc(next_PC), .cur_pc(PC));
    regfile regfile(.clk(clk), .reset(reset), .we3(RegWrite), .a1(Instr[25:21]), .a2(Instr[20:16]), .a3(WriteReg), .rd1(SrcA), .rd2(WriteData), .wd3(RegData));
    immextend immextend(.short(Instr[15:0]), .sign(Sign), .long(ExtImm));
    alu alu(.a(SrcA), .b(SrcB), .f(ALUControl), .zf(Zero), .y(ALUResult));
    adder adder_pcplus4(.a(PC), .b(4), .y(PCPlus4));
    mux2 mux2_alusrc(.d0(WriteData), .d1(ExtImm), .s(ALUSrc), .y(SrcB));
    mux2 mux2_memtoreg(.d0(ShiftResult), .d1(ReadData), .s(MemtoReg), .y(Result));
    mux4 #(5) mux2_regdst(.d0(Instr[20:16]), .d1(Instr[15:11]), .d2(5'd31), .d3(5'd0), .s(RegDst), .y(WriteReg));
    adder adder_pcbranch(.a({ExtImm[DATALEN-3:0], 2'b00}), .b(PCPlus4), .y(PCBranch));
    mux4 mux4_pcsrc(.d0(PCPlus4), .d1(PCBranch), .d2({PCPlus4[31:28], Instr[25:0], 2'b00}), .d3(Result), .s(PCSrc), .y(next_PC));
    shifter shifter(.a(ALUResult), .b(Instr[10:6]), .f(Shift), .y(ShiftResult));
    mux2 mux2_link(.d0(Result), .d1(PCPlus4), .s(Link), .y(RegData));
    
    control control(.Op(Instr[31:26]), .Funct(Instr[5:0]), .Zero(Zero), .MemtoReg(MemtoReg), .MemWrite(MemWrite), .ALUControl(ALUControl),
                     .ALUSrc(ALUSrc), .RegDst(RegDst), .RegWrite(RegWrite), .PCSrc(PCSrc), .Shift(Shift), .Link(Link), .Sign(Sign));
    
        
    assign pc = PC;
    assign memwrite = MemWrite;
    assign aluout = ShiftResult;
    assign writedata = WriteData;
    
    
endmodule
