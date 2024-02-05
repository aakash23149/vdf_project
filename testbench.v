module tb_parking_system;

  // Inputs
  reg clk;
  reg reset_n;
  reg sensor_entrance;
  reg sensor_exit;
  reg [31:0] rfid_tag;

  // Outputs
  wire GREEN_LED, RED_LED;
  wire [3:0] countcar;
  wire [2:0] indicator;

  // Instantiate the parking_system module
  parking_system dut (
    .clk(clk),
    .reset_n(reset_n),
    .sensor_entrance(sensor_entrance),
    .sensor_exit(sensor_exit),
    .rfid_tag(rfid_tag),
    .GREEN_LED(GREEN_LED),
    .RED_LED(RED_LED),
    .countcar(countcar),
    .indicator(indicator)
  );
    
  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  // Stimulus generation
  initial begin
    // Initialize inputs
    reset_n <= 0;
    sensor_entrance <= 0;
    sensor_exit <= 0;
    rfid_tag <= 32'h00000000; // Initialize with an invalid RFID tag

    // Apply reset
    #10 reset_n = 1;

    // Test scenario 1: Successful RFID access, then exit
    #20 rfid_tag <= 32'h12345678; // Provide a valid RFID tag
    #20 sensor_entrance <= 1;     // Activate entrance sensor
    #20 sensor_entrance <= 0;     // Deactivate entrance sensor
    #100 sensor_exit <= 1;        // Activate exit sensor
    #100 sensor_exit <= 0;        // Deactivate exit sensor

    // Test scenario 2: Failed RFID access
    #20 rfid_tag <= 32'h87654321; // Provide an invalid RFID tag
    #20 sensor_entrance <= 1;     // Activate entrance sensor
    #20 sensor_entrance <= 0;     // Deactivate entrance sensor
    #100 sensor_exit <= 1;        // Activate exit sensor
    #100 sensor_exit <= 0;        // Deactivate exit sensor

    // Add more test scenarios as needed

    // Terminate simulation
    #200 $finish;
  end

endmodule
