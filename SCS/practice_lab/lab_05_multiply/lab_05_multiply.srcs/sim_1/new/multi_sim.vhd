----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.03.2018 16:47:39
-- Design Name: 
-- Module Name: multi_sim - Behavioral
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

entity multi_sim is
--  Port ( );
end multi_sim;

architecture Behavioral of multi_sim is

component mulplier is
    Port ( clk : in std_logic;
           A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           L : in STD_LOGIC;
           R : out STD_LOGIC_VECTOR (7 downto 0));
end component;

signal clk : std_logic := '0';
signal load : std_logic := '1';
signal result : std_logic_vector(7 downto 0);

begin

clk <= not clk after 50 ns;
load <= '0' after 75 ns;
multip : mulplier port map (clk => clk, A => "1010", B => "0101", L => load, R => result);

end Behavioral;
