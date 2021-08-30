module div_seq#(parameter DW=8)
(
    input clk,
    input rst_n,
    input in_vld,
    output reg out_vld,
    input [DW-1:0]dividend,
    input [DW-1:0]divisor,
    output reg[DW-1:0]quotient,
    output reg[DW-1:0]remainder
);

reg [2*DW-1:0] a,a_next;
reg [DW-1:0] b;
reg [$clog2(DW):0]cnt;//need 1 more bit

always@(posedge clk or negedge rst_n)
    if(!rst_n)
        cnt<=0;
    else if(out_vld)
        cnt<=0;
    else if(in_vld)
        cnt<=cnt+1

always@(posedge clk or negedge rst_n)
    if(!rst_n) begin
        a<=0;
        b<=0;
    end else if(in_vld) begin
        a<=a_next<<1;
        b<=divisor;
    end

always@*
    if(div_cnt==0)
        a_next={{DW{1'b0}},dividend};
    else if(a[2*DW-1:DW]>=b)
        a_next=a-{b,{DW{1'b0}}+1;
    else
        a_next=a;

always@(posedge clk or negedge rst_n)
    if(!rst_n) begin
        out_vld<=0;
        quotient<=0;
        remainder<=0;
    end else if(in_vld && cnt==WIDTH) begin
        out_vld<=1;
        quotient<=a_next[DW-1:0];
        remainder<=a_next[2*DW-1:DW];
    end else
        out_vld<=0;

endmodule
