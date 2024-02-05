`timescale 1ns / 1ps

module parking_system(
    input clk, reset_n,
    input sensor_entrance, sensor_exit,
    input [31:0] rfid_tag,
    output reg GREEN_LED, RED_LED,
    output reg [3:0] countcar,
    output reg [2:0] indicator
);

parameter IDLE = 3'b000, WAIT_RFID = 3'b001, WRONG_RFID = 3'b010, RIGHT_RFID = 3'b011, STOP = 3'b100;
reg[2:0] current_state, next_state;
reg[31:0] entry_time;
reg [3:0] charging_rate = 4'd2; // Charging rate in some units (adjust as needed)
reg [31:0] parking_duration;
reg [7:0] cost_per_hour = 8'd5; // Cost per hour in some units (adjust as needed)
reg [15:0] charging_cost;

always @(posedge clk or posedge reset_n) begin
    if (reset_n) begin
        current_state <= IDLE;
        entry_time <= 0;
        countcar <= 4'b0000;
        charging_cost <= 16'h0000;
    end else begin
        current_state <= next_state;
    end
end

always @(posedge clk or posedge reset_n) begin
    if (reset_n) begin
        entry_time <= 0;
    end else if (current_state == WAIT_RFID) begin
        entry_time <= entry_time + 1;
    end
end

always @(*) begin
    case (current_state)
        IDLE: begin
            if (sensor_entrance == 1)
                next_state = WAIT_RFID;
            else
                next_state = IDLE;
        end
        WAIT_RFID: begin
            if (rfid_tag == 32'h12345678) begin
                next_state = RIGHT_RFID;
                entry_time <= $time;
            end else begin
                next_state = WRONG_RFID;
            end
        end
        WRONG_RFID: begin
            if (sensor_exit == 1)
                next_state = IDLE;
            else
                next_state = WRONG_RFID;
        end
        RIGHT_RFID: begin
            if (sensor_exit == 1) begin
                next_state = STOP;
                parking_duration = $time - entry_time;
                charging_cost = parking_duration * charging_rate / 3600 * cost_per_hour;
                countcar <= countcar + 1;
            end else begin
                next_state = RIGHT_RFID;
            end
        end
        STOP: begin
            if (sensor_entrance == 1)
                next_state = WAIT_RFID;
            else
                next_state = STOP;
        end
        default: next_state = IDLE;
    endcase
end

always @(posedge clk) begin
    case (current_state)
        IDLE: begin
            GREEN_LED = 1'b1;
            RED_LED = 1'b0;
            indicator = 3'b000;
        end
        WAIT_RFID: begin
            GREEN_LED = 1'b0;
            RED_LED = 1'b1;
            indicator = 3'b001;
        end
        WRONG_RFID: begin
            GREEN_LED = 1'b0;
            RED_LED = ~RED_LED;
            indicator = 3'b010;
        end
        RIGHT_RFID: begin
            GREEN_LED = ~GREEN_LED;
            RED_LED = 1'b0;
            indicator = 3'b011;
        end
        STOP: begin
            GREEN_LED <= 1'b0;
            RED_LED <= ~RED_LED;
            indicator <= 3'b100;
        end
    endcase
end


endmodule

