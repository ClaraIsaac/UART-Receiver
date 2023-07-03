module deserializer (
    input wire        desser_en,
    input wire        clk,
    input wire        rst,
    input wire        sampled_bit,
    input wire  [3:0] bit_cnt,
    input wire  [4:0] edge_cnt,
    output reg [7:0]  p_data
    
);
reg [8:1] mem_reg;
always @(negedge clk , negedge rst)
begin
    if(!rst)
    begin
        mem_reg<=8'b0;
        p_data<=8'b0;
        
    end
    else
    begin
    if(desser_en==1 && edge_cnt == 7)
    begin
        mem_reg[bit_cnt]<=sampled_bit;    //// Memory acsess decoder 
    end
    if (bit_cnt==9)
    begin
    p_data<= mem_reg;
    
    end
    end
end
endmodule
