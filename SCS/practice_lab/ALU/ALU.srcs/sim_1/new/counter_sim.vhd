----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.03.2018 16:41:04
-- Design Name: 
-- Module Name: counter_sim - Behavioral
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

entity counter_sim is
--  Port ( );
end counter_sim;



architecture Behavioral of counter_sim is

component Counter is
    Port (
    clk : in std_logic; 
    count : out STD_LOGIC_VECTOR (3 downto 0)
    );
end component;

signal clk : std_logic := '0';
signal coun : std_logic_vector (3 downto 0);

begin
clk <= not clk after 50 ns;
couuount : Counter port map (clk => clk, count => coun);

end Behavioral;