module apb_slave (
    input                   pclk,        // APB clock
    input                   presetn,     // Active low asynchronous reset
    input[8:0]              paddr,       // Address bus
    input                   pwrite,      // Write strobe
    input [7:0]            pwdata,      // Write data bus
    input                   penable,     // APB enable
    input                   psel,        // Chip select
    output reg [7:0]       prdata,      // Read data bus
    output reg              pready       // Ready signal
);

// Define APB slave register map
reg [7:0] reg_map [512];


// Always block for APB slave operation
always @(posedge pclk or negedge presetn) begin
    if (!presetn) begin
        // Reset state
        pready <= 1'b0;
        prdata <= 8'h00000000;
	for(int i=0; i<512; i++)
	   reg_map[i]<='0;
    end
    else if (penable && psel) begin
        // APB operation
        pready <= 1'b1;
        if (pwrite) begin
            // Write operation
            reg_map[paddr] <= pwdata;
        end 
	else begin
            // Read operation
            prdata <= reg_map[paddr];
        end
    end
    else begin
        // Idle state
        pready <= 1'b0;
    end
end

endmodule

