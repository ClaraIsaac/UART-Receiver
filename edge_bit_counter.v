module edge_bit_counter (
    input wire            enable,
    input wire            clk,
    input wire            rst,
    input wire            bit_cnt_reset,
    output reg [3:0]      bit_cnt,
    output reg [4:0]      edge_cnt

);
always @(negedge clk , negedge rst)
begin
    if(!rst)
    begin
        bit_cnt<=4'b0;
        edge_cnt<=5'b0;
    end
    else
    begin
        if(bit_cnt_reset)
        begin
            bit_cnt<=0;
            edge_cnt<=0;
        end
        else if(enable)
        begin
            
            if(edge_cnt < 7)
            begin
                edge_cnt<= edge_cnt +1;
            end
            else
            begin
                edge_cnt<= 0;
            end
            if(edge_cnt== 7)
            begin
                bit_cnt<=bit_cnt+1;
            end
        end
        else
        begin
        edge_cnt<=5'b0;
        bit_cnt<=4'b0;
        end
    end
end
endmodule