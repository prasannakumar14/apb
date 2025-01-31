class monitor extends uvm_monitor;
  `uvm_component_utils(monitor)
  
  virtual intf.mon_mp vif;

  agent_config m_cfg;

  uvm_analysis_port#(xtn) ap_port;

  function new(string name="monitor", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(agent_config)::get(this,"","agent_config",m_cfg))
      `uvm_fatal("CONFIG_DB_Error","Have you set it?");
    ap_port=new("ap_port",this);
  endfunction

  function void connect_phase(uvm_phase phase);
    vif=m_cfg.vif;
  endfunction

  task run_phase(uvm_phase phase);
    forever
      collect_data();
  endtask

  task collect_data();
    xtn x=xtn::type_id::create("x");
    @(vif.mon_cb)
      x.prst=vif.mon_cb.prst;
      x.psel=vif.mon_cb.psel;
      x.pen=vif.mon_cb.pen;
      x.pwrite=vif.mon_cb.pwrite;
      x.paddr=vif.mon_cb.paddr;
      x.pwdata=vif.mon_cb.pwdata;
      x.prdata=vif.mon_cb.prdata;
      x.pready=vif.mon_cb.pready;

    ap_port.write(x);  
  endtask
endclass
