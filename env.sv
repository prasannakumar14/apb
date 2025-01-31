class env extends uvm_env;
  `uvm_component_utils(env)

  agent agnth;
  sbd sbdh;

  extern function new(string name="env", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase); 
endclass

function env::new(string name="env", uvm_component parent);
  super.new(name,parent);
endfunction

function void env::build_phase(uvm_phase phase);
  super.build_phase(phase);
 
  agnth=agent::type_id::create("agnth",this);
  sbdh=sbd::type_id::create("sbdh",this);
endfunction

function void env::connect_phase(uvm_phase phase);
  agnth.monh.ap_port.connect(sbdh.mon_port.analysis_export);
endfunction
