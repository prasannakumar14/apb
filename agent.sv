class agent extends uvm_agent;
  `uvm_component_utils(agent)

  driver drvh;
  monitor monh;
  sequencer seqrh;
  apb_cov cov;
 
  agent_config m_cfg;
 
  extern function new(string name="agent", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
endclass

function agent::new(string name="agent", uvm_component parent);
  super.new(name,parent);
endfunction

function void agent::build_phase(uvm_phase phase);
  super.build_phase(phase);
 
  if(!uvm_config_db #(agent_config)::get(this,"","agent_config",m_cfg))
    `uvm_fatal("Config_db_error","Have you set it?");

  monh=monitor::type_id::create("monh",this);
  cov=apb_cov::type_id::create("cov",this);
  
  if(m_cfg.is_active == UVM_ACTIVE)
    drvh=driver::type_id::create("drvh",this);
    seqrh=sequencer::type_id::create("seqrh",this);
endfunction

function void agent::connect_phase(uvm_phase phase);
  if(m_cfg.is_active == UVM_ACTIVE)
    drvh.seq_item_port.connect(seqrh.seq_item_export);
    monh.ap_port.connect(cov.analysis_export);
endfunction
