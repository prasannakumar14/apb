//`include "uvm_pkg.sv"
`include "pkg.sv"
`include "intf.sv"
`include "apb_slave.v"

module top();
   import pkg::*;
   import uvm_pkg::*;

  bit clk;
  
  always #5 clk=~clk;

  intf vif(clk);
  
  apb_slave dut(.pclk(clk),.presetn(vif.prst),.paddr(vif.paddr),.pwrite(vif.pwrite),.pwdata(vif.pwdata),.penable(vif.pen),.psel(vif.psel),.prdata(vif.prdata),.pready(vif.pready));

  initial begin
    uvm_config_db #(virtual intf)::set(null,"*","intf",vif);
    run_test("tests");

    #100
    $finish();
  end

  sel_en: assert property(@(posedge clk) vif.psel |=> vif.pen);

endmodule
