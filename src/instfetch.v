module InstFetch(
    input clk,
    input iclk,
    input[31:0] pc,
    output[31:0] inst
);

    // I memory signals
    wire im_cen;
    wire im_wen;
    wire im_oen;
    reg [10:0] im_addr;
    wire [31:0] im_datain;
    wire [31:0] im_dataout;

    assign im_cen = 1'b0;       // always enable
    assign im_wen = 1'b1;       // always not writable
    assign im_oen = 1'b0;       // always output enable
    assign im_datain = 32'b0;   // unused

    assign inst = im_dataout;

    always @(posedge iclk) begin
        #(1)
        im_addr <= pc[10:0];
    end

    RAM2Kx32 #(
        .preload_file(`BIN)
    ) iMem (
        .Q(im_dataout),
        .CLK(iclk),
        .CEN(im_cen),
        .WEN(im_wen),
        .A(im_addr),
        .D(im_datain),
        .OEN(im_oen)
    );
endmodule
