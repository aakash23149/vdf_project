`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.02.2024 13:46:07
// Design Name: 
// Module Name: smart_parking
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
module DFF (
input clk, D,
output reg Q);
always @(posedge clk)
Q<=D;
endmodule

module DFF4 (
input clk, 
input [3:0]D,
output reg [3:0]Q);
always @(posedge clk)
Q<=D;
endmodule

module DFF10 (
input clk,
input [9:0]D,
output reg [9:0]Q);
always @(posedge clk)
Q<=D;
endmodule


module smart_parking(
input clk,rst,
input sensor_entry,
input sensor_exit,
input want_to_charge,

input [3:0] entry_slot,
input [3:0] exit_slot,
//input [9:0] entered_passcode,


//output reg can_park,
//output reg can_exit,
 

output  [9:0] entry_timee,
output  [9:0]exit_time,
output  [9:0]total_bill

 );
 
wire sensor_entry1;
wire sensor_exit1;
wire want_to_charge1;

wire [3:0] entry_slot1;
wire [3:0] exit_slot1;
//wire [9:0] entered_passcode1;

reg [9:0] entry_timee1;
reg [9:0]exit_time1;
reg [9:0]total_bill1;
//reg can_exit1;



   
 reg [9:0] count=0;
 reg charge_record [15:0];
 reg [9:0]entry_time [15:0];

 parameter s1=4'b0000, s2=4'b0001, s3=4'b0010,s4=4'b0011,s5=4'b0100,s6=4'b0101,s7=4'b0110,s8=4'b0111;
 parameter s9=4'b1000, s10=4'b1001, s11=4'b1010,s12=4'b1011,s13=4'b1100,s14=4'b1101,s15=4'b1110,s16=5'b1111;
 integer i;
 
 DFF D_sensor_entry (.clk(clk), .D(sensor_entry), .Q(sensor_entry1));
 DFF D_sensor_exit (.clk(clk), .D(sensor_exit), .Q(sensor_exit1));
 DFF D_want_to_charge (.clk(clk), .D(want_to_charge), .Q(want_to_charge1));
 DFF4 D_entry_slot (.clk(clk), .D(entry_slot), .Q(entry_slot1));
 DFF4 D_exit_slot (.clk(clk), .D(exit_slot), .Q(exit_slot1));
 //DFF10 D_entered_passcode (.clk(clk), .D(entered_passcode), .Q(entered_passcode1));
 DFF10 D_entry_timee (.clk(clk), .D(entry_timee1), .Q(entry_timee));
 DFF10 D_exit_time (.clk(clk), .D(exit_time1), .Q(exit_time));
 DFF10 D_total_bill (.clk(clk), .D(total_bill1), .Q(total_bill));
// DFF D_can_exit (.clk(clk), .D(can_exit1), .Q(can_exit));       
      
 always @ (posedge clk)
 begin
 count = count + 1'b1;

 if(rst==1)
 begin
 entry_timee1=9'b0;
 exit_time1=9'b0;
 total_bill1=10'b0;
 end

 else if(sensor_entry1)
 
begin
entry_time[entry_slot1]= count;
entry_timee1=entry_time[entry_slot1];

if(want_to_charge1)
charge_record[entry_slot1]=1;
else
charge_record[entry_slot1]=0;
end
 
 
else if(sensor_exit1)
 begin
  

 case(exit_slot1)
 s1: begin
 //if(entered_passcode1==alloted_passcode[s1])
// begin
  
//can_exit=1;
exit_time1 = count;
 if(charge_record[s1])
 begin

 total_bill1 = (exit_time1 - entry_time[s1])*19;
 end
 else
 begin
  total_bill1 = (exit_time1 - entry_time[s1])*10;
 end
 end
 
 
 //else
 //begin
 //can_exit=0;
 //exit_time=0;
// total_bill1=0;
// end
 
// end
 
 s2: begin
// if(entered_passcode1==alloted_passcode[s2])
// begin
//can_exit=1;
  exit_time1 = count;
 if(charge_record[s2])
 begin

 total_bill1 = (exit_time1 - entry_time[s2])*19;
 end
 else
 begin
  total_bill1 = (exit_time1 - entry_time[s2])*10;
 end
 end
 
 
// else
// begin
// can_exit=0;
//  exit_time1=0;
//  total_bill=0;
// end
// end
 
 s3: begin
// if(entered_passcode1==alloted_passcode[s3])
// begin

//  can_exit=1;
  exit_time1 = count;
 if(charge_record[s3])
 begin

 total_bill1 = (exit_time1 - entry_time[s3])*19;
 end
 else
 begin
  total_bill1 = (exit_time1 - entry_time[s3])*10;
 end
 end
 
 
// else
// begin
// can_exit=0;
//  exit_time=0;
//  total_bill=0;
// end
// end
 
 s4: begin
//if(entered_passcode1==alloted_passcode[s4])
// begin

//  can_exit=1;
  exit_time1 = count;
 if(charge_record[s4])
 begin

 total_bill1 = (exit_time1 - entry_time[s4])*19;
 end
 else
 begin
  total_bill1 = (exit_time1 - entry_time[s4])*10;
 end
// end
 
 
// else
// begin
// can_exit=0;
//  exit_time=0;
//  total_bill=0;
// end
 end
 
 s5: begin
// if(entered_passcode1==alloted_passcode[s5])
// begin

//  can_exit=1;
  exit_time1 = count;
 if(charge_record[s5])
 begin

 total_bill1 = (exit_time1 - entry_time[s5])*19;
 end
 else
 begin
  total_bill1 = (exit_time1 - entry_time[s5])*10;
 end
// end
 
 
// else
// begin
// can_exit=0;
//  exit_time=0;
//  total_bill=0;
// end
 end
 
 s6: begin
// if(entered_passcode1==alloted_passcode[s6])
// begin

//  can_exit=1;
  exit_time1 = count;
 if(charge_record[s6])
 begin

 total_bill1 = (exit_time1 - entry_time[s6])*19;
 end
 else
 begin
  total_bill1 = (exit_time1 - entry_time[s6])*10;
 end
// end
 
 
// else
// begin
// can_exit=0;
//  exit_time=0;
//  total_bill=0;
// end
end
 
 s7: begin
// if(entered_passcode1==alloted_passcode[s7])
// begin

//  can_exit=1;
  exit_time1 = count;
 if(charge_record[s7])
 begin

 total_bill1 = (exit_time1 - entry_time[s7])*19;
 end
 else
 begin
  total_bill1 = (exit_time1 - entry_time[s7])*10;
 end
 //end
 
 
// else
// begin
// can_exit=0;
//  exit_time=0;
//  total_bill=0;
// end
end
 
 s8: begin
//if(entered_passcode1==alloted_passcode[s8])
// begin

//  can_exit=1;
  exit_time1 = count;
 if(charge_record[s8])
 begin

 total_bill1 = (exit_time1 - entry_time[s8])*19;
 end
 else
 begin
  total_bill1 = (exit_time1 - entry_time[s8])*10;
 end
 end
 
 
// else
// begin
// can_exit=0;
//  exit_time=0;
//  total_bill=0;
// end
// end
 
 s9: begin
// if(entered_passcode1==alloted_passcode[s9])
// begin
 
//  can_exit=1;
  exit_time1 = count;
 if(charge_record[s9])
 begin

 total_bill1 = (exit_time1 - entry_time[s9])*19;
 end
 else
 begin
  total_bill1 = (exit_time1 - entry_time[s9])*10;
 end
 end
 
 
// else
// begin
// can_exit=0;
//  exit_time=0;
//  total_bill=0;
// end
// end
 
 s10: begin
// if(entered_passcode1==alloted_passcode[s10])
// begin

//  can_exit=1;
  exit_time1 = count;
 if(charge_record[s10])
 begin

 total_bill1 = (exit_time1 - entry_time[s10])*19;
 end
 else
 begin
  total_bill1 = (exit_time1 - entry_time[s10])*10;
 end
 end
 
 
// else
// begin
// can_exit=0;
//  exit_time=0;
//  total_bill=0;
// end
// end
 
 s11: begin
// if(entered_passcode1==alloted_passcode[s11])
// begin

//  can_exit=1;
  exit_time1 = count;
 if(charge_record[s11])
 begin

 total_bill1= (exit_time1 - entry_time[s11])*19;
 end
 else
 begin
  total_bill1 = (exit_time1 - entry_time[s11])*10;
 end
 end
 
 
// else
// begin
// can_exit=0;
//  exit_time=0;
//  total_bill=0;
// end
// end
 
 s12: begin
// if(entered_passcode1==alloted_passcode[s12])
// begin

//  can_exit=1;
  exit_time1 = count;
 if(charge_record[s12])
 begin

 total_bill1 = (exit_time1 - entry_time[s12])*19;
 end
 else
 begin
  total_bill1 = (exit_time1 - entry_time[s12])*10;
 end
 end
 
 
// else
// begin
// can_exit=0;
//  exit_time=0;
//  total_bill=0;
// end
// end
 
 s13: begin
//if(entered_passcode1==alloted_passcode[s13])
// begin

//  can_exit=1;
  exit_time1 = count;
 if(charge_record[s13])
 begin

 total_bill1 = (exit_time1 - entry_time[s13])*19;
 end
 else
 begin
  total_bill1 = (exit_time1 - entry_time[s13])*10;
 end
 end
 
 
// else
// begin
// can_exit=0;
//  exit_time=0;
//  total_bill=0;
// end
// end
 
 s14: begin
// if(entered_passcode1==alloted_passcode[s14])
// begin
  
//  can_exit=1;
  exit_time1 = count;
 if(charge_record[s14])
 begin

 total_bill1 = (exit_time1 - entry_time[s14])*19;
 end
 else
 begin
  total_bill1 = (exit_time1 - entry_time[s14])*10;
 end
 end
 
 
// else
// begin
// can_exit=0;
//  exit_time=0;
//  total_bill=0;
// end
// end
 
 s15: begin
// if(entered_passcode1==alloted_passcode[s15])
// begin
  
//  can_exit=1;
  exit_time1 = count;
 if(charge_record[s15])
 begin

 total_bill1 = (exit_time1 - entry_time[s15])*19;
 end
 else
 begin
  total_bill1 = (exit_time1 - entry_time[s15])*10;
 end
 end
 
 
// else
// begin
// can_exit=0;
//  exit_time=0;
//  total_bill=0;
// end
// end
 
 s16: begin
// if(entered_passcode1==alloted_passcode[s16])
// begin

//  can_exit=1;
  exit_time1 = count;
 if(charge_record[s16])
 begin

 total_bill1 = (exit_time1 - entry_time[s16])*19;
 end
 else
 begin
  total_bill1 = (exit_time1 - entry_time[s16])*10;
 end
 end
 
 
// else
// begin
// can_exit=0;
//  exit_time=0;
//  total_bill=0;
// end
// end
 
 endcase
 
 
 
 end
 
 end
endmodule
