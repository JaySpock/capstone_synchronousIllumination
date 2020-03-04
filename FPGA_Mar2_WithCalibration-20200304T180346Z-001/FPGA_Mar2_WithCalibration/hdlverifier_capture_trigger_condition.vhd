
-- ----------------------------------------------
-- File Name: hdlverifier_capture_trigger_condition.vhd
-- Created:   02-Mar-2020 21:45:57
-- Copyright  2020 MathWorks, Inc.
-- ----------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.ALL;


ENTITY hdlverifier_capture_trigger_condition IS 
PORT (
      clk                             : IN  std_logic;
      clk_enable                      : IN  std_logic;
      trigger_setting                 : IN  std_logic_vector(14 DOWNTO 0);
      New_Frame                       : IN  std_logic;
      Data_out                        : IN  std_logic_vector(4 DOWNTO 0);
      Calibration                     : IN  std_logic;
      trigger                         : OUT std_logic
);
END hdlverifier_capture_trigger_condition;

ARCHITECTURE rtl of hdlverifier_capture_trigger_condition IS

COMPONENT hdlverifier_capture_comparator IS 
GENERIC (WIDTH: integer := 8
);
PORT (
      clk                             : IN  std_logic;
      clk_enable                      : IN  std_logic;
      data                            : IN  std_logic_vector(WIDTH - 1 DOWNTO 0);
      trigger_setting                 : IN  std_logic_vector(WIDTH - 1 DOWNTO 0);
      trigger                         : OUT std_logic
);
END COMPONENT;

COMPONENT hdlverifier_capture_comparator_1bit IS 
PORT (
      clk                             : IN  std_logic;
      clk_enable                      : IN  std_logic;
      data                            : IN  std_logic;
      trigger_mode                    : IN  std_logic_vector(2 DOWNTO 0);
      trigger                         : OUT std_logic
);
END COMPONENT;

COMPONENT hdlverifier_capture_trigger_combine IS 
GENERIC (WIDTH: integer := 8
);
PORT (
      clk                             : IN  std_logic;
      clk_enable                      : IN  std_logic;
      trigger_in                      : IN  std_logic_vector(WIDTH - 1 DOWNTO 0);
      trigger_enable                  : IN  std_logic_vector(WIDTH - 1 DOWNTO 0);
      trigger_combination_rule        : IN  std_logic;
      trigger_out                     : OUT std_logic
);
END COMPONENT;

  SIGNAL trigger_stage1                   : std_logic_vector(2 DOWNTO 0); -- std3
  SIGNAL trigger_enable                   : std_logic_vector(2 DOWNTO 0); -- std3
  SIGNAL trigger_out1                     : std_logic; -- boolean
  SIGNAL trigger_setting1                 : std_logic_vector(4 DOWNTO 0); -- std5
  SIGNAL trigger_out2                     : std_logic; -- boolean
  SIGNAL trigger_setting2                 : std_logic_vector(2 DOWNTO 0); -- std3
  SIGNAL trigger_out3                     : std_logic; -- boolean
  SIGNAL trigger_setting3                 : std_logic_vector(2 DOWNTO 0); -- std3
  SIGNAL trigger_combine_rule             : std_logic; -- boolean

BEGIN

u_hdlverifier_capture_comparator: hdlverifier_capture_comparator 
GENERIC MAP (WIDTH => 5
)
PORT MAP(
        clk                  => clk,
        clk_enable           => clk_enable,
        data                 => Data_out,
        trigger              => trigger_out1,
        trigger_setting      => trigger_setting1
);

u_hdlverifier_capture_comparator_1bit: hdlverifier_capture_comparator_1bit 
PORT MAP(
        clk                  => clk,
        clk_enable           => clk_enable,
        data                 => Calibration,
        trigger              => trigger_out2,
        trigger_mode         => trigger_setting2
);

u_hdlverifier_capture_comparator_1bit_inst1: hdlverifier_capture_comparator_1bit 
PORT MAP(
        clk                  => clk,
        clk_enable           => clk_enable,
        data                 => New_Frame,
        trigger              => trigger_out3,
        trigger_mode         => trigger_setting3
);

u_hdlverifier_capture_trigger_combine: hdlverifier_capture_trigger_combine 
GENERIC MAP (WIDTH => 3
)
PORT MAP(
        clk                  => clk,
        clk_enable           => clk_enable,
        trigger_in           => trigger_stage1,
        trigger_enable       => trigger_enable,
        trigger_out          => trigger,
        trigger_combination_rule => trigger_combine_rule
);

trigger_stage1 <= trigger_out1 & trigger_out2 & trigger_out3;
trigger_enable <= trigger_setting(13 DOWNTO 11);
trigger_setting1 <= trigger_setting(4 DOWNTO 0);
trigger_setting2 <= trigger_setting(7 DOWNTO 5);
trigger_setting3 <= trigger_setting(10 DOWNTO 8);
trigger_combine_rule <= trigger_setting(14);

END;
