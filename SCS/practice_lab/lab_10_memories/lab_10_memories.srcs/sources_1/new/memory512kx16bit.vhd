----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.05.2018 18:28:56
-- Design Name: 
-- Module Name: memory512kx16bit - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memory512kx16bit is
    Port ( clk : in std_logic;
           address : in STD_LOGIC_VECTOR (23 downto 0);
           we : in STD_LOGIC;
           en0 : in STD_LOGIC;
           en1 : in STD_LOGIC;
           content : out STD_LOGIC_VECTOR (15 downto 0);
           toWrite : in STD_LOGIC_VECTOR (15 downto 0));
end memory512kx16bit;

architecture Behavioral of memory512kx16bit is

component memory64kx16bit is
    Port ( clk : in std_logic;
           address : in STD_LOGIC_VECTOR (15 downto 0);
           we : in STD_LOGIC;
           en0 : in STD_LOGIC;
           en1 : in STD_LOGIC;
           content : out STD_LOGIC_VECTOR (15 downto 0);
           toWrite : in STD_LOGIC_VECTOR (15 downto 0));
end component;

type arr is array (0 to 7) of std_logic_vector(15 downto 0);
signal ens : std_logic_vector(7 downto 0);
signal contents : arr;
signal sel : std_logic_vector(2 downto 0);

begin

sel <= address(18 downto 16);

gen : for I in 0 to 7 generate
signal en0_s : std_logic;
signal en1_s : std_logic;
begin
    en0_s <= ens(I) and en0;
    en1_s <= ens(I) and en1;
    
    REGX : memory64kx16bit port map(clk => clk, address => address(15 downto 0), we => we, en0 => en0_s, en1 => en1_s,  
                                    content => contents(I), toWrite => toWrite
                                    );
end generate;

-- ens <= (to_integer(unsigned(sel)) => '1', others => '0');
ens <= "00000001" when sel = "000" else
       "00000010" when sel = "001" else
       "00000100" when sel = "010" else
       "00001000" when sel = "011" else
       "00010000" when sel = "100" else
       "00100000" when sel = "101" else
       "01000000" when sel = "110" else
       "10000000" when sel = "111";
content <= contents(to_integer(unsigned(sel)));
end Behavioral;
