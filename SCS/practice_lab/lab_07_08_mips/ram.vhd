----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/17/2017 09:24:30 AM
-- Design Name: 
-- Module Name: ram - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rams_no_change is
    port ( clk : in std_logic;
    we : in std_logic;
    en : in std_logic;
    addr : in std_logic_vector(width - 1 downto 0);
    di : in std_logic_vector(width - 1 downto 0);
    do : out std_logic_vector(width - 1 downto 0));
end rams_no_change;

architecture syn of rams_no_change is
type ram_type is array (0 to 2**width) of std_logic_vector (width - 1 downto 0);
signal RAM: ram_type:= (
    x"0000",
    x"0000",
    x"0003",
    others => x"0000"
    );
    
begin
    process (clk)
    begin
        if clk'event and clk = '1' then
            if en = '1' then
                if we = '1' then
                    RAM(conv_integer(addr)) <= di; 
                end if;
            end if;
        end if;
        do <= RAM( conv_integer(addr));
    end process;
end syn;
