class apb_cov extends uvm_subscriber #(xtn);
  `uvm_component_utils(apb_cov)

  xtn x;

  covergroup apb;
    SELECT:coverpoint x.psel;

    ENABLE:coverpoint x.pen;
    
    WR_RD:coverpoint x.pwrite;

    ADDR :coverpoint x.paddr{
	   // option.at_least=10;
	    bins lower_addr={[0:100]};
	    bins mid_addr={[101:300]};
	    bins high_Addr={[301:511]};
	    }

    DATA :coverpoint x.pwdata{
	    bins lower_wdata={[0:100]};
	    bins mid_wdata={[101:200]};
	    bins high_wdata={[201:255]};
	    }

    READY:coverpoint x.pready;

    CROSS_WRITE_ADDR: cross WR_RD, ADDR; 

    CROSS_ADDR_DATA: cross ADDR, DATA; 
    
  endgroup

  function new(string name="apb_cov", uvm_component parent);
    super.new(name,parent);
    apb=new();
  endfunction

  function void write(xtn t);
    $cast(x,t);
    apb.sample();
  endfunction
endclass
