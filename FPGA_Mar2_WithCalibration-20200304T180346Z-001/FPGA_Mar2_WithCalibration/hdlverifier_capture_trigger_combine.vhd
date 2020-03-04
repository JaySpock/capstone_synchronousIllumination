
-- ----------------------------------------------
-- File Name: hdlverifier_capture_trigger_combine.vhd
-- Created:   02-Mar-2020 21:45:57
-- Copyright  2020 MathWorks, Inc.
-- ----------------------------------------------




library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hdlverifier_capture_trigger_combine is
  generic(WIDTH:integer);
  port (
    clk : in std_logic;
    clk_enable : in std_logic;
    trigger_combination_rule : in std_logic;
    trigger_in : in std_logic_vector(WIDTH - 1 downto 0);
    trigger_enable : in std_logic_vector(WIDTH - 1 downto 0);
    trigger_out : out std_logic
  );
end entity; 



architecture rtl of hdlverifier_capture_trigger_combine is
  function Reduce_OR(X : std_logic_vector) return std_logic is
    variable R : std_logic := '0';
  begin
    for i in X'Range loop
      R := X(i) or R;
    end loop;
    return R;
  end function;
  
  function Reduce_AND(X : std_logic_vector) return std_logic is
    variable R : std_logic := '1';
  begin
    for i in X'Range loop
      R := X(i) and R;
    end loop;
    return R;
  end function;
begin
  
  process (clk) is
  begin
    if rising_edge(clk) then
      if clk_enable = '1' then
        if trigger_combination_rule = '1' then
          trigger_out <= Reduce_OR( trigger_in and trigger_enable ) or Reduce_AND(not trigger_enable);
        else
          trigger_out <= Reduce_AND( trigger_in or (not trigger_enable));
        end if;
      end if;
    end if;
  end process;
end architecture;
