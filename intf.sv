interface intf(input bit clk);
  logic prst;
  logic psel;
  logic pen;
  logic pwrite;
  logic[8:0] paddr;
  logic[7:0] pwdata;
  logic[7:0] prdata;
  logic pready;

  clocking drv_cb @(posedge clk);
    default input #0 output #0;
    output prst,psel,pen,pwrite,paddr,pwdata;
    input prdata,pready;
  endclocking

  clocking mon_cb @(posedge clk);
    default input #0 output #0;
    input prst,psel,pen,pwrite,paddr,pwdata,prdata,pready;
  endclocking

  modport drv_mp(clocking drv_cb);
  modport mon_mp(clocking mon_cb);
endinterface
