----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.03.2018 19:17:22
-- Design Name: 
-- Module Name: carry_lookahead_generate - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity carry_lookahead_generate is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           b : in STD_LOGIC_VECTOR (3 downto 0);
           cin : in STD_LOGIC;
           cout : out STD_LOGIC_VECTOR (2 downto 0));
end carry_lookahead_generate;

architecture Behavioral of carry_lookahead_generate is

signal g : std_logic_vector(2 downto 0);
signal p : std_logic_vector(2 downto 0);

signal cout_temp : std_logic_vector(2 downto 0);

begin

g <= a(2 downto 0) and b(2 downto 0);
p <= a(2 downto 0) or b(2 downto 0);

cout_temp(0) <= g(0) or (p(0) and cin);
cout_temp(1) <= g(1) or (p(1) and cout_temp(0));
cout_temp(2) <= g(2) or (p(2) and cout_temp(1));

cout <= cout_temp; 

end Behavioral;
