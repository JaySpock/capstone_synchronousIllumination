 library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL; 
use IEEE.std_logic_unsigned.all; 

LIBRARY altera; 
USE altera.altera_primitives_components.all;
  

entity hello_world is 

    port(   clk    			: in std_logic; 										-- Clock signal

            KEY    			: in std_logic;										-- Startup switch
				
				DATA 	 			: in std_logic;										-- Current bit from Camera
				
				LED_OUT			: out std_logic_vector(2 downto 0);				-- LED output for the pins--
				
            LED    			: out std_logic_vector(2 downto 0)); 			-- LED output for development board LEDs

end entity; 

  

architecture hello_world_arch of hello_world is 
	
	component nios_setup
        port (
            clk_clk                           : in  std_logic                    := 'X';             -- clk
            led_external_connection_export    : in  std_logic_vector(4 downto 0);                    -- export
            reset_reset_n                     : in  std_logic                    := 'X';             -- reset_n
            switch_external_connection_export : out  std_logic_vector(2 downto 0) := (others => 'X'));
    end component;



	signal FIFO_reg			: std_logic_vector(61 downto 0) := "11111111111111111111111111111111111111111111111111111111111111";

	signal LED_output 		: std_logic_vector(2 downto 0) := "110"; 				--Starts as red frame
	
	signal EOF_DETECTION		: std_logic;													--Indicates that an end of frame (EOF) was detected

	signal cnt         		: INTEGER RANGE 0 TO 25000000;							--Controls the time between when a new frame is detected and when the next new frame can be detected
																										--This removes false EOF detections that can occur during the upstream communications

	signal startup_frame		: INTEGER RANGE 0 to 4 := 0;								--Controls what color calibration is happening during calibration mode
	
	signal calibration_cnt	: INTEGER RANGE 0 to 2 := 0;								--Controls what frame is on during each calibration color
	
	signal DATA_OUT			: std_logic_vector(4 downto 0) := "00000";			--Describes what state the fpga is in
	
	signal Button_comp 		: std_logic_vector(2 downto 0) := "000";				--Input from computer, sets fpga into specific state: Starts in standby mode (all LEDs off)

	begin 


	u0 : component nios_setup
			  port map (
					clk_clk                           => clk,         --                        clk.clk
					led_external_connection_export    => DATA_OUT,    --    led_external_connection.export
					reset_reset_n                     => KEY,         --                      reset.reset_n
					switch_external_connection_export => Button_comp  -- switch_external_connection.export
					);

		LED <= LED_output; 						
		
		LED_out <= not LED_output;
	
--				
	 process (clk)
			begin
			
				if (rising_edge(clk)) then	
				
					if (EOF_DETECTION = '1') then			--if end of frame is detected then increment count by 1
				
						cnt <= cnt + 1;
						
					end if;
					
					for address in 61 downto 1 loop		--Shift bits left through the fifo register
						
						FIFO_reg(address) <= FIFO_reg(address - 1);
							
					end loop;
							
					FIFO_reg(0) <= DATA;						--Read data from camera and store in first position of fifo register
	
					if (FIFO_reg = "00000000000000000000000000000000000000000000000000000000000000" and EOF_DETECTION = '0') then --End of frame is indicated by consecutive zeros by camera data
					
						EOF_DETECTION <= '1';				--Set end of frame as detected
						cnt <= 0;
						
						if (Button_comp = "000") then			-- '0' input from computer
							LED_output <= "111";					-- All LEDs off	
							DATA_OUT <= "00000";					-- '0' state 
							startup_frame <= 0;					-- then set startup mode to known calibration frame start
							calibration_cnt <= 0;
						
						elsif (Button_comp = "001") then		-- '1' input from computer starts calibration
							case startup_frame is
								when 0	=>
									if(calibration_cnt = 0) then							
										LED_output <= "110";									--Red LED is turned on during one frame
										calibration_cnt <= calibration_cnt + 1;	
										DATA_OUT <= "00001";									--'1' state
									elsif(calibration_cnt = 1) then
										LED_output <= "111";									--All LEDs are turned off for one frame	
										calibration_cnt <= calibration_cnt + 1;
										DATA_OUT <= "00010";									--'2' state
									else
										LED_output <= "111";									--All LEDs are off for one more frame
										startup_frame <= 1;									--Case statement set to green calibration
										calibration_cnt <= 0;
										DATA_OUT <= "00011";									--'3' state
									end if;
	
								when 1	=>		
									if(calibration_cnt = 0) then
										LED_output <= "101";									--Green LED is turned on during one frame
										calibration_cnt <= calibration_cnt + 1;
										DATA_OUT <= "00100";									--'4' state
									elsif(calibration_cnt = 1) then
										LED_output <= "111";									--All LEDs are turned off for one frame
										calibration_cnt <= calibration_cnt + 1;
										DATA_OUT <= "00101";									--'5' state
									else
										LED_output <= "111";									--All LEDs are off for one more frame
										startup_frame <= 2;									--Case statement set to blue calibration
										calibration_cnt <= 0;
										DATA_OUT <= "00110";									--'6' state
									end if;
								
								when 2 	=>
									if(calibration_cnt = 0) then
										LED_output <= "011";									--Blue LED is turned on during one frame
										calibration_cnt <= calibration_cnt + 1;
										DATA_OUT <= "00111";									--'7' state
									elsif(calibration_cnt = 1) then					
										LED_output <= "111";									--All LEDs are turned off for one frame
										calibration_cnt <= calibration_cnt + 1;		
										DATA_OUT <= "01000";									--'8' state		
									else
										LED_output <= "111";									--All LEDs are off for one more frame
										startup_frame <= 0;									--Case statement set to red calibration (calibration sequence starts over)
										calibration_cnt <= 0;
										DATA_OUT <= "01001";									--'9' state
									end if;
								when others =>													-- if calibration mode is set to run and the start up frame is outside of the 3 calibration frames
									startup_frame <= 0;										-- then set startup mode to known calibration frame start
									calibration_cnt <= 0;
									
							end case;
							
						elsif (Button_comp = "010") then		-- '2' input from computer starts synchronous run mode
							
							case LED_output is
									when "110" =>					-- if red was on then turn on green
										LED_output <= "101";
										DATA_OUT <= "01011";		-- '11' state
									when "101" =>					-- if green was on then turn on blue
										LED_output <= "011";		
										DATA_OUT <= "01100";		-- '12' state
									when "011" =>					-- if blue was on then turn on red
										LED_output <= "110";
										DATA_OUT <= "01010";		-- '10' state
									when "111" =>					-- if all LEDs off then turn on red
										LED_output <= "110";
										DATA_OUT <= "01010";		-- '10' state
									when others =>
										LED_output <= "111";		-- if LEDs are set to anything else then turn off all LEDs
										DATA_OUT <= "01101";		-- '13' state
							end case;
							
						elsif (Button_comp = "011") then    -- '3' input from computer turns all LEDs on to create white light
							LED_output <= "000";             -- All LEDs on
							
						else								-- if computer sends a number outside of the 3 modes then set all LEDs off
							LED_output <= "111";
							DATA_OUT <= "01101";		-- '13' state
						end if;	

					elsif (EOF_DETECTION = '1' and cnt >250000) then  --if end of frame was detected and count is greater than 250000
																					-- then reset end of frame to undetected and count to zero
						EOF_DETECTION <= '0';
						cnt <= 0;
					end if;
					
				end if;
			end process;
	end architecture; 


