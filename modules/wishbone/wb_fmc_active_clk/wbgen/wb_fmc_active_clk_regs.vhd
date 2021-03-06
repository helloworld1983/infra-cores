---------------------------------------------------------------------------------------
-- Title          : Wishbone slave core for FMC Active Clock registers
---------------------------------------------------------------------------------------
-- File           : wb_fmc_active_clk_regs.vhd
-- Author         : auto-generated by wbgen2 from wb_fmc_active_clk_regs.wb
-- Created        : Mon Apr 18 10:20:28 2016
-- Standard       : VHDL'87
---------------------------------------------------------------------------------------
-- THIS FILE WAS GENERATED BY wbgen2 FROM SOURCE FILE wb_fmc_active_clk_regs.wb
-- DO NOT HAND-EDIT UNLESS IT'S ABSOLUTELY NECESSARY!
---------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.wb_fmc_active_clk_csr_wbgen2_pkg.all;


entity wb_fmc_active_clk_csr is
  port (
    rst_n_i                                  : in     std_logic;
    clk_sys_i                                : in     std_logic;
    wb_adr_i                                 : in     std_logic_vector(0 downto 0);
    wb_dat_i                                 : in     std_logic_vector(31 downto 0);
    wb_dat_o                                 : out    std_logic_vector(31 downto 0);
    wb_cyc_i                                 : in     std_logic;
    wb_sel_i                                 : in     std_logic_vector(3 downto 0);
    wb_stb_i                                 : in     std_logic;
    wb_we_i                                  : in     std_logic;
    wb_ack_o                                 : out    std_logic;
    wb_stall_o                               : out    std_logic;
    regs_i                                   : in     t_wb_fmc_active_clk_csr_in_registers;
    regs_o                                   : out    t_wb_fmc_active_clk_csr_out_registers
  );
end wb_fmc_active_clk_csr;

architecture syn of wb_fmc_active_clk_csr is

signal wb_fmc_active_clk_csr_clk_distrib_si571_oe_int : std_logic      ;
signal wb_fmc_active_clk_csr_clk_distrib_pll_function_int : std_logic      ;
signal wb_fmc_active_clk_csr_clk_distrib_clk_sel_int : std_logic      ;
signal ack_sreg                                 : std_logic_vector(9 downto 0);
signal rddata_reg                               : std_logic_vector(31 downto 0);
signal wrdata_reg                               : std_logic_vector(31 downto 0);
signal bwsel_reg                                : std_logic_vector(3 downto 0);
signal rwaddr_reg                               : std_logic_vector(0 downto 0);
signal ack_in_progress                          : std_logic      ;
signal wr_int                                   : std_logic      ;
signal rd_int                                   : std_logic      ;
signal allones                                  : std_logic_vector(31 downto 0);
signal allzeros                                 : std_logic_vector(31 downto 0);

begin
-- Some internal signals assignments. For (foreseen) compatibility with other bus standards.
  wrdata_reg <= wb_dat_i;
  bwsel_reg <= wb_sel_i;
  rd_int <= wb_cyc_i and (wb_stb_i and (not wb_we_i));
  wr_int <= wb_cyc_i and (wb_stb_i and wb_we_i);
  allones <= (others => '1');
  allzeros <= (others => '0');
-- 
-- Main register bank access process.
  process (clk_sys_i, rst_n_i)
  begin
    if (rst_n_i = '0') then 
      ack_sreg <= "0000000000";
      ack_in_progress <= '0';
      rddata_reg <= "00000000000000000000000000000000";
      wb_fmc_active_clk_csr_clk_distrib_si571_oe_int <= '0';
      wb_fmc_active_clk_csr_clk_distrib_pll_function_int <= '0';
      wb_fmc_active_clk_csr_clk_distrib_clk_sel_int <= '0';
    elsif rising_edge(clk_sys_i) then
-- advance the ACK generator shift register
      ack_sreg(8 downto 0) <= ack_sreg(9 downto 1);
      ack_sreg(9) <= '0';
      if (ack_in_progress = '1') then
        if (ack_sreg(0) = '1') then
          ack_in_progress <= '0';
        else
        end if;
      else
        if ((wb_cyc_i = '1') and (wb_stb_i = '1')) then
          case rwaddr_reg(0) is
          when '0' => 
            if (wb_we_i = '1') then
              wb_fmc_active_clk_csr_clk_distrib_si571_oe_int <= wrdata_reg(0);
              wb_fmc_active_clk_csr_clk_distrib_pll_function_int <= wrdata_reg(1);
              wb_fmc_active_clk_csr_clk_distrib_clk_sel_int <= wrdata_reg(3);
            end if;
            rddata_reg(0) <= wb_fmc_active_clk_csr_clk_distrib_si571_oe_int;
            rddata_reg(1) <= wb_fmc_active_clk_csr_clk_distrib_pll_function_int;
            rddata_reg(2) <= regs_i.clk_distrib_pll_status_i;
            rddata_reg(3) <= wb_fmc_active_clk_csr_clk_distrib_clk_sel_int;
            rddata_reg(31 downto 4) <= regs_i.clk_distrib_reserved_i;
            ack_sreg(0) <= '1';
            ack_in_progress <= '1';
          when '1' => 
            if (wb_we_i = '1') then
            end if;
            rddata_reg(31 downto 0) <= regs_i.dummy_reserved_i;
            ack_sreg(0) <= '1';
            ack_in_progress <= '1';
          when others =>
-- prevent the slave from hanging the bus on invalid address
            ack_in_progress <= '1';
            ack_sreg(0) <= '1';
          end case;
        end if;
      end if;
    end if;
  end process;
  
  
-- Drive the data output bus
  wb_dat_o <= rddata_reg;
-- Si 571 Output Enable
  regs_o.clk_distrib_si571_oe_o <= wb_fmc_active_clk_csr_clk_distrib_si571_oe_int;
-- AD9510 PLL function
  regs_o.clk_distrib_pll_function_o <= wb_fmc_active_clk_csr_clk_distrib_pll_function_int;
-- AD9510 PLL Status
-- Reference Clock Selection
  regs_o.clk_distrib_clk_sel_o <= wb_fmc_active_clk_csr_clk_distrib_clk_sel_int;
-- Reserved
-- Reserved
  rwaddr_reg <= wb_adr_i;
  wb_stall_o <= (not ack_sreg(0)) and (wb_stb_i and wb_cyc_i);
-- ACK signal generation. Just pass the LSB of ACK counter.
  wb_ack_o <= ack_sreg(0);
end syn;
