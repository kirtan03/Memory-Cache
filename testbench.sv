`include "Assembler.sv"
module Cache;
    
    `define _Set_number 64
    `define _Number_ways 8
    `define _Block_size 64
    `define _Memory_size 16384	//no of blocks in memory
	`define _Number_instructions 524

    logic[7:0] cache_data[`_Set_number][`_Number_ways][`_Block_size];
    logic[$clog2(`_Memory_size)-$clog2(`_Set_number)-1:0] cache_tag[`_Set_number][`_Number_ways];
    logic valid_bit[`_Set_number][`_Number_ways];
    logic dirty_bit[`_Set_number][`_Number_ways];
    logic[$clog2(`_Number_ways)-1:0] counter[`_Set_number][`_Number_ways];
    logic[7:0] memory[`_Memory_size][`_Block_size];
    logic operation_bit[`_Number_instructions];
    logic[$clog2(`_Memory_size)+$clog2(`_Block_size)-1:0] address[`_Number_instructions];
    logic[7:0] data[`_Number_instructions];
    logic[$clog2(`_Block_size)-1:0] offset;
    logic[$clog2(`_Set_number)-1:0] set_number;
    logic[$clog2(`_Memory_size)-$clog2(`_Set_number)-1:0] tag;
    logic hit;
    int read_hit=0,write_hit=0,read_miss=0,write_miss=0;
    Assembler assem(address,operation_bit);
  
    initial begin
      #1 for (int i = 0; i < `_Memory_size; i++) begin //initialize memory as 0
      for (int j = 0; j < `_Block_size; j++) begin
        memory[i][j] = 0;
      end
    end
    for (int i = 0; i < `_Set_number; i++) begin //initialize cache as 0
      for (int j = 0; j < `_Number_ways; j++) begin
        cache_tag[i][j] = 0;
        for (int k = 0; k < `_Block_size; k++) begin
          cache_data[i][j][k] = 0;
        end
      end
    end
    
    for (int i = 0; i < `_Number_instructions; i++) begin //generate random instructions
      data[i] = $urandom_range(255,0);
    end

    for(int b=0;b<`_Set_number;b++)begin //initialize memory and cache as 0
      for(int c=0;c<`_Number_ways;c++)begin
        counter[b][c]=c;
        valid_bit[b][c]=0;
        dirty_bit[b][c]=0;
      end
    end

    for (int i = 0; i < `_Number_instructions; i++) begin
      hit = 0;
      offset=address[i][$clog2(`_Block_size)-1:0];
      set_number=address[i][$clog2(`_Set_number)+$clog2(`_Block_size)-1:$clog2(`_Block_size)];
      tag=address[i][$clog2(`_Memory_size)+$clog2(`_Block_size)-1:$clog2(`_Set_number)+$clog2(`_Block_size)];
      
      hit = 0;
      for (int i = 0; i < `_Number_ways; i++) begin
        if (tag == cache_tag[set_number][i] && valid_bit[set_number][i]) begin
          hit = 1;
        end
      end
//read     
      if(!operation_bit[i]) begin 

//read hit
        if (hit == 1) begin
		  read_hit++;
          for(int j1=0;j1<`_Number_ways;j1++)begin
            if(tag==cache_tag[set_number][j1]&&valid_bit[set_number][j1]) begin
              for(int k1=0;k1<`_Number_ways;k1++)begin
                if(counter[set_number][k1]<counter[set_number][j1])begin
                  counter[set_number][k1]++;
                end
              end
              counter[set_number][j1]=0;
            end
          end

        end

        else begin
          
//read miss
          read_miss++;
          for(int j2=0;j2<`_Number_ways;j2++)begin

            if(counter[set_number][j2]==`_Number_ways-1) begin
              if(valid_bit[set_number][j2]&&dirty_bit[set_number][j2]) begin
                memory[{tag,set_number}] = cache_data[set_number][j2];
              end
              counter[set_number][j2] = 0;
              cache_tag[set_number][j2]= tag;
              cache_data[set_number][j2]=memory[{tag,set_number}];
              valid_bit[set_number][j2]=1;
              dirty_bit[set_number][j2]=0;

              for(int k2=0;k2<`_Number_ways;k2++)begin
                if(k2!=j2)begin
                  counter[set_number][k2]++;
                end
              end
            end
          end
        end
      end

//write
      
      else begin
          
//write hit
        if (hit == 1) begin
          hit = 1;
		  write_hit++;
          for(int j3=0;j3<`_Number_ways;j3++) begin
            if(tag==cache_tag[set_number][j3]&&valid_bit[set_number][j3]) begin
              for(int k3=0;k3<`_Number_ways;k3++)begin
                if(counter[set_number][k3]<counter[set_number][j3])begin
                  counter[set_number][k3]++;
                end
              end
              counter[set_number][j3]=0;
              cache_data[set_number][j3][offset]=data[i];
              dirty_bit[set_number][j3] = 1;
              valid_bit[set_number][j3]=1;
            end
          end		//write hit ends

        end
        
//write miss
        
          else begin
            write_miss++;
            hit = 0;
            for(int j4=0;j4<`_Number_ways;j4++)begin

              if(counter[set_number][j4]==`_Number_ways-1) begin
                if(valid_bit[set_number][j4]&&dirty_bit[set_number][j4]) begin
                  memory[{tag,set_number}] = cache_data[set_number][j4];
                end
                counter[set_number][j4] = 0;
                cache_tag[set_number][j4]= tag;
                cache_data[set_number][j4][offset]=data[i];
                valid_bit[set_number][j4]=1;
                dirty_bit[set_number][j4]=0;

                for(int k4=0;k4<`_Number_ways;k4++)begin
                  if(k4!=j4)begin
                    counter[set_number][k4]++;
                  end
                end

              end
            end
          end 	//write miss ends

        end  // write case ends
		
      end		//foreach ends
    
    $display("Hit Rate = %0f",100*(real'(read_hit+write_hit)/(read_hit+read_miss+write_hit+write_miss)),"%%");
    $display("Number of Read Hits = %0d",read_hit);
    $display("Number of Write Hits = %0d",write_hit);
    $display("Number of Read Misses = %0d",read_miss);
    $display("Number of Write Misses = %0d",write_miss);
    end
    
endmodule