module TOP_UART_RX (
    input wire              inclk,
    input wire              rst,
    input wire              RX_IN,
    output wire [7:0]       p_data

);

wire            clk;
wire            edge_bit_cnt_enable,bit_cnt_reset;
wire [3:0]      bit_cnt;
wire [4:0]      edge_cnt;
edge_bit_counter top_edge_bit_counter (
    .enable(edge_bit_cnt_enable),
    .clk(clk),
    .rst(rst),
    .bit_cnt(bit_cnt),
    .bit_cnt_reset(bit_cnt_reset),
    .edge_cnt(edge_cnt)

);



wire         deser_en;
wire         data_sample_en;

 UART_RX_FSM  top_UART_RX_FSM (
.RX_IN(RX_IN),
.rst(rst),
.clk(clk),
.bit_cnt(bit_cnt),
.edge_cnt(edge_cnt),


.deser_en(deser_en),
.edge_bit_cnt_enable(edge_bit_cnt_enable),
.bit_cnt_reset(bit_cnt_reset),
.data_sample_en(data_sample_en)

);

wire       sampled_bit;
 data_sampling  top_data_sampling (
    .RX_IN(RX_IN),
    .edge_cnt(edge_cnt),
    .rst(rst),
    .clk(clk),
    .data_sample_en(data_sample_en),
    .sampled_bit(sampled_bit)


);

 deserializer top_deserializer (
    .desser_en(deser_en),
    .clk(clk),
    .rst(rst),
    .sampled_bit(sampled_bit),
    .bit_cnt(bit_cnt),
    .edge_cnt(edge_cnt),
    .p_data(p_data)
);

  pll u0(
 	inclk,
 	clk);

endmodule




