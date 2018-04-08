using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VirtualMemory
{
    class PhysicalMemory : Memory
    {
        public static readonly int PageCount = 1 << 21;

        public PhysicalMemory() : base(PageCount)
        {
        }
    }
}
