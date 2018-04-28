using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VirtualMemory
{
    public class Process
    {
        public int Pid { get; set; }
        private readonly VirtualMemory _memory;

        public Process(VirtualMemory virtualMemory)
        {
            _memory = virtualMemory;
        }

        public byte ReadMemory(int address)
        {
            return _memory.ReadContent(address);
        }

        public void WriteMemory(int address, byte toWrite)
        {
            _memory.WriteContent(address, toWrite);
        }
    }
}
