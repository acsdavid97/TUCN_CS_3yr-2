library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
--use package
use work.mips_package.all;

entity instreg is
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
end instreg;

architecture behave of instreg is
begin
	proc_instreg : process (clk, rst_n)
	begin
		if rst_n = '0' then
			instr_31_26 <= (others => '0');
			instr_25_21 <= (others => '0');
			instr_20_16 <= (others => '0');
			instr_15_0 <= (others => '0');
		elsif RISING_EDGE(clk) then
			-- write the output of the memory into the instruction register
			if (IRWrite = '1') then
				instr_31_26 <= memdata(31 downto 26);
				instr_25_21 <= memdata(25 downto 21);
				instr_20_16 <= memdata(20 downto 16);
				instr_15_0 <= memdata(15 downto 0);
			end if;
		end if;
	end process;
end behave;