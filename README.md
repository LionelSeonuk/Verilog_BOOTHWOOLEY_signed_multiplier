# BOOTH WOOLEY Signed Multiplier 
Design to efficiently perform multiplication operations of signed integers
<br>
![image](https://github.com/LionelSeonuk/Verilog_BOOTHWOOLEY_signed_multiplier/assets/167200555/cc9b2a10-9ea5-41f5-8572-a1038d48c3c4)

# Code Explain
``` verilog
module fa(a,b,ci,s,co);
    input a,b,ci;
    output co,s;
    
    assign s=a^b^ci;
    assign co=ci&(a^b)|(a&b);
endmodule
```
### Full Adder
```verilog
module add4(
    input [3:0] a,
    input [3:0] b,
    input ci,
    output [3:0] s,
    output co
    );
    wire [3:1] c;
    
   fa u0(a[0],b[0],ci,s[0],c[1]);
   fa u1(a[1],b[1],c[1],s[1],c[2]);
   fa u2(a[2],b[2],c[2],s[2],c[3]);
   fa u3(a[3],b[3],c[3],s[3],co);
   
endmodule
```
### 4Bit Adder
```verilog
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
```
### BOOTH WOOLEY Signed Multiplier
1. The inversion section consists of NAND gates consisting of AND gates and NOT gates for inversion.
2. Except for the inversion, the sections were organized as AND gates, just like unsigned multiplier. (To prevent errors, we solved them one by one without using replication operators.)
3. Full adder, 4-bit adder was instantiated and configured.
4. The first adder adds s0 (add 1 to the bit in front of the MSB of the value that extends d0 to the right of 1 bit) and d1.
5. The second adder adds the d2 and the first addition result by a 1-bit shift to the right.
6. The third adder adds the d3 and the second addition result by a 1-bit shift to the right.
7. The final result, g, is generated by negating the carry-out of the third adder and using it as a sign bit, combining the third adder, the lowest bit of the second and first adder, and the lowest bit of d0. (Using the {} combination operator)
