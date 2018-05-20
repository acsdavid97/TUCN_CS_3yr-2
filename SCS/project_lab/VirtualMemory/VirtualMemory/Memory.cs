using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VirtualMemory
{
    interface IMemory
    {
        byte ReadContent(int address);
        void WriteContent(int address, byte toWrite);
    }
}
