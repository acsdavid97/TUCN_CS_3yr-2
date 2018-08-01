----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.05.2018 17:33:48
-- Design Name: 
-- Module Name: driver - Behavioral
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

entity driver is
  Port (
    clk : in std_logic;
    addr : in std_logic_vector(23 downto 0);
    we : in STD_LOGIC;
    en : in STD_LOGIC;
    content : out STD_LOGIC_VECTOR (7 downto 0);
    toWrite : in STD_LOGIC_VECTOR (7 downto 0)
  );
end driver;

architecture Behavioral of driver is

component memory32bx32byte is
    Port ( clk : in std_logic;
           address : in STD_LOGIC_VECTOR (15 downto 0);
           we : in STD_LOGIC;
           en : in STD_LOGIC;
           content : out STD_LOGIC_VECTOR (255 downto 0);
           toWrite : in STD_LOGIC_VECTOR (255 downto 0));
end component;

component tag_memory is
    Port ( clk : in std_logic;
           address : in STD_LOGIC_VECTOR (12 downto 0);
           we : in STD_LOGIC;
           en : in STD_LOGIC;
           content : out STD_LOGIC_VECTOR (5 downto 0);
           toWrite : in STD_LOGIC_VECTOR (5 downto 0));
end component;

component cache_memory is
    Port ( clk : in std_logic;
           address : in STD_LOGIC_VECTOR (12 downto 0);
           we : in STD_LOGIC;
           en : in STD_LOGIC;
           content : out STD_LOGIC_VECTOR (255 downto 0);
           toWrite : in STD_LOGIC_VECTOR (255 downto 0));
end component;

signal mem_content : std_logic_vector(255 downto 0);
signal upper_addr : std_logic_vector(15 downto 0);
signal block_addr : std_logic_vector(12 downto 0);
signal lower_addr : std_logic_vector(4 downto 0);
signal mem_we : std_logic;

begin

upper_addr <= addr(23 downto 8);
block_addr <= upper_addr(12 downto 0);

main_mem : memory32bx32byte port map (clk => clk, address => upper_addr, we => mem_we, en=>'1', content => mem_content, toWrite => toWrite);
tag_mem : tag_memory port map (clk => clk, address =>  

end Behavioral;
