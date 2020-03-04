
-- ----------------------------------------------
-- File Name: datacapture.vhd
-- Created:   02-Mar-2020 21:45:57
-- Copyright  2020 MathWorks, Inc.
-- ----------------------------------------------

LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.numeric_std.ALL;


ENTITY datacapture IS 
PORT (
      clk                             : IN  std_logic;
      clk_enable                      : IN  std_logic;
      New_Frame                       : IN  std_logic;
      Data_out                        : IN  std_logic_vector(4 DOWNTO 0);
      Calibration                     : IN  std_logic;
      ready_to_capture                : OUT std_logic
);
END datacapture;

ARCHITECTURE rtl of datacapture IS

COMPONENT hdlverifier_capture_core IS 
GENERIC (DATA_WIDTH: integer := 8;
ADDR_WIDTH: integer := 7;
TRIG_WIDTH: integer := 9;
JTAG_ID: integer := 5
);
PORT (
      clk                             : IN  std_logic;
      clk_enable                      : IN  std_logic;
      data                            : IN  std_logic_vector(DATA_WIDTH - 1 DOWNTO 0);
      trigger                         : IN  std_logic;
      start                           : OUT std_logic;
      ready_to_capture                : OUT std_logic;
      trigger_setting                 : OUT std_logic_vector(TRIG_WIDTH - 1 DOWNTO 0)
);
END COMPONENT;

COMPONENT hdlverifier_capture_trigger_condition IS 
PORT (
      clk                             : IN  std_logic;
      clk_enable                      : IN  std_logic;
      trigger_setting                 : IN  std_logic_vector(14 DOWNTO 0);
      New_Frame                       : IN  std_logic;
      Data_out                        : IN  std_logic_vector(4 DOWNTO 0);
      Calibration                     : IN  std_logic;
      trigger                         : OUT std_logic
);
END COMPONENT;

  SIGNAL all_data                         : std_logic_vector(7 DOWNTO 0); -- std8
  SIGNAL pad_zero                         : std_logic; -- std1
  SIGNAL trigger_setting                  : std_logic_vector(14 DOWNTO 0); -- std15
  SIGNAL trigger_1                        : std_logic; -- boolean
  SIGNAL start_flag                       : std_logic; -- boolean
  SIGNAL trigger_setting_cond1            : std_logic_vector(14 DOWNTO 0); -- std15
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

u_hdlverifier_capture_core: hdlverifier_capture_core 
GENERIC MAP (DATA_WIDTH => 8,
ADDR_WIDTH => 7,
TRIG_WIDTH => 15,
JTAG_ID => 55
)
PORT MAP(
        clk                  => clk,
        clk_enable           => clk_enable,
        start                => start_flag,
        ready_to_capture     => ready_to_capture,
        data                 => all_data,
        trigger              => trigger_1,
        trigger_setting      => trigger_setting
);

u_hdlverifier_capture_trigger_condition: hdlverifier_capture_trigger_condition 
PORT MAP(
        clk                  => clk,
        clk_enable           => clk_enable,
        trigger              => trigger_1,
        trigger_setting      => trigger_setting_cond1,
        New_Frame            => New_Frame,
        Data_out             => Data_out,
        Calibration          => Calibration
);

all_data <= pad_zero & New_Frame & Calibration & Data_out;
pad_zero <= '0';
trigger_setting_cond1 <= trigger_setting(14 DOWNTO 0);

END;
