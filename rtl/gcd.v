    module datapathgcd(lt,gt,eq,clk,data_in,ldA,ldB,sel1,sel2,selin);
        input [15:0] data_in;
        input clk,ldA,ldB,sel1,sel2,selin;
        output lt,gt,eq;
        wire [15:0] Aout,bus,Bout,subout,X,Y;
        PIPO A (Aout,bus,ldA,clk);
        PIPO B (Bout,bus,ldB,clk);
        COMP C (lt,gt,eq,Aout,Bout);
        MUX M1 (X,sel1,Bout,Aout);
        MUX M2(Y,sel2,Bout,Aout);
        MUX M3(bus,selin,data_in,subout);
        SUB S (subout,X,Y);
    endmodule
    module PIPO (dout,din,load,clk);
        input [15:0] din;
        input load,clk;
        output reg [15:0] dout;
        always @(posedge clk)
            begin
                if (load) dout<=din;
            end
    endmodule   
    module SUB(out,X,Y);
        input [15:0] X,Y;
        output reg [15:0] out;
        always @(*) begin
            out=X-Y;
        end
    endmodule
    module COMP (lt,gt,eq,data1,data2);
        input [15:0] data1,data2;
        output lt,eq,gt;
        assign lt=(data1<data2);
        assign gt=(data1>data2);
        assign eq=(data1==data2);
    endmodule
    module MUX(dout,sel,din1,din2);
        input [15:0] din1,din2;
        output [15:0] dout;
        input sel;
        assign dout= sel ? din1:din2;
    endmodule
    module controlgcd(ldA,ldB,sel1,sel2,selin,done,clk,lt,gt,eq,start,rst);
        input clk,lt,gt,eq,start,rst;
        output reg ldA,ldB,sel1,sel2,selin,done;
        reg [2:0] state,NS;
        parameter S0=3'd0,S1=3'd1,S2=3'd2,S5=3'd5;
        always @(posedge clk or posedge rst)
            begin
            if (rst)
                state<=S0;
            else begin
                state<=NS;
            end
            end
        always@(*)
         
            begin
                NS=state;
                ldA=0;ldB=0;sel1=0;sel2=0;selin=0;done=0;
                case(state)
                S0: begin if (start) begin selin=1;ldA=1;ldB=0;done=0;NS=S1; end end
                S1: begin ldA=0;selin=1;ldB=1;NS=S2;end
                S2: begin if(eq==1'b1) begin done=1;NS=S5; end
                            else if (gt==1'b1) begin sel1=0;sel2=1;selin=0;ldA=1;ldB=0;NS=S2; end
                            else if (lt==1'b1) begin sel1=1;sel2=0;selin=0;ldA=0;ldB=1;NS=S2; end
                end
                S5: begin done=1;ldA=0;ldB=0; end
                default: begin ldA=0;ldB=0;sel1=0;sel2=0;selin=0;done=0; end
                endcase
            end


    endmodule
