
-- ----------------------------------------------
-- File Name: hdlverifier_capture_comparator.vhd
-- Created:   02-Mar-2020 21:45:57
-- Copyright  2020 MathWorks, Inc.
-- ----------------------------------------------




library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity hdlverifier_capture_comparator is
  generic(WIDTH:integer);
  port (
    clk : in std_logic;
    clk_enable : in std_logic;
    data : in std_logic_vector(WIDTH-1 downto 0);
    trigger : out std_logic;
    trigger_setting : in std_logic_vector(WIDTH-1 downto 0)
  );
end entity; 



architecture rtl of hdlverifier_capture_comparator is
begin
  
  process (clk) is
  begin
    if rising_edge(clk) then
      if clk_enable = '1' then
        if data = trigger_setting then
            trigger <= '1';
        else
            trigger <= '0';
        end if;
      end if;
    end if;
  end process;
end architecture;
