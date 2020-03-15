`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/07 11:22:12
// Design Name: 
// Module Name: dmem
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


module dmem(
    input logic clk,
    input logic we,
    input logic [31:0] a,
    output logic [31:0] wd, rd
    );
    
    logic [31:0] RAM[1023:0];
    
    always_ff @(posedge clk)
    begin
        if (we)
            RAM[a] <= wd;
    end
    
    assign rd = RAM[a];
    
endmodule
