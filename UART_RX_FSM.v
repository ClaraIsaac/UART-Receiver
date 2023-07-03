module UART_RX_FSM (
input  wire        RX_IN,
input  wire        rst,
input  wire        clk,
input  wire [3:0]  bit_cnt,
input  wire [4:0]  edge_cnt,
output reg         deser_en,
output reg         edge_bit_cnt_enable,
output reg         bit_cnt_reset,
output reg         data_sample_en


);
localparam  [2:0]    IDLE = 3'b000,
                     start = 3'b001,
                     data = 3'b010,
                     stop =3'b011;
                    


reg    [2:0]         current_state,
                     next_state ;

always @(negedge clk or negedge rst)
 begin
  if(!rst)
   begin
     current_state <= IDLE ;
   end
  else
   begin
     current_state <= next_state ;
   end
 end



always @(*)
 begin

edge_bit_cnt_enable=0;
data_sample_en=0;
deser_en=0;
bit_cnt_reset=0;

  case(current_state)
  IDLE     : begin

              if(RX_IN==0)	
              begin
                next_state =start;
                edge_bit_cnt_enable=1;
              end
              else
              begin
                next_state=IDLE;
                edge_bit_cnt_enable=0;
              end		  
             end
  start       : begin
                edge_bit_cnt_enable=1;
                data_sample_en=1;

              if(bit_cnt==0 && edge_cnt==7)
               begin
                next_state=data;
                end
                else
                begin
                next_state=start;
                end
                
                end 
              


	   
          
  data     : begin
                edge_bit_cnt_enable=1;
                data_sample_en=1;
                deser_en=1;
              if(bit_cnt==8 && edge_cnt==7 )
              begin
                next_state=stop;
              end
              else 
              begin
                next_state=data;
              end
        
            end


 stop     : begin
               edge_bit_cnt_enable=1;
               data_sample_en=1;
               deser_en=0;
              if(bit_cnt==9  && edge_cnt==7)
              begin
                next_state=IDLE;
                bit_cnt_reset=1;
              
              end
              else 
              begin
                next_state=stop;
                bit_cnt_reset=0;
                
              end
        
            end
             
        
                       
  default :   next_state = IDLE ;		 
  
  endcase
end	


		
endmodule		