using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VirtualMemory
{
    class Address
    {
        public Address(int offset)
        {
            Offset = offset;
        }

        public int Offset { get; }
    }
}
