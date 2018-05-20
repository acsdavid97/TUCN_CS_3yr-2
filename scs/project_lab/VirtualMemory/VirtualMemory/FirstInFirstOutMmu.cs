using System;
using System.Collections.Generic;

namespace VirtualMemory
{
    public class FirstInFirstOutMmu : MemoryManagementUnit
    {
        private readonly Queue<int> _pageQueue;

        public FirstInFirstOutMmu(PhysicalMemory physicalMemory, SwapMemory swap) : base(physicalMemory, swap)
        {
            _pageQueue = new Queue<int>();
        }

        public override int GetPageToReplace(PageIndexOffset virtualAddress)
        {
            var pageIndexToReplace = _pageQueue.Dequeue();
            return pageIndexToReplace;

        }

        protected override void MapPhysicalAndVirtual(int physicalIndex, int virtualIndex)
        {
            base.MapPhysicalAndVirtual(physicalIndex, virtualIndex);
            _pageQueue.Enqueue(physicalIndex);
        }
    }
}