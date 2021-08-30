module empty#(parameter DSIZE=8,
              parameter ASIZE=4)
(
    input rclk,
    input rrst_n,
    input ren,
    input [ASIZE:0]wptr_db,
    output [ASIZE:0]rptr,
    output [ASIZE-1:0]raddr,
    output empty
);

reg [ASIZE:0]bin,bin_next;
reg [ASIZE:0]gray,gray_next;
reg empty;

always@(posedge rclk or negedge rrst_n)
    if(!rrst_n) begin
        bin<=0;
        gray<=0;
    end else begin
        bin<=bin_next;
        gray<=gray_next;
    end

always@* begin
    bin_next=bin+(ren & ~empty);
    gray_next=bin_next ^ (bin_next>>1);
end

always@(posedge rclk or negedge rrst_n)
    if(!rrst_n)
        empty<=1;
    else
        empty<=(gray_next==wptr_db);

assign rptr=gray;
assign raddr=bin[ASIZE-1:0];

endmodule
