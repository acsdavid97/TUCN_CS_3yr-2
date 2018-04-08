----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.03.2018 18:56:48
-- Design Name: 
-- Module Name: ripple_carry_adder - Behavioral
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

entity ripple_carry_adder is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           b : in STD_LOGIC_VECTOR (3 downto 0);
           cin : in STD_LOGIC;
           s : out STD_LOGIC_VECTOR (4 downto 0));
end ripple_carry_adder;

architecture Behavioral of ripple_carry_adder is

component full_adder is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           cin : in STD_LOGIC;
           s : out STD_LOGIC;
           cout : out STD_LOGIC);
end component;

signal cout0 : std_logic;
signal cout1 : std_logic;
signal cout2 : std_logic;

begin

s0 : full_adder port map (a => a(0), b => b(0), cin => cin, s => s(0), cout => cout0);
s1 : full_adder port map (a => a(1), b => b(1), cin => cout0, s => s(1), cout => cout1);
s2 : full_adder port map (a => a(2), b => b(2), cin => cout1, s => s(2), cout => cout2);
s3 : full_adder port map (a => a(3), b => b(3), cin => cout2, s => s(3), cout => s(4));

end Behavioral;
