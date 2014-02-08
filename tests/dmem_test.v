module dtest();
  
    reg [0:31] daddr, dwdata;
    wire [0:31] drdata;
    reg dwrite;
    reg [0:1] dsize;
    reg clk;

    dmem #(.SIZE(16384), .DMEMFILE("data.hex")) DMEM(.addr(daddr), .rData(drdata), .wData(dwdata), .writeEnable(dwrite), .dsize(dsize), .clk(clk));

    initial begin
	// - Some Data values
	// 'monitor' follows signals automatically as they change
        $monitor("addr= %x data = %x", daddr, drdata);
        daddr = 32'h2000;
        #1
        daddr = 32'h2001;
    end

endmodule