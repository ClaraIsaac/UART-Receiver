module UART_RX_TB ();



//Testbench Signals
reg                         RX_CLK_TB;
reg                         RST_TB;
reg                         RX_IN_TB;


wire  [7:0]                 P_DATA_TB; 

reg                         TX_CLK_TB;



//Initial 
initial
 begin

//initial values

RX_CLK_TB         = 1'b1   ;
TX_CLK_TB    = 1'b0   ;
RST_TB            = 1'b1   ;    // rst is deactivated
RX_IN_TB          = 1'b1   ;

//Reset the design
#5
RST_TB = 1'b0;    // rst is activated
#5
RST_TB = 1'b1;    // rst is deactivated
      UART_SEND_BYTE(8'hFF);
      UART_SEND_BYTE(8'hB1);
      UART_SEND_BYTE(8'hC2);
      UART_SEND_BYTE(8'hD3);
      UART_SEND_BYTE(8'hE4);
#100
$stop ;

end

task UART_SEND_BYTE;
    input [7:0] i_Data;
    integer     i;
    begin
       
      // Send Start Bit
     @(posedge TX_CLK_TB) RX_IN_TB <= 1'b0;
       
       
      // Send Data Byte
      for (i=0; i<8; i=i+1)
        begin
       @(posedge TX_CLK_TB) RX_IN_TB<= i_Data[i];
        end
       
      // Send Stop Bit
     @(posedge TX_CLK_TB) RX_IN_TB <= 1'b1;
     end
  endtask // UART_SEND_BYTE
 
 
// Clock Generator  these are synchronized
// always #10 RX_CLK_TB = ~RX_CLK_TB ;
// always #80 TX_CLK_TB = ~TX_CLK_TB ;

initial begin                                // this introduces phase diffrence 
        fork
           forever  
               #10    RX_CLK_TB = ~RX_CLK_TB ;
           #28 forever  
               #80   TX_CLK_TB = ~TX_CLK_TB ;
       join
end

// Design Instaniation
TOP_UART_RX DUT (
.clk(RX_CLK_TB),
.rst(RST_TB),
.RX_IN(RX_IN_TB),
.p_data(P_DATA_TB) 

);

endmodule