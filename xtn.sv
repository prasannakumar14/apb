class xtn extends uvm_sequence_item;
  bit prst=1;
  bit psel;
  bit pen;
  rand bit pwrite;
  rand bit[8:0] paddr;
  rand bit[7:0] pwdata;
  rand bit[7:0] prdata;
  bit pready;

  //constraint x{paddr inside{[0:10]};}

  `uvm_object_utils_begin(xtn)
  `uvm_field_int(prst, UVM_ALL_ON)
  `uvm_field_int(psel, UVM_ALL_ON)
  `uvm_field_int(pen, UVM_ALL_ON)
  `uvm_field_int(pwrite, UVM_ALL_ON)
  `uvm_field_int(paddr, UVM_ALL_ON)
  `uvm_field_int(pwdata, UVM_ALL_ON)
  `uvm_field_int(prdata, UVM_ALL_ON)
  `uvm_field_int(pready, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name="xtn");
    super.new(name);
  endfunction

  constraint addr{paddr inside {[1:10]};};
endclass
