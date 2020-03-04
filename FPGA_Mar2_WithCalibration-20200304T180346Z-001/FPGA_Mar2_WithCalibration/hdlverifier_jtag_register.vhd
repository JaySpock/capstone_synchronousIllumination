
-- ----------------------------------------------
-- File Name: hdlverifier_jtag_register.vhd
-- Created:   02-Mar-2020 21:45:57
-- Copyright  2020 MathWorks, Inc.
-- ----------------------------------------------



library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity hdlverifier_jtag_register is
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
end entity; 


architecture rtl of hdlverifier_jtag_register is
  signal rdata_Reg : std_logic_vector(31 downto 0);
  type read_data_Type is array (3 downto 0) of std_logic_vector(31 downto 0);
  signal read_data : read_data_Type;  
  type write_data_Type is array (3 downto 0) of std_logic_vector(31 downto 0);
  signal write_data : write_data_Type;  
  
  component hdlverifier_synchronizer is
    generic(WIDTH:integer:=1);
    port (
      clk : in std_logic;
      data_in : in std_logic_vector(31 downto 0);
      data_out : out std_logic_vector(31 downto 0)
    );
  end component;
  signal data_out_Readable : std_logic_vector(31 downto 0);  
begin
  rdata <= rdata_Reg;
  user_data_out0 <= data_out_Readable;
  user_data_out0_tck <= write_data(0);
  
  
  s0: hdlverifier_synchronizer
    generic map(WIDTH=>32)
    port map (
      clk => clk,
      data_in => write_data(0),
      data_out => data_out_Readable
    );
  
  
  s1: hdlverifier_synchronizer
    generic map(WIDTH=>32)
    port map (
      clk => clk,
      data_in => write_data(1),
      data_out => user_data_out1
    );
  
  
  s2: hdlverifier_synchronizer
    generic map(WIDTH=>32)
    port map (
      clk => clk,
      data_in => write_data(2),
      data_out => user_data_out2
    );
  
  
  s3: hdlverifier_synchronizer
    generic map(WIDTH=>32)
    port map (
      clk => clk,
      data_in => write_data(3),
      data_out => user_data_out3
    );
  
  
  t0: hdlverifier_synchronizer
    generic map(WIDTH=>32)
    port map (
      clk => tck,
      data_in => user_data_in0,
      data_out => read_data(0)
    );
  
  
  t1: hdlverifier_synchronizer
    generic map(WIDTH=>32)
    port map (
      clk => tck,
      data_in => user_data_in1,
      data_out => read_data(1)
    );
  
  
  t2: hdlverifier_synchronizer
  generic map(WIDTH=>32)
    port map (
      clk => tck,
      data_in => user_data_in2,
      data_out => read_data(2)
    );
  
  
  t3: hdlverifier_synchronizer
  generic map(WIDTH=>32)
    port map (
      clk => tck,
      data_in => user_data_in3,
      data_out => read_data(3)
    );
  
  
  process (tck) is
  begin
    if rising_edge(tck) then
      if reset = '1' then
        write_data(0) <= X"00000000";
        write_data(1) <= X"00000000";
        write_data(2) <= X"00000000";
        write_data(3) <= X"00000000";
      else
        if write = '1' then
          case addr(0 + 1 downto 0) is
            when "00" =>
              write_data(0) <= wdata;
            when "01" =>
              write_data(1) <= wdata;
            when "10" =>
              write_data(2) <= wdata;
            when "11" =>
              write_data(3) <= wdata;
            when others =>
              write_data(0) <= wdata;
          end case;
        end if;
      end if;
    end if;
  end process;
  
  
  process (tck) is
  begin
    if rising_edge(tck) then
      case addr(0 + 1 downto 0) is
        when "00" =>
          rdata_Reg <= read_data(0);
        when "01" =>
          rdata_Reg <= read_data(1);
        when "10" =>
          rdata_Reg <= read_data(2);
        when "11" =>
          rdata_Reg <= read_data(3);
        when others =>
          rdata_Reg <= read_data(0);
      end case;
    end if;
  end process;
end architecture;
