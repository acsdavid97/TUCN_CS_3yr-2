using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VirtualMemory
{
    class PageTableEntry
    {
        public Process Process { get; set; }
        public Page VirtualPage { get; set; }
        public Page PhysicalPage { get; set; }
        public bool IsPresentInPhysicalMemory { get; set; }
    }
}
