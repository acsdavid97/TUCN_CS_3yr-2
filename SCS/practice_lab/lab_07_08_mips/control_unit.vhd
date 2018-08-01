----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:09:31 05/07/2018 
-- Design Name: 
-- Module Name:    control_unit - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity control_unit is
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
end control_unit;

architecture Behavioral of control_unit is

TYPE State_type IS (
	instr_fetch, 
	instr_decode, 
	memory_addr_comp, 
	mem_read,
	mem_read_comp,
	mem_access,
	execution,
	r_type_comp,
	branch_comp,
	jmp_comp
	);  -- Define the states
SIGNAL State : State_Type;    -- Create a signal that uses the different states

begin
	-- state transition
	process (clk)
	begin
		if rising_edge(clk) then
			if reset = '1' then
				state <= instr_fetch;
			end if;
			
			case State is 
				-- 0
				when instr_fetch =>
					state <= instr_decode;
				-- 1
				when instr_decode =>
					case op is
						-- sw
						when "101011" =>
							state <= memory_addr_comp;
						-- lw
						when "100011" =>
							state <= memory_addr_comp;
						when "000000" =>
							state <= execution;
						when others =>
							state <= instr_fetch;
					end case;
				-- 2
				when memory_addr_comp =>
					case op is
						-- sw
						when "101011" =>
							state <= mem_access;
						-- lw
						when "100011" =>
							state <= mem_read;
						when others =>
							state <= instr_fetch;
					end case;
				-- 3
				when mem_read =>
					state <= mem_read_comp;
				-- 4
				when mem_read_comp =>
					state <= instr_fetch;
				-- 5
				when mem_access =>
					state <= instr_fetch;
				-- 6
				when execution =>
					state <= r_type_comp;
				-- 7
				when r_type_comp =>
					state <= instr_fetch;
				-- 8
				when branch_comp =>
					state <= instr_fetch;
				-- 9
				when jmp_comp =>
					state <= instr_fetch;
			end case;
				
		end if;
	end process;
	
	-- output signals
	process (clk)
	begin
		if rising_edge(clk) then
			case State is 
				-- 0
				when instr_fetch =>
					RegDst <= '0';
					RegWrite <= '0';
					ALUSrcA <= '0';
					MemRead <= '1';
					MemWrite <= '0';
					MemToReg <= '0';
					IorD <= '0';
					IRWrite <= '1';
					PCWrite <= '1';
					PCWriteCond <= '0';
					ALUOp <= "00";
					ALUSrcB <= "01";
					PCSource <= "00";
					
				-- 1 
				when instr_decode =>
					RegDst <= '0';
					RegWrite <= '0';
					ALUSrcA <= '0';
					MemRead <= '0';
					MemWrite <= '0';
					MemToReg <= '0';
					IorD <= '0';
					IRWrite <= '0';
					PCWrite <= '0';
					PCWriteCond <= '0';
					ALUOp <= "00";
					ALUSrcB <= "11";
					PCSource <= "00";
					
				-- 2
				when memory_addr_comp =>
					RegDst <= '0';
					RegWrite <= '0';
					ALUSrcA <= '0';
					MemRead <= '0';
					MemWrite <= '0';
					MemToReg <= '0';
					IorD <= '0';
					IRWrite <= '0';
					PCWrite <= '0';
					PCWriteCond <= '0';
					ALUOp <= "00";
					ALUSrcB <= "11";
					PCSource <= "00";	
					
				-- 3
				when mem_read =>
					RegDst <= '0';
					RegWrite <= '0';
					ALUSrcA <= '1';
					MemRead <= '1';
					MemWrite <= '0';
					MemToReg <= '0';
					IorD <= '1';
					IRWrite <= '0';
					PCWrite <= '0';
					PCWriteCond <= '0';
					ALUOp <= "00";
					ALUSrcB <= "10";
					PCSource <= "00";	

				-- 4
				when mem_read_comp =>
					RegDst <= '0';
					RegWrite <= '1';
					ALUSrcA <= '1';
					MemRead <= '0';
					MemWrite <= '0';
					MemToReg <= '1';
					IorD <= '0';
					IRWrite <= '0';
					PCWrite <= '0';
					PCWriteCond <= '0';
					ALUOp <= "00";
					ALUSrcB <= "10";
					PCSource <= "00";	
				-- 5
				when mem_access =>
					RegDst <= '0';
					RegWrite <= '0';
					ALUSrcA <= '1';
					MemRead <= '0';
					MemWrite <= '1';
					MemToReg <= '0';
					IorD <= '1';
					IRWrite <= '0';
					PCWrite <= '0';
					PCWriteCond <= '0';
					ALUOp <= "00";
					ALUSrcB <= "10";
					PCSource <= "00";	
				-- 6
				when execution =>
					RegDst <= '0';
					RegWrite <= '0';
					ALUSrcA <= '1';
					MemRead <= '0';
					MemWrite <= '0';
					MemToReg <= '0';
					IorD <= '0';
					IRWrite <= '0';
					PCWrite <= '0';
					PCWriteCond <= '0';
					ALUOp <= "10";
					ALUSrcB <= "00";
					PCSource <= "00";
				-- 7
				when r_type_comp =>
					RegDst <= '1';
					RegWrite <= '1';
					ALUSrcA <= '1';
					MemRead <= '0';
					MemWrite <= '0';
					MemToReg <= '0';
					IorD <= '0';
					IRWrite <= '0';
					PCWrite <= '0';
					PCWriteCond <= '0';
					ALUOp <= "10";
					ALUSrcB <= "00";
					PCSource <= "00";
				-- 8
				when branch_comp =>
					RegDst <= '0';
					RegWrite <= '0';
					ALUSrcA <= '1';
					MemRead <= '0';
					MemWrite <= '0';
					MemToReg <= '0';
					IorD <= '0';
					IRWrite <= '0';
					PCWrite <= '0';
					PCWriteCond <= '1';
					ALUOp <= "01";
					ALUSrcB <= "00";
					PCSource <= "01";
				-- 9
				when jmp_comp =>
					RegDst <= '0';
					RegWrite <= '0';
					ALUSrcA <= '0';
					MemRead <= '0';
					MemWrite <= '0';
					MemToReg <= '0';
					IorD <= '0';
					IRWrite <= '0';
					PCWrite <= '1';
					PCWriteCond <= '0';
					ALUOp <= "00";
					ALUSrcB <= "11";
					PCSource <= "10";
			end case;
		end if;
	end process;
				

end Behavioral;

