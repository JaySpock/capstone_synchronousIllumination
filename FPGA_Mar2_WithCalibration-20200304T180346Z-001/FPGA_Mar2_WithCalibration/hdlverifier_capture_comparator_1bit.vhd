
-- ----------------------------------------------
-- File Name: hdlverifier_capture_comparator_1bit.vhd
-- Created:   02-Mar-2020 21:45:57
-- Copyright  2020 MathWorks, Inc.
-- ----------------------------------------------




library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity hdlverifier_capture_comparator_1bit is
  port (
    clk : in std_logic;
    clk_enable : in std_logic;
    data : in std_logic;
    trigger : out std_logic;
    trigger_enabled : in std_logic;
    trigger_mode : in std_logic_vector(2 downto 0)
  );
end entity; 


architecture rtl of hdlverifier_capture_comparator_1bit is
  signal trigger_Reg : std_logic;
  signal data_d1 : std_logic;  
  signal trigger_condition : std_logic;  
begin
  
  trigger <= trigger_Reg;
  
  process (trigger_mode, data, data_d1) is
  begin
    if (trigger_mode = "000") and ((not data) = '1') then
        trigger_condition <= '1';
    elsif (trigger_mode = "001") and (data = '1') then
        trigger_condition <= '1';
    elsif ((trigger_mode = "010") and ((not data_d1) = '1')) and (data = '1') then
        trigger_condition <= '1';
    elsif ((trigger_mode = "011") and (data_d1 = '1')) and ((not data) = '1') then
        trigger_condition <= '1';
    elsif (trigger_mode = "100") and ((data_d1 xor data) = '1') then
        trigger_condition <= '1';
    else
        trigger_condition <= '0';
    end if;
  end process;
  
  
  process (clk) is
  begin
    if rising_edge(clk) then
        if clk_enable = '1' then
            data_d1 <= data;
            trigger_Reg <= trigger_condition;
        end if;
    end if;
  end process;
end architecture;
