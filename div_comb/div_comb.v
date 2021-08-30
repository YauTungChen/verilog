module div_comb#(parameter DW=8)
(
    input [DW-1:0]dividend,
    input [DW-1:0]divisor,
    output reg [DW-1:0]quotient,
    output reg [DW-1:0]remainder
);

reg [2*DW-1:0]a;
reg [DW-1:0]b;
integer i;

always@* begin
    a={{DW{1'b0}},dividend};
    b=divisor;
    for(integer i=0;i<DW;i=i+1) begin
        a=a<<1;
        if(a[2*DW-1:DW]>=b) begin
            a=a[2*DW-1:0]-{b[DW-1:0],{DW{1'b0}}}+1;
        end
    end
    quotient=a[DW-1:0];
    remainder=a[2*DW-1:DW];
end
