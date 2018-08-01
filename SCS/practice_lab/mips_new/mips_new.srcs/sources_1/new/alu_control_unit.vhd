LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
use IEEE.std_logic_unsigned.all;
-- use package
use work.mips_package.all;


ENTITY alu_control_unit IS
	PORT (
		cu_ALUOp : IN STD_ULOGIC_VECTOR(1 DOWNTO 0);
		func : IN STD_ULOGIC_VECTOR(5 downto 0);
		ALUOp : OUT STD_ULOGIC_VECTOR(1 DOWNTO 0)
	);
END alu_control_unit;

ARCHITECTURE behave OF alu_control_unit IS


BEGIN

    ALUOp <= cu_ALUOp when cu_ALUOp /= "10" else
             "00" when func = "100000" else
             "01" when func = "100010" else
             "10" when func = "100100" else
             "11" when func = "100101";

end architecture;