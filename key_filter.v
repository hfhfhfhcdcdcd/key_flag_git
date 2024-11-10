module key_filter (
    input                   clk                 ,
    input                   rst                 ,
    input                   key_in              ,
    output  reg             key_filter
);
/*=============================cnt_20ms================================*/    
 reg [19:0] cnt_20ms ;
 parameter time_20ms = 10_000_00;
 always @(posedge clk or negedge rst) begin
    if (!rst) begin
        cnt_20ms <= 20'd0;
    end
    else if (cnt_20ms == time_20ms - 1) begin
        cnt_20ms <= 20'd0;
    end
    else
        cnt_20ms <= cnt_20ms + 1'b1;
 end
/*=============================key0\key1===============对比前后两拍是否相同=================*/    
 reg key0,key1;
 always @(posedge clk or negedge rst) begin
    if (!rst) begin
        key0 <= 1'd0;
        key1 <= 1'd0;
    end
    else
        key0 <= key_in;//打拍赋值
        key1 <= key0;
 end
/*=============================key_filter================================*/    
 always @(posedge clk or negedge rst) begin
    if (!rst) begin
        key_filter <= 1'd0;
    end
    else if (cnt_20ms == time_20ms - 1) begin
        key_filter <= key1;
    end
    else
        key_filter <= key_filter;    
 end
endmodule

