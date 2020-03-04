
-- ----------------------------------------------
-- File Name: hdlverifier_jtag_vendor_ip0.vhd
-- Created:   02-Mar-2020 21:45:57
-- Copyright  2020 MathWorks, Inc.
-- ----------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity hdlverifier_jtag_vendor_ip0 is
    generic(JTAG_ID: natural := 55);
    port(
        tdo:        in  std_logic;
        tdi:        out std_logic;
        tck:        out std_logic;
        jtag_reset:  out std_logic;
        capture_dr:  out std_logic;
        shift_dr  :  out std_logic;
        update_dr :  out std_logic
    );
end entity hdlverifier_jtag_vendor_ip0;

architecture jtag_vendor_ip0_arch of hdlverifier_jtag_vendor_ip0 is
    signal ir : std_logic_vector(7 downto 0);
    
component  sld_virtual_jtag
    generic (
        sld_sim_n_scan              : natural := 0;
        sld_sim_total_length : natural := 0;
        sld_auto_instance_index : string := "NO";
        sld_instance_index : natural := 0;
        sld_ir_width : natural := 1);
    port(
        ir_in : out std_logic_vector(sld_ir_width-1 downto 0);
        ir_out: in std_logic_vector(sld_ir_width-1 downto 0);
        tck : out std_logic;
        tdi : out std_logic;
        tdo : in std_logic;
        virtual_state_cdr : out std_logic;
        virtual_state_sdr : out std_logic;
        virtual_state_udr : out std_logic);
end component;
     
begin
    jtag_reset <= ir(0);
    
    u_virtual_jtag: sld_virtual_jtag
    generic map(
        sld_sim_n_scan              => 0,
        sld_sim_total_length        => 0,
        sld_auto_instance_index     => "NO",
        sld_instance_index          => JTAG_ID,
        sld_ir_width                => 8
    )
    port map(
        tdi                 =>      tdi,
        tdo                 =>      tdo,
        ir_in               =>      ir,
        ir_out              =>      "00000000",
        virtual_state_cdr   =>      capture_dr,
        virtual_state_sdr   =>      shift_dr,
        tck                 =>      tck,
        virtual_state_udr   =>      update_dr
    );

end jtag_vendor_ip0_arch;