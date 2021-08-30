module full#(parameter DSIZE=8,
             parameter ASIZE=4)
(
    input wclk,
    input wrst_n,
    input wen,
    input [ASIZE:0]rptr_db,
    output [ASIZE:0]wptr,
    output [ASIZE-1:0]waddr,
    output full
);

reg [ASIZE:0]bin,bin_next;
reg [ASIZE:0]gray,gray_next;
reg full;

always@(posedge wclk or negedge wrst_n)
    if(!wrst_n) begin
        bin<=0;
        gray<=0;
    end else begin
        bin<=bin_next;
        gray<=gray_next;
    end

always@* begin
    bin_next=bin+(wen & ~full);
    gray_next=bin_next ^ (bin_next>>1);
end

always@(posedge wclk or negedge wrst_n)
    if(!wrst_n)
        full<=0;
    else
        full<=(gray_next[ASIZE:ASIZE-1]!=rptr_db[ASIZE:ASIZE-1]) &
              (gray_next[ASIZE-2:0]==rptr_db[ASIZE-2:0]);

assign wptr=gray;
assign waddr=bin[ASIZE-1:0];

endmodule
