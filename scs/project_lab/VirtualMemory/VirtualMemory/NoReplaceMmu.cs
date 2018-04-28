using System;

namespace VirtualMemory
{
    public class NoReplaceMmu : MemoryManagementUnit
    {
        public NoReplaceMmu(PhysicalMemory physicalMemory, SwapMemory swap) : base(physicalMemory, swap)
        {
        }

        public override int GetPageToReplace(PageIndexOffset virtualAddress)
        {
            throw new NotImplementedException();
        }
    }
}