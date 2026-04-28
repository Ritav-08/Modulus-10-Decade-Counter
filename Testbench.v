`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.04.2026 09:10:27
// Design Name: 
// Module Name: tb_dCounter
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


module tb_dCounter();
reg preset_ti;
reg rst_ti;
reg clk_ti;
wire [3:0]dout_to;

dCounter DUT(.rst_i(rst_ti), 
   .preset_i(preset_ti), 
   .clk_i(clk_ti), 
   .dout_o(dout_to));

//Clock
initial begin
   clk_ti = 1'b0;
   forever 
      #5 clk_ti = ~clk_ti;
end

//Reset
initial begin
rst_ti = 1'b1; preset_ti = 1'b0; //Reset HIGH, Preset LOW
#10 rst_ti = 1'b0; 
#150 rst_ti = 1'b1; //Reset is independent of clock? 
#25 rst_ti = 1'b0; 
#5 preset_ti = 1'b1; //Preset is dependent of clock?
#25 preset_ti = 1'b0;
#50 $finish;
end

//Capture
initial begin
$monitor("Time: %0t | Reset: %b, Clock: %b | Count: %d", $time, rst_ti, clk_ti, dout_to);
$dumpfile("dCounter.vcd");
$dumpvars(0, tb_dCounter);
end

endmodule
