using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VirtualMemory
{
    class VirtualMemory : Memory
    {
        public static readonly int PageCount = 1 << 42;

        public VirtualMemory() : base(PageCount)
        {
        }
    }
}
