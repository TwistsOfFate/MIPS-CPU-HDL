`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/09 07:04:35
// Design Name: 
// Module Name: regfile
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


module regfile(
    input logic clk, reset,
    input logic we3,
    input logic [4:0] a1, a2, a3,
    output logic [31:0] rd1, rd2,
    input logic [31:0] wd3
    );
    
    logic [31:0] R[31:0];
    
    integer i;
    
    always_ff @(posedge clk or posedge reset)
    begin
        if (reset)
            for (i=0;i<32;++i)
                R[i] <= 0;
        else if (we3)
            R[a3] <= wd3;
    end
    
    assign rd1 = (a1==0) ? 0 : R[a1];
    assign rd2 = (a2==0) ? 0 : R[a2];
    
endmodule
