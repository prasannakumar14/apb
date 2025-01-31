class driver extends uvm_driver #(xtn);
  `uvm_component_utils(driver)

  virtual intf.drv_mp vif;

  agent_config m_cfg;

  function new(string name="driver", uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db #(agent_config)::get(this,"","agent_config",m_cfg))
      `uvm_fatal("CONFIG_DB_Error","Have you set it?");
  endfunction

  function void connect_phase(uvm_phase phase);
    vif=m_cfg.vif;
  endfunction

  task run_phase(uvm_phase phase);
    req=xtn::type_id::create("req");
    reset();
    forever begin
      seq_item_port.get_next_item(req);
      case(req.prst)
        1'b 0: reset();
	1'b 1: send_to_dut(req);
      endcase
      seq_item_port.item_done();
    end
  endtask

  task reset();
    @(vif.drv_cb)
       vif.drv_cb.prst<=0;
       vif.drv_cb.psel<='0;
       vif.drv_cb.pwrite<=0;
       vif.drv_cb.paddr<=0;
       vif.drv_cb.pwdata<=0;
       vif.drv_cb.pen<='0;
  endtask 

  task send_to_dut(xtn x);
    //`uvm_info("Driver",$sformatf("From Driver \n %s",x.sprint()),UVM_LOW);

     @(vif.drv_cb)
       vif.drv_cb.prst<=1;
       vif.drv_cb.psel<='1;
       vif.drv_cb.pwrite<=x.pwrite;
       vif.drv_cb.paddr<=x.paddr;
       vif.drv_cb.pwdata<=x.pwrite ? x.pwdata : 0;
    @(vif.drv_cb)
       vif.drv_cb.pen<='1;
    wait(vif.drv_cb.pready == 1)
    @(vif.drv_cb)
       vif.drv_cb.pen<='0;
  endtask
endclass

