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

entity xwb_trigger_iface is
  generic
    (
      g_interface_mode                         : t_wishbone_interface_mode      := CLASSIC;
      g_address_granularity                    : t_wishbone_address_granularity := WORD;
      -- "true" to use external bidirectional trigger (*_b port) or "false"
      -- to use separate ports for external trigger input/output
      g_with_bidirectional_trigger             : boolean := true;
      -- IOBUF instantiation type if g_with_bidirectional_trigger = true.
      -- Possible values are: "native" or "inferred"
      g_iobuf_instantiation_type               : string := "native";
      -- Wired-OR implementation if g_with_wired_or_driver = true.
      -- Possible values are: true or false
      g_with_wired_or_driver                   : boolean := true;
      -- Sync pulse on "positive" or "negative" edge of incoming pulse
      g_sync_edge                              : string  := "positive";
      -- channels facing outside the FPGA.
      g_trig_num                               : natural := 8
    );
  port
    (
      rst_n_i    : in std_logic;
      clk_i      : in std_logic;

      ref_clk_i   : in std_logic;
      ref_rst_n_i : in std_logic;

      -----------------------------
      -- Wishbone signals
      -----------------------------

      wb_slv_i : in  t_wishbone_slave_in;
      wb_slv_o : out t_wishbone_slave_out;

      -----------------------------
      -- External ports
      -----------------------------

      trig_b     : inout std_logic_vector(g_trig_num-1 downto 0);
      trig_dir_o : out   std_logic_vector(g_trig_num-1 downto 0);

      -----------------------------
      -- Internal ports
      -----------------------------

      trig_out_o : out t_trig_channel_array(g_trig_num-1 downto 0);
      trig_in_i  : in  t_trig_channel_array(g_trig_num-1 downto 0);

    -------------------------------
    ---- Debug ports
    -------------------------------
      trig_dbg_o : out std_logic_vector(g_trig_num-1 downto 0)
      );

end xwb_trigger_iface;

architecture rtl of xwb_trigger_iface is
begin

  cmp_wb_trigger_iface : wb_trigger_iface
    generic map (
      g_interface_mode             => g_interface_mode,
      g_address_granularity        => g_address_granularity,
      g_with_bidirectional_trigger => g_with_bidirectional_trigger,
      g_iobuf_instantiation_type   => g_iobuf_instantiation_type,
      g_with_wired_or_driver       => g_with_wired_or_driver,
      g_sync_edge                  => g_sync_edge,
      g_trig_num                   => g_trig_num
    )
    port map (
      clk_i       => clk_i,
      rst_n_i     => rst_n_i,
      ref_clk_i   => ref_clk_i,
      ref_rst_n_i => ref_rst_n_i,

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

      trig_b      => trig_b,
      trig_dir_o  => trig_dir_o,
      trig_out_o  => trig_out_o,
      trig_in_i   => trig_in_i,
      trig_dbg_o  => trig_dbg_o
    );

end rtl;
