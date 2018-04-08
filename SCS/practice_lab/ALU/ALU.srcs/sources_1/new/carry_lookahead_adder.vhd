----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.03.2018 19:12:54
-- Design Name: 
-- Module Name: carry_lookahead_adder - Behavioral
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

entity carry_lookahead_adder is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           b : in STD_LOGIC_VECTOR (3 downto 0);
           cin : in STD_LOGIC;
           s : out STD_LOGIC_VECTOR (4 downto 0));
end carry_lookahead_adder;

architecture Behavioral of carry_lookahead_adder is

component carry_lookahead_generate is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           b : in STD_LOGIC_VECTOR (3 downto 0);
           cin : in STD_LOGIC;
           cout : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component full_adder is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           cin : in STD_LOGIC;
           s : out STD_LOGIC;
           cout : out STD_LOGIC);
end component;

signal couts : std_logic_vector (2 downto 0);

begin

carry_generate : carry_lookahead_generate port map (a => a, b => b, cin => cin, cout => couts);

s0 : full_adder port map (a => a(0), b => b(0), cin => cin, s => s(0));
s1 : full_adder port map (a => a(1), b => b(1), cin => couts(0), s => s(1));
s2 : full_adder port map (a => a(2), b => b(2), cin => couts(1), s => s(2));
s3 : full_adder port map (a => a(3), b => b(3), cin => couts(2), s => s(3), cout => s(4));

end Behavioral;
