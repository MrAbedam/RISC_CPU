module CPU_tb;

    // Memory
    reg [7:0] memory [0:15];

    // Ports
    reg clk = 0;
    reg clr = 0;
    wire read;
    wire write;
    wire[7:0] memoryIn, memoryOut;
    wire[3:0] address;

    always @(posedge clk) begin
        if (write) memory[address] <= memoryIn;
    end

    assign memoryOut = memory[address];

    CPU
        CPU_dut (
            .clk (clk),
            .clr(clr),
            .read(read),
            .write(write),
            .memoryOut(memoryOut),
            .memoryIn(memoryIn),
            .address(address)
        );

    initial
    begin
        // add 2+3 in M[4]
         memory[0] = 8'b01000111;
         memory[1] = 8'b00000110;
         memory[2] = 8'b01010100;
         memory[3] = 8'b00000000;
         memory[4] = 8'b00000000;
         memory[5] = 8'b00000000;
         memory[7] = 8'b00000011;
         memory[6] = 8'b00000010;
        
        $dumpvars(0, CPU_tb);
        clr = 1;
        #10;  
        clr = 0;
        #500 ;
        $finish;
    end

    always
        #5 clk = ~clk;

endmodule
