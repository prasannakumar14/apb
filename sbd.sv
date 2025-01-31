class sbd extends uvm_scoreboard;
  `uvm_component_utils(sbd)

  uvm_tlm_analysis_fifo #(xtn) mon_port;

  xtn x;
  
  bit[7:0]ref_ram[512];
  bit[7:0]ref_data;

  function new(string name="sbd", uvm_component parent);
    super.new(name,parent);
    mon_port=new("mon_port",this);
  endfunction

  task run_phase(uvm_phase phase);
    forever begin
      mon_port.get(x);
      check_data(x); 
    end
  endtask

  function void check_data(xtn data);
	  
    if(data.pwrite)begin
      ref_ram[data.paddr]=data.pwdata;
    end
    else begin
      ref_data=ref_ram[data.paddr];
      compare_data(ref_data, data.prdata);
    end
  endfunction

  function void compare_data(input bit[7:0] ref_data, golden_data);
    if(ref_data !=0) begin
      if(ref_data == golden_data) begin
        $display("---------------------------Data Comparsion Successfull---------------------------");
      end
      else begin
        $display("---------------------------Data Comparsion Unsuccessfull---------------------------");
      end
    end
    else begin
       $display("---------------------------Data Notfound---------------------------");
    end
  endfunction
endclass
