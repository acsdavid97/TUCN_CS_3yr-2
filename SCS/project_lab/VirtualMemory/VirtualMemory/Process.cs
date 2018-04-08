using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VirtualMemory
{
    class Process
    {
        public int Pid { get; set; }
        private readonly VirtualMemory _memory;

        public Process()
        {
            _memory = new VirtualMemory();
        }

        public byte ReadMemory(Address address)
        {
            return _memory.ReadContent(address);
        }

        public void WriteMemory(Address address, byte toWrite)
        {
            _memory.WriteContent(address, toWrite);
        }
    }
}
