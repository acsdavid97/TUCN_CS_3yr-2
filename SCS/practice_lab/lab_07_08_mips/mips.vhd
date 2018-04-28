----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:49:53 04/23/2018 
-- Design Name: 
-- Module Name:    mips - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.mips_package.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mips is
	Port (
		clk : in std_ulogic
	);
end mips;

architecture Behavioral of mips is

component alu IS
	PORT (
		a, b : IN STD_ULOGIC_VECTOR(width - 1 DOWNTO 0);
		opcode : IN STD_ULOGIC_VECTOR(1 DOWNTO 0);
		result : OUT STD_ULOGIC_VECTOR(width - 1 DOWNTO 0);
		zero : OUT STD_ULOGIC
	);
END component;

component instreg is
	port 
	(
		clk : in STD_ULOGIC;
		rst_n : in STD_ULOGIC;
		memdata : in STD_ULOGIC_VECTOR(width - 1 downto 0);
		IRWrite : in STD_ULOGIC;
		instr_31_26 : out STD_ULOGIC_VECTOR(5 downto 0);
		instr_25_21 : out STD_ULOGIC_VECTOR(4 downto 0);
		instr_20_16 : out STD_ULOGIC_VECTOR(4 downto 0);
		instr_15_0 : out STD_ULOGIC_VECTOR(15 downto 0) 
	);
end component;

component pc is
	port 
	(
		clk : in STD_ULOGIC;
		rst_n : in STD_ULOGIC;
		pc_in : in STD_ULOGIC_VECTOR(width - 1 downto 0);
		PC_en : in STD_ULOGIC;
		pc_out : out STD_ULOGIC_VECTOR(width - 1 downto 0) 
	);
end component;

component regfile is
	port 
	(
		clk, rst_n : in std_ulogic;
		wen : in std_ulogic; -- write control
		writeport : in std_ulogic_vector(width - 1 downto 0);
		-- register input
		adrwport : in std_ulogic_vector(regfile_adrsize - 1 DOWNTO 0);-- address write
		adrport0 : in std_ulogic_vector(regfile_adrsize - 1 DOWNTO 0);-- address port 0
		adrport1 : in std_ulogic_vector(regfile_adrsize - 1 DOWNTO 0);-- address port 1
		readport0 : out std_ulogic_vector(width - 1 downto 0);
		-- output port 0
		readport1 : out std_ulogic_vector(width - 1 downto 0)
		-- output port 1
	);
end component;

-- alu signals
signal alu_a : STD_ULOGIC_VECTOR(width - 1 DOWNTO 0);
signal alu_b : STD_ULOGIC_VECTOR(width - 1 DOWNTO 0);
signal alu_opcode : STD_ULOGIC_VECTOR(1 DOWNTO 0);

-- instreg singals
signal instreg_rst_n : STD_ULOGIC;
signal instreg_memdata : STD_ULOGIC_VECTOR(width - 1 downto 0);
signal instreg_IRWrite : STD_ULOGIC;

-- pc signals
signal pc_rst_n : STD_ULOGIC;
signal pc_pc_in : STD_ULOGIC_VECTOR(width - 1 downto 0);
signal pc_PC_en : STD_ULOGIC;

-- regfile signals
signal reg_wen : std_ulogic; -- write control
signal reg_rst_n : std_ulogic;
signal reg_writeport : std_ulogic_vector(width - 1 downto 0);
signal reg_adrwport : std_ulogic_vector(regfile_adrsize - 1 DOWNTO 0);-- address write
signal reg_adrport0 : std_ulogic_vector(regfile_adrsize - 1 DOWNTO 0);-- address port 0
signal reg_adrport1 : std_ulogic_vector(regfile_adrsize - 1 DOWNTO 0);-- address port 1


begin

alu_m : alu port map (
			a => alu_a, b => alu_b, opcode => alu_opcode
		);
instreg_m : instreg port map (
			clk => clk, rst_n => instreg_rst_n, memdata => instreg_memdata, IRWrite => instreg_IRWrite
		);
pc_m : pc port map (
			clk => clk, rst_n => pc_rst_n, pc_in => pc_pc_in, PC_en => pc_PC_en
		);

reg_m : regfile port map (
			clk => clk, wen => reg_wen, rst_n => reg_rst_n, writeport => reg_writeport, adrwport => reg_adrwport, adrport0 => reg_adrport0, adrport1 => reg_adrport1
		);
			
			
end Behavioral;

