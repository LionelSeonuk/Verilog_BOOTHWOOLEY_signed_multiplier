module smul(
    input [3:0] a,
    input [3:0] b,
    output [7:0] g
);
    wire [3:0] d0, d1, d2, d3; 
    wire [3:0] sum0, sum1, sum2;
    wire co0, co1, co2;
    wire [3:0] s0;

    assign d0 = {~(a[3] & b[0]), a[2] & b[0], a[1] & b[0], a[0] & b[0]};
    assign d1 = {~(a[3] & b[1]), a[2] & b[1], a[1] & b[1], a[0] & b[1]};
    assign d2 = {~(a[3] & b[2]), a[2] & b[2], a[1] & b[2], a[0] & b[2]};
    assign d3 = {a[3] & b[3], ~(a[2] & b[3]),~(a[1] & b[3]),~(a[0] & b[3])};

    assign s0={1'b1,d0[3:1]};
    
    add4 adder0(.a(s0), .b(d1), .ci(1'b0), .s(sum0[3:0]), .co(co0));
    add4 adder1(.a(d2), .b({co0, sum0[3:1]}), .ci(1'b0), .s(sum1[3:0]), .co(co1));
    add4 adder2(.a(d3), .b({co1, sum1[3:1]}), .ci(1'b0), .s(sum2[3:0]), .co(co2));

    assign g = {~co2, sum2, sum1[0], sum0[0], d0[0]};

endmodule
