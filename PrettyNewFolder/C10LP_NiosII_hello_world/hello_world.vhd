 library IEEE;
use IEEE.STD_LOGIC_1164.ALL; 
use IEEE.NUMERIC_STD.ALL; 
use IEEE.std_logic_unsigned.all; 

LIBRARY altera; 
USE altera.altera_primitives_components.all;
  

entity hello_world is 

    port(   clk    			: in std_logic; 										-- Clock signal

            KEY    			: in std_logic;										-- Startup switch
				
				Button			: in std_logic_vector(2 downto 0);				-- Calibration buttons 
				
				DATA 	 			: in std_logic;										-- Current bit from Camera
				
				END_OF_FRAME	: out std_logic;										-- Rising edge indicates EOF
				
				CURRENT_MODE   : in std_logic_vector(4 downto 0);
				
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



	signal FIFO_reg		: std_logic_vector(61 downto 0) := "11111111111111111111111111111111111111111111111111111111111111";

	signal LED_output 	: std_logic_vector(2 downto 0) := "110"; -- RED?
	
	signal LED_BUFFER 	: std_logic := '1'; 
	
	signal NEW_FRAME		: std_logic := '0'; 
	
	signal DATA_BUFFER	: std_logic;

	signal cnt         	: INTEGER RANGE 0 TO 25000000;

	signal startup_frame	: INTEGER RANGE 0 to 4 := 0;
	
	signal run_mode		: INTEGER RANGE 0 to 3 := 0;
	
	signal cal_cnt			: INTEGER RANGE 0 to 2;
	
	signal DATA_OUT		: std_logic_vector(4 downto 0) := "00000";
	
	signal Button_comp 	: std_logic_vector(2 downto 0) := "000";

	begin 


	u0 : component nios_setup
			  port map (
					clk_clk                           => clk,                           --                        clk.clk
					led_external_connection_export    => DATA_OUT,    --    led_external_connection.export
					reset_reset_n                     => KEY,                     --                      reset.reset_n
					switch_external_connection_export => Button_comp  -- switch_external_connection.export
					);
						
		END_OF_FRAME <= NEW_FRAME;

		LED <= LED_output; 
		
		LED_out <= not LED_output;
	
--				
	 process (clk)
			begin
			
				if (rising_edge(clk)) then	
				
					if (DATA_BUFFER = '1') then
				
						cnt <= cnt + 1;
						
					end if;
					
					for address in 61 downto 1 loop
						
						FIFO_reg(address) <= FIFO_reg(address - 1);
							
					end loop;
							
					FIFO_reg(0) <= DATA;
					
					if(Button_comp = "000") then
					   run_mode <= 0;
					elsif(Button_comp = "001") then
						run_mode <= 1;
					elsif (Button_comp = "010") then
						run_mode <= 2;
					end if;

				
--					
					if (FIFO_reg = "00000000000000000000000000000000000000000000000000000000000000" and DATA_BUFFER = '0') then
					
						LED_BUFFER    <= LED_output(2);
					
						NEW_FRAME <= '1';
						DATA_BUFFER <= '1';
						cnt <= 0;
						
						if (Button_comp = "000") then
							LED_output <= "111";						
							DATA_OUT <= "00000";
							startup_frame <= 0;					-- then set startup mode to known calibration frame start
							cal_cnt <= 0;
						
						elsif (Button_comp = "001") then
							case startup_frame is
								when 0	=>
--								LED_output <= "110";						--RED startup frame
									if(cal_cnt = 1) then
										LED_output <= "111";
										cal_cnt <= cal_cnt + 1;
										DATA_OUT <= "00010";
									elsif(cal_cnt = 0) then
										LED_output <= "110";
										cal_cnt <= cal_cnt + 1;	
										DATA_OUT <= "00001";
									else
										LED_output <= "111";	
										startup_frame <= 1;
										cal_cnt <= 0;
										DATA_OUT <= "00011";	
									end if;
	
								when 1	=>									--GREEN startup frame
									if(cal_cnt = 1) then
										LED_output <= "111";
										cal_cnt <= cal_cnt + 1;
										DATA_OUT <= "00101";	
									elsif(cal_cnt = 0) then
										LED_output <= "101";
										cal_cnt <= cal_cnt + 1;
										DATA_OUT <= "00100";	
									else
										LED_output <= "111";	
										startup_frame <= 2;
										cal_cnt <= 0;
										DATA_OUT <= "00110";
									end if;
								
								when 2 	=>
									if(cal_cnt = 1) then					--BLUE startup frame
										LED_output <= "111";
										cal_cnt <= cal_cnt + 1;	
										DATA_OUT <= "01000";
									elsif(cal_cnt = 0) then
										LED_output <= "011";
										cal_cnt <= cal_cnt + 1;
										DATA_OUT <= "00111";
									else
										LED_output <= "111";	
										startup_frame <= 0;
										cal_cnt <= 0;
										DATA_OUT <= "01001";	
									end if;
								when others =>							-- if calibration mode is set to run and the start up frame is outside of the 3 calibration frames
									startup_frame <= 0;					-- then set startup mode to known calibration frame start
									cal_cnt <= 0;
									
							end case;
							
						elsif (Button_comp = "010") then
							
							case LED_output is
									when "110" =>
										LED_output <= "101";
										DATA_OUT <= "01011";
									when "101" =>
										LED_output <= "011";
										DATA_OUT <= "01100";
									when "011" =>
										LED_output <= "110";
										DATA_OUT <= "01010";
									when "111" =>
										LED_output <= "110";
										DATA_OUT <= "01010";	
									when others =>
										LED_output <= "111";
										DATA_OUT <= "01101";
							end case;
						else
							LED_output <= "111";
							DATA_OUT <= "01101";
						end if;	

					elsif (DATA_BUFFER = '1' and cnt >250000) then
					
						NEW_FRAME <= '0';
						DATA_BUFFER <= '0';
						cnt <= 0;
					end if;
				end if;
			end process;
	end architecture; 


