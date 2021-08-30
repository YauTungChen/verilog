module fifo#(parameter DSIZE=8,
             parameter ASIZE=4)
(
    input wclk,
    input wen,
    input full,
    input [ASIZE-1:0]waddr,
    input [DSIZE-1:0]wdata,
    input [ASIZE-1:0]raddr,
    output [DSIZE-1:0]rdata
);

reg [DSIZE-1:0]mem[0:2**ASIZE-1]

always@(posedge wclk)
    if(wen & !full)
        mem[waddr]<=wdata;

assign rdata=mem[raddr];

endmodule
