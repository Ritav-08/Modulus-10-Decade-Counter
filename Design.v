`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.04.2026 09:09:57
// Design Name: 
// Module Name: dCounter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module dCounter(
   input preset_i, 
   input rst_i, 
   input clk_i, 
   output reg [3:0]dout_o
);

always@(posedge clk_i, posedge rst_i) begin
   if(rst_i) begin
      dout_o <= 4'b0000;
   end
   else if(preset_i) begin
      dout_o <= 4'b0101;
   end
   else if(dout_o == 4'b1001) begin
      dout_o <= 4'b0000;
   end
   else begin
      dout_o <= dout_o + 1;
   end
end

endmodule
