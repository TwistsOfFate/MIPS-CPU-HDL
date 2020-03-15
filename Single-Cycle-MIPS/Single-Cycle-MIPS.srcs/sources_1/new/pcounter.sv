`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/09 07:44:58
// Design Name: 
// Module Name: pcounter
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


module pcounter #(parameter DATALEN=32) (
    input logic clk,
    input logic [DATALEN-1:0] next_pc,
    output logic [DATALEN-1:0] cur_pc
    );
    
    always_ff @(posedge clk)
        cur_pc <= next_pc;
    
endmodule
