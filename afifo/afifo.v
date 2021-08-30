module afifo#(parameter DSIZE=8,
              parameter ASIZE=4)
(
    input wclk,
    input wen,
    input wrst_n,
    input rclk,
    input ren,
    input rrst_n,
    input [DSIZE-1:0]wdata,
    output [DSIZE-1:0]rdata
);

fifo #(.DSIZE(DSIZE),
      .ASIZE(ASIZE)) u_fifo
(
    .wclk(wclk),
    .wen(wen),
    .full(full),
    .waddr(waddr),
    .wdata(wdata),
    .raddr(raddr),
    .rdata(rdata)
);

db_flop #(.ASIZE(ASIZE)) u_wptr_db(
    .clk(rclk),
    .rst_n(rrst_n),
    .in(wptr),
    .out(wptr_db)
);

db_flop #(.ASIZE(ASIZE)) u_rptr_db(
    .clk(wclk),
    .rst_n(wrst_n),
    .in(rptr),
    .out(rptr_db)
);

empty #(.DSIZE(DSIZE),
        .ASIZE(ASIZE)) u_empty(
    .rclk(rclk),
    .rrst_n(rrst_n),
    .ren(ren),
    .wptr_db(wptr_db),
    .rptr(rptr),
    .raddr(raddr),
    .empty(empty)
);

full #(.DSIZE(DSIZE),
       .ASIZE(ASIZE)) u_full(
    .wclk(wclk),
    .wrst_n(wrst_n),
    .wen(wen),
    .rptr_db(rptr_db),
    .wptr(wptr),
    .waddr(waddr),
    .full(full)
);

endmodule
