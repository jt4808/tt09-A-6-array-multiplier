<!---

This file is used to generate your project datasheet. Please fill in the information below and delete any unused
sections.

You can also include images in this folder and reference them in the markdown. Each image must be less than
512 kb in size, and the combined size of all images must be less than 1 MB.
-->

How it works

The provided Verilog code implements a 4x4 array multiplier that multiplies two 4-bit numbers, 
m and q, to produce an 8-bit output. The design begins by extracting the multiplicands from an 
8-bit input, where the upper 4 bits represent m and the lower 4 bits represent q. To compute the 
product, the module calculates partial products using bitwise AND operations for each bit in q. 
These partial products are organized into four arrays, each corresponding to one bit of q. 
The next step involves summing these partial products using a series of full adders. 
Each adder takes the results from the previous stage along with the next bits of the partial products, 
propagating any carries as necessary. The cumulative result of these additions is stored in an 8-bit 
variable p, which is then assigned to the output. The full adder module, utilized in this process, 
implements the basic logic for calculating the sum and carry-out from two inputs and a carry-in. 
This approach—calculating partial products and combining them through structured addition—allows for 
efficient bit-level calculations to achieve the final product.

How to test it

## External hardware
N/A
