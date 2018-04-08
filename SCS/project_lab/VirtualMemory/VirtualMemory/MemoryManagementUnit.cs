using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VirtualMemory
{
    class MemoryManagementUnit
    {
        private VirtualMemory _virtualMemory;
        private PhysicalMemory _physicalMemory;
        private IList<PageTableEntry> _pageTable;

        public Page GetPhysicalPage(Process process, Page virtualPage)
        {
            return null;
        }
    }
}
