`timescale 1ns / 1ps

module umul(
    input [3:0] a,
    input [3:0] b,
    output [7:0] p
);
    wire [3:0] d0, d1, d2, d3; 
    wire [3:0] sum0, sum1,sum2;
    wire co1, co2, co3; 

    assign d0 = a & {4{b[0]}};
    assign d1 = a & {4{b[1]}};
    assign d2 = a & {4{b[2]}};
    assign d3 = a & {4{b[3]}};

    add4 adder1(.a(d1), .b({1'b0, d0[3:1]}), .ci(1'b0), .s(sum0), .co(co1));
    add4 adder2(.a(d2), .b({co1, sum0[3:1]}), .ci(1'b0), .s(sum1), .co(co2));
    add4 adder3(.a(d3), .b({co2, sum1[3:1]}), .ci(1'b0), .s(sum2), .co(co3));

    assign p = {co3, sum2, sum1[0], sum0[0], d0[0]};
endmodule

