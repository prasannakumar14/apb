class seqq extends uvm_sequence #(xtn);
  `uvm_object_utils(seqq)

  extern function new(string name="seqq");
endclass

function seqq::new(string name="seqq");
  super.new(name);
endfunction


class write_xtn extends seqq;
  `uvm_object_utils(write_xtn)

  extern function new(string name="write_xtn");
  extern task body();
endclass

function write_xtn::new(string name="write_xtn");
  super.new(name);
endfunction

task write_xtn::body();
  repeat(10) begin
    req=xtn::type_id::create("req");
    start_item(req);
    req.randomize();
    finish_item(req);
  end
endtask

class high_data extends seqq;
  `uvm_object_utils(high_data)

  extern function new(string name="high_data");
  extern task body();
endclass

function high_data::new(string name="high_data");
  super.new(name);
endfunction

task high_data::body();
  `uvm_do_with(req,{req.pwdata inside{[201:255]};});
endtask

class mid_addr_data extends seqq;
  `uvm_object_utils(mid_addr_data)

  extern function new(string name="mid_addr_data");
  extern task body();
endclass

function mid_addr_data::new(string name="mid_addr_data");
  super.new(name);
endfunction

task mid_addr_data::body();
  repeat(10)
    `uvm_do_with(req,{req.pwdata inside{[101:200]}; req.paddr inside{[101:300]};});
endtask
