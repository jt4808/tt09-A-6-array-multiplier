/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_A_6_array_multiplier (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.

    wire[3:0] m = ui_in [7:4];
    wire[3:0] q = ui_in [3:0];
    wire[7:0] p;

    wire [3:0] mult0, mult1, mult2, mult3;   // indiv. layers of multiplication by hand
    wire [3:0] pp1, pp2;                // partial products
    
    wire carry_1, carry_2, carry_3, carry_4, carry_5, carry_6, carry_7, carry_8, carry_9;
    
    assign mult0[0] = m[0] & q[0];
    assign mult0[1] = m[1] & q[0];    
    assign mult0[2] = m[2] & q[0];
    assign mult0[3] = m[3] & q[0];    
    
    assign mult1[0] = m[0] & q[1];
    assign mult1[1] = m[1] & q[1];    
    assign mult1[2] = m[2] & q[1];
    assign mult1[3] = m[3] & q[1];    

    assign mult2[0] = m[0] & q[2];
    assign mult2[1] = m[1] & q[2];    
    assign mult2[2] = m[2] & q[2];
    assign mult2[3] = m[3] & q[2];   
    
    assign mult3[0] = m[0] & q[3];
    assign mult3[1] = m[1] & q[3];    
    assign mult3[2] = m[2] & q[3];
    assign mult3[3] = m[3] & q[3];   
     
    assign p[0] = mult0[0];

    full_adder stage1 (1'b0, mult0[1], mult1[0], p[1], carry_1);
    full_adder stage2 (carry_1, mult0[2], mult1[1], pp1[0], carry_2);
    full_adder stage3 (carry_2, mult0[3], mult1[2], pp1[1], carry_3);
    full_adder stage4 (carry_3, 1'b0, mult1[3], pp1[2], pp1[3]);
    
    full_adder stage5 (1'b0, pp1[0], mult2[0], p[2], carry_4);
    full_adder stage6 (carry_4, pp1[1], mult2[1], pp2[0], carry_5);
    full_adder stage7 (carry_5, pp1[2], mult2[2], pp2[1], carry_6);
    full_adder stage8 (carry_6, pp1[3], mult2[3], pp2[2], pp2[3]);
    
    full_adder stage9 (1'b0, pp2[0], mult3[0], p[3], carry_7);
    full_adder stage10 (carry_7, pp2[1], mult3[1], p[4], carry_8);
    full_adder stage11 (carry_8, pp2[2], mult3[2], p[5], carry_9);
    full_adder stage12 (carry_9, pp2[3], mult3[3], p[6], p[7]);

    assign uo_out = p;

  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, uio_in, 1'b0};

endmodule


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