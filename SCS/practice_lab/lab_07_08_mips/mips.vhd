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

component control_unit is
    Port (
		clk : in std_logic;
		reset : in std_logic;
		op : in  STD_ULOGIC_VECTOR (5 downto 0);
		PCSource : out std_logic_vector(1 downto 0);
		ALUOp : out std_logic_vector(1 downto 0);
		ALUSrcB : out std_logic_vector(1 downto 0);
		ALUSrcA : out std_logic;
		RegWrite : out std_logic;
		RegDst : out std_logic;
		PCWriteCond : out std_logic;
		PCWrite : out std_logic;
		IorD : out std_logic;
		MemRead : out std_logic;
		MemWrite : out std_logic;
		MemToReg : out std_logic;
		IRWrite : out std_logic
	 );
end component;

component rams_no_change is
    port ( clk : in std_logic;
    we : in std_logic;
    en : in std_logic;
    addr : in std_logic_vector(width - 1 downto 0);
    di : in std_logic_vector(width - 1 downto 0);
    do : out std_logic_vector(width - 1 downto 0));
end component;

-- alu signals
signal alu_a : STD_ULOGIC_VECTOR(width - 1 DOWNTO 0);
signal alu_b : STD_ULOGIC_VECTOR(width - 1 DOWNTO 0);
signal alu_opcode : STD_ULOGIC_VECTOR(1 DOWNTO 0);
signal alu_result : std_ulogic_vector(width - 1 downto 0);

-- instreg singals
signal instreg_rst_n : STD_ULOGIC;
signal instreg_memdata : STD_ULOGIC_VECTOR(width - 1 downto 0);
signal instreg_IRWrite : STD_ULOGIC;
signal instr_31_26 : STD_ULOGIC_VECTOR(5 downto 0);
signal instr_25_21 : STD_ULOGIC_VECTOR(4 downto 0);
signal instr_20_16 : STD_ULOGIC_VECTOR(4 downto 0);
signal instr_15_0 : STD_ULOGIC_VECTOR(15 downto 0); 

-- pc signals
signal pc_rst_n : STD_ULOGIC;
signal pc_pc_in : STD_ULOGIC_VECTOR(width - 1 downto 0);
signal pc_pc_out : STD_ULOGIC_VECTOR(width - 1 downto 0);
signal pc_PC_en : STD_ULOGIC;

-- regfile signals
signal reg_wen : std_ulogic; -- write control
signal reg_rst_n : std_ulogic;
signal reg_writeport : std_ulogic_vector(width - 1 downto 0);
signal reg_adrwport : std_ulogic_vector(regfile_adrsize - 1 DOWNTO 0); -- address write
signal reg_adrport0 : std_ulogic_vector(regfile_adrsize - 1 DOWNTO 0); -- address port 0
signal reg_adrport1 : std_ulogic_vector(regfile_adrsize - 1 DOWNTO 0); -- address port 1
signal reg_readport0 : std_ulogic_vector(width - 1 downto 0); -- output port 0
signal reg_readport1 : std_ulogic_vector(width - 1 downto 0); -- output port 1

-- control unit signals
signal cu_reset : std_logic;
signal cu_op : STD_ULOGIC_VECTOR (5 downto 0);
signal cu_PCSource : std_logic_vector(1 downto 0);
signal cu_ALUOp : std_logic_vector(1 downto 0);
signal cu_ALUSrcB : std_logic_vector(1 downto 0);
signal cu_ALUSrcA : std_logic;
signal cu_RegWrite : std_logic;
signal cu_RegDst : std_logic;
signal cu_PCWriteCond : std_logic;
signal cu_PCWrite : std_logic;
signal cu_IorD : std_logic;
signal cu_MemRead : std_logic;
signal cu_MemWrite : std_logic;
signal cu_MemToReg : std_logic;
signal cu_IRWrite : std_logic;

signal s : std_logic; -- sign of the immediate

signal four : std_logic_vector (width - 1 downto 0) := (2 <= '1', others => '0');

type memory is array (0 to instr_memory_size - 1) of std_logic_vector (width - 1 downto 0);

begin

s <= instr_15_0(14);

sign_extended <= (( 15 downto 0 ) <= instr_15_0, others => s);
sign_extended_shifted <= sign_extended(13 downto 0) & "00";

instreg_memdata <= memory(pc_pc_out);

alu_a <= pc_pc_out when cu_ALUSrcA = '0' else reg_readport0;

alu_b <= reg_readport1 when cu_ALUSrcB = "00" else 
		 four when cu_ALUSrcB = "01" else
		 sign_extended when cu_ALUSrcB = "10" else
		 sign_extended_shifted when cu_ALUSrcB = "11";

pc_pc_in <= alu_result when cu_PCSource = "00" else
			-- todo change to alu_result_out
			alu_result when cu_PCSource = "01" else
			-- todo change
			alu_result when cu_PCSource = "10" else
			alu_result;

reg_adrport0 <= instr_25_21;
reg_adrport1 <= instr_20_16;
reg_adrwport <= instr_20_16 when cu_RegDst = '0' else instr_15_0(15 downto 11);
reg_writeport <= alu_result when cu_MemToReg = '0' else instreg_memdata;
			
alu_m : alu port map (
			a => alu_a, b => alu_b, opcode => alu_opcode, result => alu_result
		);
instreg_m : instreg port map (
			clk => clk, rst_n => cu_reset, memdata => instreg_memdata, IRWrite => cu_IRWrite,
			instr_31_26 => instr_31_26, instr_25_21 => instr_25_21, instr_20_16 => instr_20_16, instr_15_0 => instr_15_0
		);
pc_m : pc port map (
			clk => clk, rst_n => cu_reset, pc_in => pc_pc_in, PC_en => cu_PCWrite,
			pc_out => pc_pc_out
		);

reg_m : regfile port map (
			clk => clk, wen => cu_RegWrite, rst_n => cu_reset, 
			writeport => reg_writeport, adrwport => reg_adrwport, adrport0 => reg_adrport0, adrport1 => reg_adrport1, 
			readport0 => reg_readport0, readport1 => reg_readport1
		);
		
control_u : control_unit port map (
			clk => clk, reset => cu_reset, op => instr_31_26,
			RegDst => cu_RegDst, RegWrite => cu_RegWrite, ALUSrcA => cu_ALUSrcA, MemRead => cu_MemRead,
			MemWrite => cu_MemWrite, MemtoReg => cu_MemToReg, IorD => cu_IorD, IRWrite => cu_IRWrite, PCWrite => cu_PCWrite,
			PcWriteCond => cu_PCWriteCond, ALUOp => cu_ALUOp, ALUSrcB => cu_ALUSrcB, PCSource => cu_PCSource		
	);
			
			
end Behavioral;

