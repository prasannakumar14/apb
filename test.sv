class test extends uvm_test;
  `uvm_component_utils(test)

  env envh;
  agent_config m_cfg;

  extern function new(string name="test", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
endclass

function test::new(string name="test", uvm_component parent);
  super.new(name,parent);
endfunction

function void test::build_phase(uvm_phase phase);
  super.build_phase(phase);

  m_cfg=agent_config::type_id::create("m_cfg");

  if(!uvm_config_db #(virtual intf)::get(this,"","intf",m_cfg.vif))
    `uvm_fatal("Config_db_error","Have you set it?");

  uvm_config_db #(agent_config)::set(this,"*","agent_config",m_cfg);

  envh=env::type_id::create("envh",this);
endfunction


class tests extends test;
  `uvm_component_utils(tests)

  write_xtn seq;
  high_data hd;
  mid_addr_data mad;
  extern function new(string name="tests", uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
endclass

function tests::new(string name="tests",uvm_component parent);
  super.new(name,parent);
endfunction

function void tests::build_phase(uvm_phase phase);
  super.build_phase(phase);
endfunction

task tests::run_phase(uvm_phase phase);
  seq=write_xtn::type_id::create("seq");
  hd=high_data::type_id::create("hd");
  mad=mid_addr_data::type_id::create("mad");

  phase.raise_objection(this);
    seq.start(envh.agnth.seqrh);
    hd.start(envh.agnth.seqrh);
    mad.start(envh.agnth.seqrh);
  phase.drop_objection(this);
endtask
