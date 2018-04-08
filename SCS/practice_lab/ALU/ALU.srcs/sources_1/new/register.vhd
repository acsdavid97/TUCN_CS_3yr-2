----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.03.2018 18:30:51
-- Design Name: 
-- Module Name: register - Behavioral
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

entity regist is
    Port ( clk : in STD_LOGIC;
           ce : in STD_LOGIC;
           d : in STD_LOGIC;
           q : out STD_LOGIC);
end regist;

architecture Behavioral of regist is

signal sta : std_logic := '0';

begin

process(clk)
begin
    if (rising_edge(clk)) then
        if (ce = '1') then
            sta <= d;
        end if;
    end if;
end process;

q <= sta;

end Behavioral;
