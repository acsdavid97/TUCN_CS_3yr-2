library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
-- use package
use work.mips_package.all;

entity pc is
	port 
	(
		clk : in STD_ULOGIC;
		rst_n : in STD_ULOGIC;
		pc_in : in STD_ULOGIC_VECTOR(width - 1 downto 0);
		PC_en : in STD_ULOGIC;
		pc_out : out STD_ULOGIC_VECTOR(width - 1 downto 0) 
	);
end pc;
architecture behave of pc is
begin
	proc_pc : process (clk, rst_n)
		variable pc_temp : STD_ULOGIC_VECTOR(width - 1 downto 0);
	begin
		if rst_n = '0' then
			pc_temp := (others => '0');
		elsif RISING_EDGE(clk) then
			if PC_en = '1' then
				pc_temp := pc_in;
			end if;
		end if;
		pc_out <= pc_temp;
	end process;
end behave;