module db_flop(
    input clk,
    input rst,
    input in,
    output out
);
reg [1:0]db;

always@(posedge clk or negedge rst_n)
    if(!rst_n) begin
        db[0]<=in;
        db[1]<=db[0];
    end else begin
        db[0]<=in;
        db[1]<=db[0];
    end

assign out=db[1];

endmodule
