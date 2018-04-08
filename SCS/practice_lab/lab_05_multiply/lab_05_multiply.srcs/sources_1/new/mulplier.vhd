----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.03.2018 16:26:25
-- Design Name: 
-- Module Name: mulplier - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.STD_LOGIC_1164.arith;
use IEEE.STD_LOGIC_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mulplier is
    Port ( clk : in std_logic;
           A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           L : in STD_LOGIC;
           R : out STD_LOGIC_VECTOR (7 downto 0));
end mulplier;

architecture Behavioral of mulplier is

signal A_reg : std_logic_vector(3 downto 0) := "0000";
signal B_reg : std_logic_vector(3 downto 0) := "0101";
signal A_bitwise : std_logic_vector(3 downto 0) := "0000";
signal A_bitwise_ext : std_logic_vector(7 downto 0) := "00000000";
signal Partial_result_shifted : std_logic_vector(7 downto 0) := "00000000";
signal Partial_result_added : std_logic_vector(7 downto 0) := "00000000";
signal Partial_result : std_logic_vector(7 downto 0) := "00000000";

begin

process (clk)
begin
    if (rising_edge(clk)) then
        if (L = '1') then
            A_reg <= A;
         end if;
    end if;
end process;

process (clk)
begin
    if (rising_edge(clk)) then
        if (L = '1') then
            B_reg <= B;
        else
            B_reg <= "0" & B_reg(3 downto 1);
        end if;
    end if;
end process;

A_bitwise <= A_reg when B_reg(0) = '1' else "0000";

A_bitwise_ext <= A_bitwise & "0000";
 
Partial_result_added <= A_bitwise_ext + Partial_result_shifted;

process (clk)
begin
    if (rising_edge(clk)) then
        if (L = '1') then
            Partial_result <= "00000000";
        else
            Partial_result <= Partial_result_added;
        end if;
    end if;
end process;

Partial_result_shifted <= "0" & Partial_result(7 downto 1);

R <= "0" & Partial_result_added(7 downto 1);
    
end Behavioral;
