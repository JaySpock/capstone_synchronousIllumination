
-- ----------------------------------------------
-- File Name: hdlverifier_capture_core.vhd
-- Created:   02-Mar-2020 21:45:57
-- Copyright  2020 MathWorks, Inc.
-- ----------------------------------------------




library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_arith.all;

entity hdlverifier_capture_core is
  generic(
    DATA_WIDTH: integer;
    ADDR_WIDTH: integer;
    TRIG_WIDTH: integer;
    JTAG_ID: integer);
  port (
    clk : in std_logic;
    clk_enable : in std_logic;
    data : in std_logic_vector(DATA_WIDTH - 1 downto 0);
    start : out std_logic;
	ready_to_capture : out std_logic;
    trigger : in std_logic;
    trigger_setting : out std_logic_vector(TRIG_WIDTH - 1 downto 0)
  );
end entity; 


architecture rtl of hdlverifier_capture_core is
  signal data_d1 : std_logic_vector(DATA_WIDTH - 1 downto 0);  
  signal data_d2 : std_logic_vector(DATA_WIDTH - 1 downto 0);  
  signal capture_data : std_logic_vector(DATA_WIDTH - 1 downto 0);  
  signal flag_full : std_logic;  
  signal has_clk   : std_logic;  
  signal reg_addr  : std_logic_vector(4 downto 0);  
  signal reg_rdata : std_logic_vector(31 downto 0);  
  signal reg_wdata : std_logic_vector(31 downto 0);  
  signal reg_write : std_logic;  
  signal reset_clk : std_logic;  
  signal reset_reg : std_logic;  
  signal reset_tck : std_logic;  
  signal shift_in_data : std_logic;  
  signal shift_in_en : std_logic;  
  signal shift_in_state : std_logic;  
  signal shift_out_data : std_logic;  
  signal shift_out_en : std_logic;  
  signal shift_out_state : std_logic;  
  signal status_register : std_logic_vector(31 downto 0);  
  signal tck : std_logic;  
  signal trig_shift_counter : std_logic_vector(19 downto 0);  
  signal trigger_pos : std_logic_vector(ADDR_WIDTH - 1 downto 0);  
  signal trigger_shifter : std_logic_vector(TRIG_WIDTH - 1 downto 0);  
  signal user_data_out0_tck : std_logic_vector(31 downto 0);  
  signal user_data_out0 : std_logic_vector(31 downto 0);  
  signal user_data_out1 : std_logic_vector(31 downto 0);  
  signal user_data_out2 : std_logic_vector(31 downto 0);  
  signal user_data_out3 : std_logic_vector(31 downto 0);  
  signal captured_window_count : std_logic_vector(ADDR_WIDTH - 1 downto 0);  
  signal number_of_windows : std_logic_vector(ADDR_WIDTH - 1 downto 0);  
  
  component hdlverifier_jtag_register is
   port (
      addr : in std_logic_vector(4 downto 0);
      clk : in std_logic;
      rdata : out std_logic_vector(31 downto 0);
      reset : in std_logic;
      tck : in std_logic;
      user_data_in0 : in std_logic_vector(31 downto 0);
      user_data_in1 : in std_logic_vector(31 downto 0);
      user_data_in2 : in std_logic_vector(31 downto 0);
      user_data_in3 : in std_logic_vector(31 downto 0);
      user_data_out0_tck : out std_logic_vector(31 downto 0);
      user_data_out0 : out std_logic_vector(31 downto 0);
      user_data_out1 : out std_logic_vector(31 downto 0);
      user_data_out2 : out std_logic_vector(31 downto 0);
      user_data_out3 : out std_logic_vector(31 downto 0);
      wdata : in std_logic_vector(31 downto 0);
      write : in std_logic
    );
  end component;
  

  component hdlverifier_capture_data is
   GENERIC(
      DATA_WIDTH:integer;
      ADDR_WIDTH:integer);
   port (
      clk : in std_logic;
      clk_enable : in std_logic;
      data : in std_logic_vector(DATA_WIDTH - 1 downto 0);
      flag_full : out std_logic;
      reset : in std_logic;
      run : in std_logic;
      run_tck : in std_logic;
      immediate : in std_logic;
      has_clk : out std_logic;
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
  end component;
  
  component hdlverifier_capture_jtag_core is
    generic(JTAG_ID: natural);
    port (
      reg_addr : out std_logic_vector(4 downto 0);
      reg_rdata : in std_logic_vector(31 downto 0);
      reg_wdata : out std_logic_vector(31 downto 0);
      reg_write : out std_logic;
      reset : out std_logic;
      shift_in_data : out std_logic;
      shift_in_en : out std_logic;
      shift_in_state : out std_logic;
      shift_out_data : in std_logic;
      shift_out_en : out std_logic;
      shift_out_state : out std_logic;
      tck : out std_logic
    );
  end component;
  
  component hdlverifier_synchronizer is
    generic(WIDTH:integer);
    port (
      clk : in std_logic;
      data_in : in std_logic_vector(WIDTH - 1 downto 0);
      data_out : out std_logic_vector(WIDTH - 1 downto 0)
    );
  end component;
  
  constant MAJOR_VER: std_logic_vector(7 downto 0) := X"01";
  constant MINOR_VER: std_logic_vector(3 downto 0) := X"1";
  constant APP_TYPE : std_logic_vector(3 downto 0)  := X"0";
  constant ADDR_WPOW: std_logic_vector(4 downto 0)  := conv_std_logic_vector(ADDR_WIDTH,5);
  constant DATA_WIDTH_BYTE: std_logic_vector(10 downto 0)  := conv_std_logic_vector(DATA_WIDTH/8,11);
  
  
  signal CAPTURE_IP_ID0 : std_logic_vector(31 downto 0); 

begin
  status_register(31 downto ADDR_WIDTH+2) <= conv_std_logic_vector(0,(32-(ADDR_WIDTH+2)));
  status_register(1) <= has_clk;
  status_register(0) <= flag_full;
  status_register(ADDR_WIDTH+1 downto 2) <= captured_window_count;
  start <= user_data_out0(0);
  trigger_pos <= user_data_out0(ADDR_WIDTH+3 downto 4);
  number_of_windows <= user_data_out1(ADDR_WIDTH - 1 downto 0);
  capture_data <= data when (user_data_out0(1) = '1') else data_d2;

  CAPTURE_IP_ID0 <= DATA_WIDTH_BYTE & ADDR_WPOW & APP_TYPE & MAJOR_VER & MINOR_VER;
  register_manager: hdlverifier_jtag_register
    port map (
      addr => reg_addr,
      clk => clk,
      rdata => reg_rdata,
      reset => reset_tck,
      tck => tck,
      user_data_in0 =>  CAPTURE_IP_ID0 ,
      user_data_in1 => X"00000200",
      user_data_in2 => status_register,
      user_data_in3 => X"0000f00f",
      user_data_out0_tck => user_data_out0_tck,
      user_data_out0 => user_data_out0,
      user_data_out1 => user_data_out1,
      user_data_out2 => user_data_out2,
      user_data_out3 => user_data_out3,
      wdata => reg_wdata,
      write => reg_write
    );
  
  
  sync_trigger: hdlverifier_synchronizer
    generic map(WIDTH => TRIG_WIDTH)
    port map (
      clk => clk,
      data_in => trigger_shifter,
      data_out => trigger_setting
    );
  
  
  u_capture: hdlverifier_capture_data
   GENERIC map(
      DATA_WIDTH => DATA_WIDTH,
      ADDR_WIDTH => ADDR_WIDTH)
    port map (
      clk => clk,
      clk_enable => clk_enable,
      data => capture_data,
      flag_full => flag_full,
      reset => reset_clk,
      run => user_data_out0(0),
      run_tck => user_data_out0_tck(0),
      immediate => user_data_out0(1),
      has_clk => has_clk,
      shift_out_data => shift_out_data,
      shift_out_en => shift_out_en,
      shift_out_state => shift_out_state,
      tck => tck,
      trigger => trigger,
      trigger_pos => trigger_pos,
	  ready_to_capture => ready_to_capture,
      captured_window_count => captured_window_count,
	  number_of_windows => number_of_windows
    );
  
  
  u_jtag_core: hdlverifier_capture_jtag_core
    generic map(
        JTAG_ID=>JTAG_ID
    )
    port map (
      reg_addr => reg_addr,
      reg_rdata => reg_rdata,
      reg_wdata => reg_wdata,
      reg_write => reg_write,
      reset => reset_tck,
      shift_in_data => shift_in_data,
      shift_in_en => shift_in_en,
      shift_in_state => shift_in_state,
      shift_out_data => shift_out_data,
      shift_out_en => shift_out_en,
      shift_out_state => shift_out_state,
      tck => tck
    );
  
  
-- one synchroniser is fine for domain crossing
--  u_sync_trig_pos: hdlverifier_synchronizer
--    generic map(WIDTH => ADDR_WIDTH)
--    port map (
--      clk => clk,
--      data_in => user_data_out0(ADDR_WIDTH+3 downto 4),
--      data_out => trigger_pos
--    );
  
  
  process (tck) is
  begin
    if rising_edge(tck) then
      if shift_in_state = '0' then
        trig_shift_counter <= X"00000";
      end if;
      if ((shift_in_state = '1') and (shift_in_en = '1')) and trig_shift_counter < conv_std_logic_vector(TRIG_WIDTH,20) then
        trigger_shifter <= trigger_shifter(TRIG_WIDTH-2 downto 0) & shift_in_data;
        trig_shift_counter <= trig_shift_counter + '1';
      end if;
    end if;
  end process;
  
  
  process (clk, reset_tck) is
  begin
    if reset_tck = '1' then
      reset_reg <= '1';
      reset_clk <= '1';
    elsif rising_edge(clk) then
      reset_reg <= '0';
      reset_clk <= reset_reg;
    end if;
  end process;
  
  
  process (clk) is
  begin
    if rising_edge(clk) then
      if clk_enable = '1' then
        data_d1 <= data;
        data_d2 <= data_d1;
      end if;
    end if;
  end process;
end architecture;
