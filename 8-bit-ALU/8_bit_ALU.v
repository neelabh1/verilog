module topmodule( input [7:0] a,
input [7:0] b,
input[2:0] op,
output reg [7:0] z,
output reg carry,
output reg zero_flag,
output reg overflow,
output reg negative_flag
);

always@(*)begin
z = 8'b0;
carry = 1'b0;
overflow = 1'b0;
case(op)
3'b000: begin
{carry, z} = {1'b0, a} + {1'b0, b};
overflow = (~a[7] & ~b[7] & z[7]) | ( a[7] &  b[7] & ~z[7]);
end
3'b001: begin
z = a - b;
overflow = (a[7] ^ b[7]) & (a[7] ^ z[7]);
end
3'b010: z = a & b;
3'b011: z = a | b;
3'b100: z = a ^ b;
3'b101: z = ~a;
3'b110: z = a<<1;
3'b111: z = a>>1;
default: begin
z = 8'b0;
carry = 1'b0;
overflow = 1'b0;
end
endcase
zero_flag = (z == 8'b0);
negative_flag = z[7];

end
endmodule
