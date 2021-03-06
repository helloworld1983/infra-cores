---------------------------------------------------------------------------------------
-- Title          : Wishbone slave core for FMC ADC Common registers
---------------------------------------------------------------------------------------
-- File           : wb_fmc_adc_common_regs_pkg.vhd
-- Author         : auto-generated by wbgen2 from wb_fmc_adc_common_regs.wb
-- Created        : Fri Jul 21 13:54:07 2017
-- Standard       : VHDL'87
---------------------------------------------------------------------------------------
-- THIS FILE WAS GENERATED BY wbgen2 FROM SOURCE FILE wb_fmc_adc_common_regs.wb
-- DO NOT HAND-EDIT UNLESS IT'S ABSOLUTELY NECESSARY!
---------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package wb_fmc_adc_common_csr_wbgen2_pkg is
  
  
  -- Input registers (user design -> WB slave)
  
  type t_wb_fmc_adc_common_csr_in_registers is record
    fmc_status_mmcm_locked_i                 : std_logic;
    fmc_status_pwr_good_i                    : std_logic;
    fmc_status_prst_i                        : std_logic;
    fmc_status_reserved_i                    : std_logic_vector(27 downto 0);
    trigger_reserved_i                       : std_logic_vector(28 downto 0);
    monitor_reserved_i                       : std_logic_vector(26 downto 0);
    end record;
  
  constant c_wb_fmc_adc_common_csr_in_registers_init_value: t_wb_fmc_adc_common_csr_in_registers := (
    fmc_status_mmcm_locked_i => '0',
    fmc_status_pwr_good_i => '0',
    fmc_status_prst_i => '0',
    fmc_status_reserved_i => (others => '0'),
    trigger_reserved_i => (others => '0'),
    monitor_reserved_i => (others => '0')
    );
    
    -- Output registers (WB slave -> user design)
    
    type t_wb_fmc_adc_common_csr_out_registers is record
      trigger_dir_o                            : std_logic;
      trigger_term_o                           : std_logic;
      trigger_trig_val_o                       : std_logic;
      monitor_test_data_en_o                   : std_logic;
      monitor_led1_o                           : std_logic;
      monitor_led2_o                           : std_logic;
      monitor_led3_o                           : std_logic;
      monitor_mmcm_rst_o                       : std_logic;
      end record;
    
    constant c_wb_fmc_adc_common_csr_out_registers_init_value: t_wb_fmc_adc_common_csr_out_registers := (
      trigger_dir_o => '0',
      trigger_term_o => '0',
      trigger_trig_val_o => '0',
      monitor_test_data_en_o => '0',
      monitor_led1_o => '0',
      monitor_led2_o => '0',
      monitor_led3_o => '0',
      monitor_mmcm_rst_o => '0'
      );
    function "or" (left, right: t_wb_fmc_adc_common_csr_in_registers) return t_wb_fmc_adc_common_csr_in_registers;
    function f_x_to_zero (x:std_logic) return std_logic;
    function f_x_to_zero (x:std_logic_vector) return std_logic_vector;
end package;

package body wb_fmc_adc_common_csr_wbgen2_pkg is
function f_x_to_zero (x:std_logic) return std_logic is
begin
if x = '1' then
return '1';
else
return '0';
end if;
end function;
function f_x_to_zero (x:std_logic_vector) return std_logic_vector is
variable tmp: std_logic_vector(x'length-1 downto 0);
begin
for i in 0 to x'length-1 loop
if(x(i) = 'X' or x(i) = 'U') then
tmp(i):= '0';
else
tmp(i):=x(i);
end if; 
end loop; 
return tmp;
end function;
function "or" (left, right: t_wb_fmc_adc_common_csr_in_registers) return t_wb_fmc_adc_common_csr_in_registers is
variable tmp: t_wb_fmc_adc_common_csr_in_registers;
begin
tmp.fmc_status_mmcm_locked_i := f_x_to_zero(left.fmc_status_mmcm_locked_i) or f_x_to_zero(right.fmc_status_mmcm_locked_i);
tmp.fmc_status_pwr_good_i := f_x_to_zero(left.fmc_status_pwr_good_i) or f_x_to_zero(right.fmc_status_pwr_good_i);
tmp.fmc_status_prst_i := f_x_to_zero(left.fmc_status_prst_i) or f_x_to_zero(right.fmc_status_prst_i);
tmp.fmc_status_reserved_i := f_x_to_zero(left.fmc_status_reserved_i) or f_x_to_zero(right.fmc_status_reserved_i);
tmp.trigger_reserved_i := f_x_to_zero(left.trigger_reserved_i) or f_x_to_zero(right.trigger_reserved_i);
tmp.monitor_reserved_i := f_x_to_zero(left.monitor_reserved_i) or f_x_to_zero(right.monitor_reserved_i);
return tmp;
end function;
end package body;
