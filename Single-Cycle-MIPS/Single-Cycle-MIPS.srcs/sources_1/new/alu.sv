`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/03 07:47:06
// Design Name: 
// Module Name: alu
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


module alu #(parameter DATALEN=32) (
    input logic [DATALEN-1:0] a, b,
    input logic [2:0] f,
    output logic zf,
    output logic [DATALEN-1:0] y
    );
             
    logic[DATALEN-1:0] s, bOut;
    
    assign bOut = f[2] ? ~b : b;
    assign s = a + bOut + f[2];
    
    always_comb
        case (f[1:0])
            2'b00: y <= a & bOut;
            2'b01: y <= a | bOut;
            2'b10: y <= s;
            2'b11: y <= s[DATALEN-1];
        endcase
    
    assign zf = (y==0) ? 1 : 0;
                 
endmodule
