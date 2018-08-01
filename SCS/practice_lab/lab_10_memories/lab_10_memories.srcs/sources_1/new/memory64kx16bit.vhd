----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.05.2018 18:32:50
-- Design Name: 
-- Module Name: memory64kx16bit - Behavioral
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

entity memory64kx16bit is
  Port ( clk : in std_logic;
         address : in STD_LOGIC_VECTOR (15 downto 0);
         we : in STD_LOGIC;
         en0 : in STD_LOGIC;
         en1 : in STD_LOGIC;
         content : out STD_LOGIC_VECTOR (15 downto 0);
         toWrite : in STD_LOGIC_VECTOR (15 downto 0)
   );
end memory64kx16bit;

architecture Behavioral of memory64kx16bit is

component memory64kx8bit is
    Port ( clk : in std_logic;
           address : in STD_LOGIC_VECTOR (15 downto 0);
           we : in STD_LOGIC;
           en : in STD_LOGIC;
           content : out STD_LOGIC_VECTOR (7 downto 0);
           toWrite : in STD_LOGIC_VECTOR (7 downto 0));
end component;

signal content_0 : std_logic_vector(7 downto 0);
signal content_1 : std_logic_vector(7 downto 0);

begin

m1 : memory64kx8bit port map (clk => clk, address => address, we => we, en => en0, content => content_0, toWrite => toWrite(15 downto 8) );

m2 : memory64kx8bit port map (clk => clk, address => address, we => we, en => en1, content => content_1, toWrite => toWrite(7 downto 0) );

content <= content_0 & content_1 when (en0 = '1' and en1 = '1') else
           "00000000" & content_1 when (en1 = '1' and en0 = '0') else
           content_0 & "00000000" when (en1 = '0' and en0 = '1') else
           "0000000000000000";

end Behavioral;
