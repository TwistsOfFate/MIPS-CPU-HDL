`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/18 04:21:06
// Design Name: 
// Module Name: immextend
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


module immextend(
    input logic [15:0] short,
    input logic sign,
    output logic [31:0] long
    );
    
    assign long = { { 16{sign & short[15]} }, short };
    
endmodule
