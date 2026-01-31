`timescale 1ns/1ps

module tb_gcd;

    reg clk;
    reg rst;
    reg start;
    reg [15:0] data_in;

    wire lt, gt, eq;
    wire ldA, ldB, sel1, sel2, selin, done;

 
    datapathgcd DP (
        .lt(lt),
        .gt(gt),
        .eq(eq),
        .clk(clk),
        .data_in(data_in),
        .ldA(ldA),
        .ldB(ldB),
        .sel1(sel1),
        .sel2(sel2),
        .selin(selin)
    );

    controlgcd CTRL (
        .ldA(ldA),
        .ldB(ldB),
        .sel1(sel1),
        .sel2(sel2),
        .selin(selin),
        .done(done),
        .clk(clk),
        .lt(lt),
        .gt(gt),
        .eq(eq),
        .start(start),
        .rst(rst)
    );

 
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("gcd.vcd");
        $dumpvars(0, tb_gcd);
    end


    task run_gcd;
        input [15:0] a, b;
        begin

            rst   = 1;
            start = 0;
            data_in = 0;
            repeat (2) @(posedge clk);
            rst = 0;


            @(posedge clk);
            data_in = a;
            start   = 1;

            @(posedge clk);
            start   = 0;
            data_in = b;


            wait (done);

            $display("GCD(%0d, %0d) = %0d", a, b, DP.Aout);


            repeat (2) @(posedge clk);
        end
    endtask


    initial begin
        run_gcd(48, 18);   // 6
        run_gcd(54, 24);   // 6
        run_gcd(100, 25);  // 25
        run_gcd(17, 13);   // 1
        run_gcd(36, 36);   // 36

        $display("ALL GCD TESTS DONE ✅");
        $finish;
    end

endmodule
