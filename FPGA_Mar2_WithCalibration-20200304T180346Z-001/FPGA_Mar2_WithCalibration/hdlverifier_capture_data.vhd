
-- ----------------------------------------------
-- File Name: hdlverifier_capture_data.vhd
-- Created:   02-Mar-2020 21:45:57
-- Copyright  2020 MathWorks, Inc.
-- ----------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_arith.all;

entity hdlverifier_capture_data is
   GENERIC(
      DATA_WIDTH:integer;
      ADDR_WIDTH:integer);
   port (
    clk : in std_logic;
    clk_enable : in std_logic;
    data : in std_logic_vector(DATA_WIDTH - 1 downto 0);
    flag_full : out std_logic;
    has_clk : out std_logic;
    reset : in std_logic;
    run : in std_logic;
    run_tck : in std_logic;
    immediate : in std_logic;
    shift_out_data : out std_logic;
    shift_out_en : in std_logic;
    shift_out_state : in std_logic;
    tck : in std_logic;
    trigger : in std_logic;
    trigger_pos : in std_logic_vector(ADDR_WIDTH - 1 downto 0);
	ready_to_capture : out std_logic;
    captured_window_count : out std_logic_vector(ADDR_WIDTH - 1 downto 0);
    number_of_windows : in std_logic_vector(ADDR_WIDTH - 1 downto 0)
  );
end entity; 



architecture rtl of hdlverifier_capture_data is
  signal bitcount : std_logic_vector(15 downto 0);  
  signal capture_valid : std_logic;  
  signal pos_counter : std_logic_vector(ADDR_WIDTH - 1 downto 0);  
  signal pre_counter : std_logic_vector(ADDR_WIDTH - 1 downto 0);  
  signal q : std_logic_vector(DATA_WIDTH - 1 downto 0);  
  signal raddr : std_logic_vector(ADDR_WIDTH - 1 downto 0);  
  signal rd : std_logic;  
  signal reg_full : std_logic;  
  signal run_d1 : std_logic;  
  signal shift_reg : std_logic_vector(DATA_WIDTH - 1 downto 0);  
  signal state_reg : std_logic_vector(3 downto 0);  
  signal waddr : std_logic_vector(ADDR_WIDTH - 1 downto 0);  
  signal ram_waddr : std_logic_vector(ADDR_WIDTH - 1 downto 0);  
  signal data_wtrigger_info : std_logic_vector(DATA_WIDTH - 1 downto 0);  																 																		  
  signal wr : std_logic;  
  signal wr_d1 : std_logic;							 
  signal internal_trigger : std_logic;
  signal reg_clk : std_logic;
  signal windw_captured_int : std_logic;
  signal windw_captured : std_logic;
  signal windw_captured_tck : std_logic;
  signal windw_captured_tck_d1 : std_logic;
  signal windw_captured_tck_ed : std_logic;
  signal window_size_i : std_logic_vector(ADDR_WIDTH downto 0);  
  signal window_size : std_logic_vector(ADDR_WIDTH - 1 downto 0);  
  signal window_size_plus1 : std_logic_vector(ADDR_WIDTH downto 0);  
  signal trigpos_eq_depth : std_logic;
  signal trigpos_eq_zero : std_logic;
  signal trigpos_nteq_zero : std_logic;
  signal trigpos_ms1 : std_logic_vector(ADDR_WIDTH - 1 downto 0);
  signal windsze_ms_trig_pos : std_logic_vector(ADDR_WIDTH - 1 downto 0);  
  signal memory_depth_ms_windsz : std_logic_vector(ADDR_WIDTH downto 0);  
  signal wr_window_count : std_logic_vector(ADDR_WIDTH downto 0);  
  signal wr_window_count_by1 : std_logic_vector(ADDR_WIDTH - 1 downto 0);  
  signal wr_window_count_gray : std_logic_vector(ADDR_WIDTH - 1 downto 0);  
  signal wr_window_count_gray_tckreg : std_logic_vector(ADDR_WIDTH - 1 downto 0);  
  signal wr_window_count_bintck : std_logic_vector(ADDR_WIDTH - 1 downto 0);																			  
  signal captured_window_count_int : std_logic_vector(ADDR_WIDTH - 1 downto 0);  
  signal waddr_eq_windsz : std_logic;
  signal trigcond_met : std_logic;
  signal trigcond_met_d1 : std_logic;
  signal trigger_bitinfo : std_logic;
  signal trigcond_met_tck : std_logic;
  signal ready_to_capture_int : std_logic;

  constant DEPTH_I:integer:= 2**ADDR_WIDTH;
  signal DEPTH:std_logic_vector(ADDR_WIDTH downto 0);
  signal DEPTH_MS1:std_logic_vector(ADDR_WIDTH downto 0);
  signal DEPTH_MS2:std_logic_vector(ADDR_WIDTH downto 0);
  


 component hdlverifier_synchronizer is
    generic( WIDTH:integer);
    port (
      clk : in std_logic;
      data_in : in std_logic_vector(WIDTH-1 downto 0);
      data_out : out std_logic_vector(WIDTH-1 downto 0)
    );
  end component;
  
  component hdlverifier_dcram is
    GENERIC(
      DATA_WIDTH:integer;
      ADDR_WIDTH:integer);  
    port (
      q : out std_logic_vector(DATA_WIDTH - 1 downto 0);
      raddr : in std_logic_vector(ADDR_WIDTH - 1 downto 0);
      rclk : in std_logic;
      rd : in std_logic;
      waddr : in std_logic_vector(ADDR_WIDTH - 1 downto 0);
      wclk : in std_logic;
      wdata : in std_logic_vector(DATA_WIDTH - 1 downto 0);
      wr : in std_logic
    );
  end component;

begin

  captured_window_count <= captured_window_count_int;													 
  shift_out_data <= shift_reg(0);
  internal_trigger <= trigger or immediate;
  rd <= '1';
  wr_window_count_bintck(ADDR_WIDTH-1) <= wr_window_count_gray_tckreg(ADDR_WIDTH-1);  
  ready_to_capture <= ready_to_capture_int;
  ---- trigger condition met, when trigger input and capture valid is high
  trigcond_met    <= '1' when (internal_trigger = '1' and capture_valid = '1')  else '0';
  ---- write address equal to window_size
  waddr_eq_windsz <= '1' when (waddr = window_size)  else '0';

  s1: hdlverifier_synchronizer
    generic map(WIDTH => 1)
    port map (
      clk => tck,
      data_in(0) => reg_full,
      data_out(0) => flag_full
    );
  s2: hdlverifier_synchronizer
    generic map(WIDTH => 1)
    port map (
      clk => tck,
      data_in(0) => reg_clk,
      data_out(0) => has_clk
    );  
  
  u_dcram: hdlverifier_dcram
    GENERIC map(
      DATA_WIDTH => DATA_WIDTH,
      ADDR_WIDTH => ADDR_WIDTH)
    port map (
      q => q,
      raddr => raddr,
      rclk => tck,
      rd => rd,
      waddr => ram_waddr,
      wclk => clk,
      wdata => data_wtrigger_info,
      wr => wr_d1
    );
  
  
  ---- write enable
  process (state_reg, clk_enable) is
  begin
    if (state_reg = X"1") and (clk_enable = '1') then
        wr <= '1';
    else
        if (state_reg = X"2") and (clk_enable = '1') then
            wr <= '1';
        else
            wr <= '0';
        end if;
    end if;
  end process;

  ---- required for pipelining write
  process (clk) is
  begin
    if rising_edge(clk) then            
      if reset = '1' then
	    wr_d1 <= '0';
	  elsif clk_enable = '1' then
	    wr_d1 <= wr;
      else
	    wr_d1 <= '0';
	  end if;
	end if;	  
  end process;
  
  
  process (clk, reset) is
    begin
        if reset = '1' then
            reg_full <= '0';
            reg_clk  <= '0';
        elsif rising_edge(clk) then            
            if state_reg = X"3" then
                reg_full <= '1';
            else
                reg_full <= '0';
            end if;
            reg_clk <= '1';
        end if;
  end process;
  
  ---- For user to indicate whether trigger conditions being met or not
  ---- window count information to user about captured  window
    process (clk) is
  begin
    if rising_edge(clk) then
	  if (reset = '1' or run = '0') then
	    wr_window_count_by1 <= conv_std_logic_vector(0,ADDR_WIDTH);
	  elsif clk_enable = '1' then
        if (trigcond_met = '1' and (state_reg = X"1")) then
		  if trigpos_eq_depth = '1' then
			wr_window_count_by1 <= wr_window_count_by1 + '1';
		  end if;
	    elsif state_reg = X"2" then
		  if pos_counter = windsze_ms_trig_pos then
		    wr_window_count_by1 <= wr_window_count_by1 + '1';
		  end if;
	    end if;
	  else
	    wr_window_count_by1 <= wr_window_count_by1;
	  end if;
	end if;
  end process;

  ---- Binary to Gray
  process (clk) is
  begin
    if rising_edge(clk) then
	    wr_window_count_gray(ADDR_WIDTH-1 downto 0) <= ((to_stdlogicvector(to_bitvector(wr_window_count_by1) srl  conv_integer(1))) xor  wr_window_count_by1(ADDR_WIDTH-1 downto 0)); --conv_integer(number_of_windows)
	end if;
  end process;
  
  ---- clock domain crossing
  s3: hdlverifier_synchronizer
    generic map(WIDTH => ADDR_WIDTH)
    port map (
      clk => tck,
      data_in => wr_window_count_gray,
      data_out => wr_window_count_gray_tckreg
    );

  ---- Gray to Binary
  GRAY2BIN: for i IN (ADDR_WIDTH-2) downto 0 generate
    wr_window_count_bintck(i) <= wr_window_count_bintck(i+1) xor wr_window_count_gray_tckreg(i);
  end generate GRAY2BIN;
  
  process (tck) is
  begin
    if rising_edge(tck) then
	  captured_window_count_int(ADDR_WIDTH-1 downto 0) <= wr_window_count_bintck(ADDR_WIDTH-1 downto 0);
    end if;
  end process;
  

  ---- window size based on memory capture depth and number_of_windows
  ---- #1 latency
  process (clk) is
  begin
    if rising_edge(clk) then
      DEPTH <= std_logic_vector(to_unsigned(DEPTH_I, DEPTH'length));
    end if;
  end process;
    
  process (clk) is
  begin
    if rising_edge(clk) then
      DEPTH_MS1 <= DEPTH - 1;
    end if;
  end process;
    
  process (clk) is
  begin
    if rising_edge(clk) then
      DEPTH_MS2 <= DEPTH - 2;
    end if;
  end process;
    
  process (clk) is
  begin
    if rising_edge(clk) then
      window_size_i <= (to_stdlogicvector(to_bitvector(DEPTH) srl conv_integer(number_of_windows))) - '1';
    end if;
  end process;

  process (clk) is
  begin
    if rising_edge(clk) then
      window_size <= window_size_i(ADDR_WIDTH-1 downto 0);
    end if;
  end process;

  ---- window_size depth plus 1 at design clock
  ---- #2 latency
  process (clk) is
  begin
    if rising_edge(clk) then
      window_size_plus1 <= ('0' & window_size) + '1';
    end if;
  end process;

  ---- trigger position equal to window size
  ---- #1 latency
  process (clk) is
  begin
    if rising_edge(clk) then
      if (trigger_pos = window_size) then
	    trigpos_eq_depth <= '1';
	  else
	    trigpos_eq_depth <= '0';
	  end if;	  
    end if;
  end process;

  ---- trigger position equal to zero
  ---- #1 latency
  process (clk) is
  begin
    if rising_edge(clk) then
      if (trigger_pos = conv_std_logic_vector(0, ADDR_WIDTH)) then
	    trigpos_eq_zero <= '1';
	  else
	    trigpos_eq_zero <= '0';
	  end if;	  
    end if;
  end process;

  ---- trigger position not equal to zero
  ---- #1 latency
  process (clk) is
  begin
    if rising_edge(clk) then
      if (trigger_pos /= conv_std_logic_vector(0, ADDR_WIDTH)) then
	    trigpos_nteq_zero <= '1';
	  else
	    trigpos_nteq_zero <= '0';
	  end if;	  
    end if;
  end process;
  
  ---- trigger position minus 1
  ---- #1 latency
  process (clk) is
  begin
    if rising_edge(clk) then
	    trigpos_ms1 <= (trigger_pos - conv_std_logic_vector(1, ADDR_WIDTH));
    end if;
  end process;

  ---- window size minus trigger position
  ---- #1 latency
  process (clk) is
  begin
    if rising_edge(clk) then
      windsze_ms_trig_pos <= (window_size - trigger_pos) - '1';
    end if;
  end process;

  ---- memory depth minus window size
  ---- #1 latency
  process (clk) is
  begin
    if rising_edge(clk) then
      memory_depth_ms_windsz <= ((DEPTH) - window_size_plus1);
    end if;
  end process;

  ---- capture valid goes high when pre counter reaches or equal to trigger position
  ---- Will go HIGH if trigger position is zero and when run is HIHG to capture each clock cycle 
  ---- Goes LOW when trigger condition met and trigger position is not zero, not making LOW when triggerposition is zero to capture the every trigger
  process (clk) is
  begin
  if rising_edge(clk) then
	if (reset = '1') then
      capture_valid <= '0';
	elsif ((trigcond_met = '1') and (trigpos_nteq_zero = '1')) then
	  capture_valid <= '0';
	elsif (((not run_d1) = '1') and (run = '1') and (trigpos_eq_zero = '1')) then
	  capture_valid <= '1';
	elsif (state_reg = X"0") then
	  capture_valid <= '0';
	elsif ((clk_enable = '1') and (pre_counter >= (trigpos_ms1)) and (state_reg = X"1")) then
	  capture_valid <= '1';
	else
	  capture_valid <= capture_valid;
   end if;
  end if;
  end process;

  
  ---- FSM - state machine to capture data
  ---- when state is 'STATE_CAPTURE_PRE' and 'STATE_CAPTURE_POS' the data is written to memory.
  ---- if number of windows greater than '1' then the memory is break down based on it.
  ---- storing write address for each window, required when reading the captured data
  process (clk, reset) is
  begin
    if rising_edge(clk) then
        if reset = '1' then
            state_reg <= X"0";
            run_d1 <= '0';
            pos_counter <= conv_std_logic_vector(0, ADDR_WIDTH);
            pre_counter <= conv_std_logic_vector(0, ADDR_WIDTH);
            waddr <= conv_std_logic_vector(0,ADDR_WIDTH);
								   
        else        
            case state_reg is
            when X"0" =>
              waddr <= conv_std_logic_vector(0,ADDR_WIDTH);
              run_d1 <= run;
              pos_counter <= conv_std_logic_vector(0, ADDR_WIDTH);
              pre_counter <= conv_std_logic_vector(0, ADDR_WIDTH);
							
              
			  if ((not run_d1) = '1') and (run = '1') then
                state_reg <= X"1";
              end if;
			  
            ---- capturing data till trigger position, when trigger met 
            when X"1" =>
              if clk_enable = '1' then
                ---- write address loop to zero when window depth reached                
				if waddr_eq_windsz = '1' then
			      waddr <= conv_std_logic_vector(0,ADDR_WIDTH);
			    else
			      waddr <= waddr + '1';
			    end if;
				
				---- pre counter
				if (trigcond_met = '1' and trigpos_eq_depth = '1') then
				  pre_counter <= conv_std_logic_vector(0, ADDR_WIDTH);
				else 
                  pre_counter <= pre_counter + '1';
				end if;
                				
                ---- trigger condition met, when trigger input and capture valid is high
                ---- based on the trigger position and capture depth and number of windows state machine control moves 
                if trigcond_met = '1' then
				  if (trigger_pos /= window_size) then
				    state_reg <= X"2";
				  elsif (trigpos_eq_depth = '1') and (wr_window_count(ADDR_WIDTH-1 downto 0) = memory_depth_ms_windsz(ADDR_WIDTH-1 downto 0)) then
                    state_reg <= X"3";
                  elsif trigpos_eq_depth = '1' then
                    state_reg <= X"1";
			      else
                    state_reg <= X"1";				  
                  end if;
				end if;
				
              end if;
            ---- capture data after trigger and trigger position
            when X"2" =>
              if clk_enable = '1' then
                ---- initilize to zero
                pre_counter <= conv_std_logic_vector(0, ADDR_WIDTH);
				
                ---- write address loop to zero when window depth reached
				if waddr_eq_windsz = '1' then
			      waddr <= conv_std_logic_vector(0,ADDR_WIDTH);
			    else
			      waddr <= waddr + '1';
			    end if;

                if ((pos_counter = windsze_ms_trig_pos) and (wr_window_count(ADDR_WIDTH-1 downto 0) = memory_depth_ms_windsz(ADDR_WIDTH-1 downto 0))) then
				  state_reg   <= X"3";
				  pos_counter <= conv_std_logic_vector(0,ADDR_WIDTH);				
				elsif pos_counter = windsze_ms_trig_pos then
                  state_reg   <= X"1";
				  pos_counter <= conv_std_logic_vector(0,ADDR_WIDTH);				
                else
				  state_reg   <= X"2";
                  pos_counter <= pos_counter + '1';
                end if;
              end if;
            when X"3" =>
              if (not run) = '1' then
                state_reg <= X"0";
              end if;
            when others =>
              state_reg <= X"0";
          end case;
       end if;
    end if;
  end process;
  
  ---- write window count
  process (clk) is
  begin
    if rising_edge(clk) then
	  if (reset = '1' or state_reg = X"0") then
	    wr_window_count <= conv_std_logic_vector(0,ADDR_WIDTH+1);
	  elsif clk_enable = '1' then
        if (trigcond_met = '1' and (state_reg = X"1")) then
		  if trigpos_eq_depth = '1' then
			wr_window_count <= wr_window_count + window_size_plus1;
		  end if;
	    elsif state_reg = X"2" then
		  if pos_counter = windsze_ms_trig_pos then
		    wr_window_count <= wr_window_count + window_size_plus1;
		  end if;
	    end if;
	  else
	    wr_window_count <= wr_window_count;
	  end if;
	end if;
  end process;
   
  
  ---- transferring captured data to JTAG 
  process (tck, reset) is
  begin
    if reset = '1' then
      bitcount <= X"0000";
      shift_reg <= conv_std_logic_vector(0, DATA_WIDTH);
    elsif rising_edge(tck) then
      if shift_out_state = '0' then
        raddr <= conv_std_logic_vector(0, ADDR_WIDTH);
        bitcount <= X"0000";
        shift_reg <= conv_std_logic_vector(0,DATA_WIDTH);
      else
        if shift_out_en = '1' then
          if bitcount = X"0000" then
            shift_reg <= '0' & shift_reg(DATA_WIDTH-1 downto 1);
            bitcount <= bitcount + '1';
          else
            if bitcount = X"0001" then
              bitcount <= bitcount + '1';
              shift_reg <= q;
            else
              if bitcount = conv_std_logic_vector(DATA_WIDTH-1, 16) then
                bitcount <= X"0000";
                raddr <= raddr + '1';
                shift_reg <= '0' & shift_reg(DATA_WIDTH-1 downto 1);
              else
                bitcount <= bitcount + '1';
                shift_reg <= '0' & shift_reg(DATA_WIDTH-1 downto 1);
              end if;
            end if;
          end if;
        end if;
      end if;
    end if;
  end process;


  ---- #1 latency
  process (clk) is
  begin
    if rising_edge(clk) then
	  ram_waddr <= wr_window_count(ADDR_WIDTH-1 downto 0) + waddr;
    end if;	  
  end process;
  
   ---- #1 latency
  process (clk, reset) is
  begin
    if reset = '1' then
	  trigcond_met_d1 <= '0';
	elsif rising_edge(clk) then
	  trigcond_met_d1 <= trigcond_met;
    end if;	  
  end process;
  
  ---- combi logic to send the trigger info only once if the trigger met is more than one clock cycle
  process (state_reg, trigcond_met, trigcond_met_d1, trigger_pos, trigpos_eq_zero) is
  begin
    if ((state_reg = X"1") and (trigcond_met = '1')) then
	  if (trigpos_eq_zero = '1') then
	    trigger_bitinfo <= '1';
	  elsif (trigcond_met_d1 = '0') then
	    trigger_bitinfo <= '1';
	  else
	    trigger_bitinfo <= '0';
	  end if;
	else
	  trigger_bitinfo <= '0';
    end if;	  
  end process;
  
  ---- data with trigger condition met information, 1 bit at msb indicates trigger condition met and include pad zeros if data width not in bytes range rest is the data 
  ---- #1 latency
  process (clk) is
  begin
    if rising_edge(clk) then
	  data_wtrigger_info <= trigger_bitinfo & data(DATA_WIDTH-2 downto 0);
    end if;	  
  end process;

---- when Matlab armed i.e run is high and clock enable and trigger high then it goes HIGH else if Flag is full then it goes LOW
---- indicating user design that data capture ip is ready to capture data
  process (clk) is
  begin
    if rising_edge(clk) then
	  if (reset = '1' or state_reg = X"0") then
	    ready_to_capture_int <= '0';
	  elsif (clk_enable = '1') then
	    if (waddr = DEPTH_MS2) then
		  ready_to_capture_int <= '0';
		elsif (waddr = DEPTH_MS1) then
		  ready_to_capture_int <= '0';
		end if;	  
	  elsif (waddr = DEPTH_MS1) then
	    ready_to_capture_int <= not ready_to_capture_int;
	  elsif (state_reg = X"3") then
	    ready_to_capture_int <= '0';
	  elsif ((run = '1') and ((trigger = '1') or (immediate = '1'))) then
	    ready_to_capture_int <= '1';
      else
	    ready_to_capture_int <= ready_to_capture_int;  
	  end if;
    end if;	  
  end process;
end architecture;
