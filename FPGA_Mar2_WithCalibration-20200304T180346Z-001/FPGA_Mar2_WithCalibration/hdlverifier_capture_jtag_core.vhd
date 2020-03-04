
-- ----------------------------------------------
-- File Name: hdlverifier_capture_jtag_core.vhd
-- Created:   02-Mar-2020 21:45:57
-- Copyright  2020 MathWorks, Inc.
-- ----------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity hdlverifier_capture_jtag_core is
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
end entity; 



architecture rtl of hdlverifier_capture_jtag_core is
  signal reg_addr_Reg : std_logic_vector(4 downto 0);
  signal reg_wdata_Reg : std_logic_vector(31 downto 0);
  signal reg_write_Reg : std_logic;
  signal shift_in_data_Reg : std_logic;
  signal shift_in_en_Reg : std_logic;
  signal shift_out_en_Reg : std_logic;
  signal capture_dr : std_logic;  
  signal command_reg : std_logic_vector(7 downto 0);  
  signal counter : std_logic_vector(7 downto 0);  
  signal jtag_reset : std_logic;  
  signal pad_len : std_logic_vector(2 downto 0);  
  signal read_reg : std_logic_vector(31 downto 0);  
  signal shift_dr : std_logic;  
  signal state_reg : std_logic_vector(3 downto 0);  
  signal tdi : std_logic;  
  signal tdi_shift_reg : std_logic_vector(31 downto 0);  
  signal tdi_shift_reg_next : std_logic_vector(31 downto 0);  
  signal tdo : std_logic;  
  signal update_dr : std_logic;  
  signal tck_internal : std_logic;  
  
  component hdlverifier_jtag_vendor_ip0 is
    generic(JTAG_ID: natural);
    port (
      capture_dr : out std_logic;
      jtag_reset : out std_logic;
      shift_dr : out std_logic;
      tck : out std_logic;
      tdi : out std_logic;
      tdo : in std_logic;
      update_dr : out std_logic
    );
  end component;
begin
  reg_addr <= reg_addr_Reg;
  reg_wdata <= reg_wdata_Reg;
  reg_write <= reg_write_Reg;
  shift_in_data <= shift_in_data_Reg;
  shift_in_en <= shift_in_en_Reg;
  shift_out_en <= shift_out_en_Reg;
  reset <= jtag_reset;

  tdo <= shift_out_data when command_reg(7 downto 5) = "100" else read_reg(0);
  shift_out_state <= '1' when command_reg(7 downto 5) = "100" else '0';
  shift_in_state <= '1' when command_reg(7 downto 5) = "101" else '0';
  tdi_shift_reg_next <= tdi & tdi_shift_reg(31 downto 1);
  tck <= tck_internal;
  
  
  u_jtag: hdlverifier_jtag_vendor_ip0
    generic map(
        JTAG_ID=>JTAG_ID
    )
    port map (
        capture_dr => capture_dr,
        jtag_reset => jtag_reset,
        shift_dr => shift_dr,
        tck => tck_internal,
        tdi => tdi,
        tdo => tdo,
        update_dr => update_dr
    );
  
  process (tck_internal) is
  begin
    if rising_edge(tck_internal) then
      if (jtag_reset = '1') or (capture_dr = '1') then
        tdi_shift_reg <= X"00000000";
      else
        if shift_dr = '1' then
          tdi_shift_reg <= tdi_shift_reg_next;
        end if;
      end if;
    end if;
  end process;
  
  
  process (tck_internal) is
  begin
    if rising_edge(tck_internal) then
      if jtag_reset = '1' then
        state_reg <= X"0";
        command_reg <= X"00";
        counter <= X"00";
        pad_len <= "000";
        reg_write_Reg <= '0';
        shift_out_en_Reg <= '0';
        shift_in_en_Reg <= '0';
      else
        case state_reg is
          when X"0" =>
            counter <= X"00";
            shift_out_en_Reg <= '0';
            command_reg <= X"00";
            pad_len <= "000";
            reg_write_Reg <= '0';
            if capture_dr = '1' then
              state_reg <= X"1";
            end if;
          when X"1" =>
            if shift_dr = '1' then
              if tdi_shift_reg_next(28 downto 24) = "10101" then
                state_reg <= X"2";
                pad_len <= tdi_shift_reg_next(31 downto 29);
              end if;
            end if;
          when X"2" =>
            if shift_dr = '1' then
              counter <= counter + '1';
              if counter= "00000111" then
                command_reg <= tdi_shift_reg_next(31 downto 24);
                state_reg <= X"0";
                counter <= X"00";
                if tdi_shift_reg_next(31 downto 29) = "001" then
                  state_reg <= X"3";
                  reg_addr_Reg <= tdi_shift_reg_next(28 downto 24);
                else
                  if tdi_shift_reg_next(31 downto 29) = "010" then
                    state_reg <= X"6";
                    reg_addr_Reg <= tdi_shift_reg_next(28 downto 24);
                  else
                    if tdi_shift_reg_next(31 downto 29) = "100" then
                      state_reg <= X"6";
                    else
                      if tdi_shift_reg_next(31 downto 29) = "101" then
                        state_reg <= X"8";
                      end if;
                    end if;
                  end if;
                end if;
              end if;
            end if;
          when X"3" =>
            if shift_dr = '1' then
              counter <= counter + X"01";
              if counter = X"1f" then
                reg_wdata_Reg <= tdi_shift_reg_next;
                reg_write_Reg <= '1';
                state_reg <= X"0";
              end if;
            end if;
          when X"4" =>
            if shift_dr = '1' then
              counter <= counter + X"01";
              read_reg <= '0' & read_reg(31 downto 1);
              if counter = X"1f" then
                state_reg <= X"0";
              end if;
            end if;
          when X"6" =>
            if capture_dr = '1' then
              read_reg <= reg_rdata;
              state_reg <= X"5";
            end if;
          when X"5" =>
            if shift_dr = '1' then
              counter <= counter + X"01";
              if counter = ("00000" & pad_len) then
                counter <= X"00";
                if command_reg(7 downto 5) = "100" then
                  state_reg <= X"7";
                else
                  state_reg <= X"4";
                end if;
              end if;
            end if;
          when X"7" =>
            if update_dr = '1' then
              state_reg <= X"0";
            end if;
            if shift_dr = '1' then
              if counter = X"05" then
                shift_out_en_Reg <= '1';
              else
                counter <= counter + X"01";
              end if;
            else
              shift_out_en_Reg <= '0';
            end if;
          when X"8" =>
            if update_dr = '1' then
              state_reg <= X"0";
              shift_in_en_Reg <= '0';
            end if;
            if shift_dr = '1' then
              shift_in_en_Reg <= '1';
              shift_in_data_Reg <= tdi;
            else
              shift_in_en_Reg <= '0';
            end if;
          when others =>
            state_reg <= X"0";
        end case;
      end if;
    end if;
  end process;
end architecture;
