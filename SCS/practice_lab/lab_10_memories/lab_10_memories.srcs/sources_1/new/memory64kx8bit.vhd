----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.05.2018 18:18:39
-- Design Name: 
-- Module Name: memory64kx8bit - Behavioral
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
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memory64kx8bit is
    Port ( clk : in std_logic;
           address : in STD_LOGIC_VECTOR (15 downto 0);
           we : in STD_LOGIC;
           en : in STD_LOGIC;
           content : out STD_LOGIC_VECTOR (7 downto 0);
           toWrite : in STD_LOGIC_VECTOR (7 downto 0));
end memory64kx8bit;

architecture Behavioral of memory64kx8bit is

type memory is array(0 to 2**16) of std_logic_vector(7 downto 0);
signal ram : memory := (others => "00000000");

begin

process(clk)
begin
    if rising_edge(clk) then
        if (en = '1') then
            if (we = '1') then
                ram(to_integer(unsigned(address))) <= toWrite;
            end if;
        content <= ram(to_integer(unsigned(address)));
        end if;
    end if;
end process;

end Behavioral;
