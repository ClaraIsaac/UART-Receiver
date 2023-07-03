module data_sampling (
    input wire            RX_IN,
    input wire [4:0]     edge_cnt,
    input wire           rst,
    input wire           clk,
    input wire           data_sample_en,
    output reg           sampled_bit


);

always @(negedge clk , negedge rst)
begin
if(!rst)
begin
    sampled_bit<=0;
end
else 
if(data_sample_en && edge_cnt== 4)
begin
    sampled_bit <= RX_IN;
end
end


endmodule



