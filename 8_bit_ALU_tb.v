module ALU_tb;
    reg [7:0] a, b;
    reg [2:0] op;
    wire [7:0] z;
    wire carry, overflow, zero_flag, negative_flag;


topmodule uut(.a(a),.b(b),.op(op),.z(z),.carry(carry),.overflow(overflow),.zero_flag(zero_flag),.negative_flag(negative_flag));

   initial begin
        $dumpfile("8_bit_ALU.vcd");
        $dumpvars(0, ALU_tb);
        // Basic operations
        a = 5; b = 3; op = 3'b000; #10; // Addition
        $display("ADD: a=%d b=%d z=%d carry=%b overflow=%b zero=%b negative=%b", a,b,z,carry,overflow,zero_flag,negative_flag);

        a = 5; b = 3; op = 3'b001; #10; // Subtraction
        $display("SUB: a=%d b=%d z=%d carry=%b overflow=%b zero=%b negative=%b", a,b,z,carry,overflow,zero_flag,negative_flag);

        a = 5; b = 3; op = 3'b010; #10; // AND
        $display("AND: a=%d b=%d z=%d zero=%b negative=%b", a,b,z,zero_flag,negative_flag);

        a = 5; b = 3; op = 3'b011; #10; // OR
        $display("OR: a=%d b=%d z=%d zero=%b negative=%b", a,b,z,zero_flag,negative_flag);

        a = 5; b = 3; op = 3'b100; #10; // XOR
        $display("XOR: a=%d b=%d z=%d zero=%b negative=%b", a,b,z,zero_flag,negative_flag);

        a = 5; b = 3; op = 3'b101; #10; // NOT
        $display("NOT: a=%d z=%d zero=%b negative=%b", a,z,zero_flag,negative_flag);

        a = 5; b = 3; op = 3'b110; #10; // Left shift
        $display("LEFT SHIFT: a=%d z=%d zero=%b negative=%b", a,z,zero_flag,negative_flag);

        a = 5; b = 3; op = 3'b111; #10; // Right shift
        $display("RIGHT SHIFT: a=%d z=%d zero=%b negative=%b", a,z,zero_flag,negative_flag);


        // Addition and carry tests
        a = 255; b = 1; op = 3'b000; #10;
        $display("ADD CARRY: a=%d b=%d z=%d carry=%b overflow=%b zero=%b negative=%b", a,b,z,carry,overflow,zero_flag,negative_flag);

        a = 200; b = 100; op = 3'b000; #10;
        $display("ADD CARRY: a=%d b=%d z=%d carry=%b overflow=%b zero=%b negative=%b", a,b,z,carry,overflow,zero_flag,negative_flag);


        // Signed overflow tests
        a = 127; b = 1; op = 3'b000; #10;
        $display("ADD OVERFLOW: a=%d b=%d z=%d carry=%b overflow=%b", a,b,z,carry,overflow);

        a = 8'h80; b = 8'hFF; op = 3'b000; #10;
        $display("ADD OVERFLOW: a=%h b=%h z=%h carry=%b overflow=%b", a,b,z,carry,overflow);

        a = 8'h80; b = 1; op = 3'b001; #10;
        $display("SUB OVERFLOW: a=%h b=%h z=%h overflow=%b", a,b,z,overflow);


        // Zero and negative flags
        a = 5; b = 5; op = 3'b001; #10;
        $display("ZERO TEST: a=%d b=%d z=%d zero=%b negative=%b", a,b,z,zero_flag,negative_flag);

        a = 0; b = 1; op = 3'b001; #10;
        $display("NEGATIVE TEST: a=%d b=%d z=%d zero=%b negative=%b", a,b,z,zero_flag,negative_flag);


        // Shift boundary tests
        a = 8'h80; b = 0; op = 3'b110; #10;
        $display("LEFT SHIFT: a=%h z=%h zero=%b negative=%b", a,z,zero_flag,negative_flag);

        a = 8'hFF; b = 0; op = 3'b111; #10;
        $display("RIGHT SHIFT: a=%h z=%h zero=%b negative=%b", a,z,zero_flag,negative_flag);

        $finish;

end
endmodule
