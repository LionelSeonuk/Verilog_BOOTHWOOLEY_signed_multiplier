`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/21 20:06:37
// Design Name: 
// Module Name: tb_mul
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


    module tb_mul;
    reg [3:0] a, b;
    wire [7:0] p,g;

    initial begin
    a = 4'b1010; // 테스트 값을 지정
    b = 4'b1101;
    #200;
    $stop; // 시뮬레이션 종료
    end
    umul dut(.a(a), .b(b), .p(p));
    smul inst(.a(a),.b(b),.g(g));
endmodule
    