`timescale 1ns / 1ps

module full_adder(
    input carry_in, x, y,
    output s, carry_out
    );
    
    wire z1, z2, z3;
    
    xor(s, x, y, carry_in);
    and(z1, x, y);
    and(z2, x, carry_in);
    and(z3, y, carry_in);
    or(carry_out, z1, z2, z3);
    
endmodule