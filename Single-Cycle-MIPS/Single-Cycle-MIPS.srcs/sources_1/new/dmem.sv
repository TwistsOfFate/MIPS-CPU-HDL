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
    input logic clk, reset,
    input logic we,
    input logic [31:0] a, wd,
    output logic [31:0] rd
    );
    
    logic [31:0] RAM[255:0];
    
    integer i;   
    
    always_ff @(negedge clk or posedge reset)
    begin
        if (reset)
            for (i=0;i<256;++i)
                RAM[i] <= 0;
        else if (we)
            RAM[a[31:2]] <= wd;
    end
    
    assign rd = RAM[a[31:2]];
    
endmodule
