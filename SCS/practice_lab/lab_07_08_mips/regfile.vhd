library IEEE;
use IEEE.std_logic_1164.all;
-- use package
use work.mips_package.all;

entity regfile is
	port 
	(
		clk, rst_n : in std_ulogic;
		wen : in std_ulogic; -- write control
		writeport : in std_ulogic_vector(width - 1 downto 0);
		-- register input
		adrwport : in std_ulogic_vector(regfile_adrsize - 1 DOWNTO 0);-- address write
		adrport0 : in std_ulogic_vector(regfile_adrsize - 1 DOWNTO 0);-- address port 0
		adrport1 : in std_ulogic_vector(regfile_adrsize - 1 DOWNTO 0);-- address port 1
		readport0 : out std_ulogic_vector(width - 1 downto 0);
		-- output port 0
		readport1 : out std_ulogic_vector(width - 1 downto 0)
		-- output port 1
	);
end regfile;

architecture behave of regfile is
	subtype WordT is std_ulogic_vector(width - 1 downto 0); -- reg word TYPE
	type StorageT is array(0 to regfile_depth - 1) of WordT; -- reg array TYPE
	signal registerfile : StorageT; -- reg file contents
begin
	-- perform write operation
	process (rst_n, clk)
	begin
		if rst_n = '0' then
			for i in 0 to regfile_depth - 1 loop
				registerfile(i) <= (others => '0');
			end loop;
		elsif rising_edge(clk) then
			if wen = '1' then
				registerfile(to_integer(unsigned(adrwport))) <= writeport;
			end if;
		end if;
	end process;
	-- perform reading ports
	readport0 <= registerfile(to_integer(unsigned(adrport0)));
	readport1 <= registerfile(to_integer(unsigned(adrport1)));
end behave;