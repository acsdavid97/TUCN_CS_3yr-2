namespace ComputerMemory
{
    public class Computer
    {
        private Memory _theMemory;

        public Computer(Computer another)
        {
            if (another._theMemory is Memory1)
            {
                _theMemory = new Memory1(another._theMemory);
            }
            else
            {
                _theMemory = new Memory(another._theMemory);
            }
        }
    }
}