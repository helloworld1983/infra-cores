library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
-- Main Wishbone Definitions
use work.wishbone_pkg.all;
-- Custom Wishbone Modules
use work.ifc_wishbone_pkg.all;
-- Trigger definitions
use work.trigger_common_pkg.all;

entity xwb_trigger_mux is
  generic
    (
      g_interface_mode       : t_wishbone_interface_mode      := CLASSIC;
      g_address_granularity  : t_wishbone_address_granularity := WORD;
      g_trig_num             : natural range 1 to 24          := 8;
      g_intern_num           : natural range 1 to 24          := 8;
      g_rcv_intern_num       : natural range 1 to 24          := 2
      );
  port
    (
      rst_n_i    : in std_logic;
      clk_i      : in std_logic;
      fs_clk_i   : in std_logic;
      fs_rst_n_i : in std_logic;

      -----------------------------
      -- Wishbone signals
      -----------------------------

      wb_slv_i : in  t_wishbone_slave_in;
      wb_slv_o : out t_wishbone_slave_out;

      -----------------------------
      -- External ports
      -----------------------------

      trig_out_o : out t_trig_channel_array(g_trig_num-1 downto 0);
      trig_in_i  : in  t_trig_channel_array(g_trig_num-1 downto 0);

      -----------------------------
      -- Internal ports
      -----------------------------

      trig_rcv_intern_i   : in  t_trig_channel_array(g_rcv_intern_num-1 downto 0);

      trig_pulse_transm_i : in  t_trig_channel_array(g_intern_num-1 downto 0);
      trig_pulse_rcv_o    : out t_trig_channel_array(g_intern_num-1 downto 0)
      );

end xwb_trigger_mux;

architecture rtl of xwb_trigger_mux is
begin

  cmp_wb_trigger_mux : wb_trigger_mux
    generic map (
      g_interface_mode       => g_interface_mode,
      g_address_granularity  => g_address_granularity,
      g_trig_num             => g_trig_num,
      g_intern_num           => g_intern_num,
      g_rcv_intern_num       => g_rcv_intern_num)
    port map (
      clk_i      => clk_i,
      rst_n_i    => rst_n_i,
      fs_clk_i   => fs_clk_i,
      fs_rst_n_i => fs_rst_n_i,

      wb_adr_i   => wb_slv_i.adr,
      wb_dat_i   => wb_slv_i.dat,
      wb_dat_o   => wb_slv_o.dat,
      wb_sel_i   => wb_slv_i.sel,
      wb_we_i    => wb_slv_i.we,
      wb_cyc_i   => wb_slv_i.cyc,
      wb_stb_i   => wb_slv_i.stb,
      wb_ack_o   => wb_slv_o.ack,
      wb_err_o   => wb_slv_o.err,
      wb_rty_o   => wb_slv_o.rty,
      wb_stall_o => wb_slv_o.stall,

      trig_out_o => trig_out_o,
      trig_in_i  => trig_in_i,

      trig_rcv_intern_i   => trig_rcv_intern_i,
      trig_pulse_transm_i => trig_pulse_transm_i,
      trig_pulse_rcv_o    => trig_pulse_rcv_o
  );

end rtl;
