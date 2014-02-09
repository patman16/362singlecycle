module extender(a,sel, out);
        parameter N = 32;
        input [(N/2)-1:0] a;
        input sel;
        output [N-1:0] out;
        reg [N-1:0] out;

        always @ (sel or a)
        begin
                if(sel == 1'b1)
                begin
                        out[(N/2)-1:0] = a;
                        if(a[1] == 1'b1)
                                out[N-1:N/2] = 16'b1111111111111111;
                        else
                                out[N-1:N/2] = 16'b0000000000000000;
                end
                else
                begin
                        out[(N/2)-1:0] = a;
                        out[N-1:N/2] = 16'b000000000000000;
                end
        end
endmodule
