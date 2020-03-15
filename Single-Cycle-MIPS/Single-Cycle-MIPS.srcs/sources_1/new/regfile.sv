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


module regfile #(parameter ADDRLEN=5, DATALEN=32) (
    input logic clk,
    input logic we3,
    input logic [ADDRLEN-1:0] a1, a2, a3,
    output logic [DATALEN-1:0] rd1, rd2,
    input logic [DATALEN-1:0] wd3
    );
    
    logic [ADDRLEN-1:0] R[DATALEN-1:0];
    
    always_ff @(posedge clk)
    begin
        if (we3)
            R[a3] <= wd3;
    end
    
    assign rd1 = (a1==0) ? 0 : R[a1];
    assign rd2 = (a2==0) ? 0 : R[a2];
    
endmodule
