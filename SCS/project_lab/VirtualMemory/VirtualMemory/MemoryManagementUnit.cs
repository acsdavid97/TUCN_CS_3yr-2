using System.Collections.Generic;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;

namespace VirtualMemory
{
    public abstract class MemoryManagementUnit
    {
        public Dictionary<int, int> VirtToPhys { get; }
        public Dictionary<int, int> PhysToVirt { get; }
        public Dictionary<int, int> VirtToSwap { get; }
        public Dictionary<int, int> SwapToVirt { get; }

        public readonly PhysicalMemory PhysicalMemory;
        public readonly SwapMemory Swap;

        protected MemoryManagementUnit(PhysicalMemory physicalMemory, SwapMemory swap)
        {
            VirtToPhys = new Dictionary<int, int>();
            PhysToVirt = new Dictionary<int, int>();
            VirtToSwap = new Dictionary<int, int>();
            SwapToVirt = new Dictionary<int, int>();

            PhysicalMemory = physicalMemory;
            Swap = swap;
        }

        public int VirtualToPhysical(int virtualAddress)
        {
            var virtualIndexOffset = Utilities.AddressToIndexOffset(virtualAddress);

            // if virtual page is mapped in physical memory
            if (VirtToPhys.ContainsKey(virtualIndexOffset.Index))
            {
                return VirtualIndexOffsetToPhysicalAddress(virtualIndexOffset);
            }

            // if virtual page is in the swap
            if (VirtToSwap.ContainsKey(virtualIndexOffset.Index))
            {
                var pageToReplaceIndex = GetPageToReplace(virtualIndexOffset);
                ReplacePage(virtualIndexOffset, pageToReplaceIndex);
                return VirtualIndexOffsetToPhysicalAddress(virtualIndexOffset);
            }
            
            // find an empty physical page 
            for (var physicalIndex = 0; physicalIndex < PhysicalMemory.PageCount; physicalIndex++)
            {
                if (!PhysToVirt.ContainsKey(physicalIndex))
                {
                    MapPhysicalAndVirtual(physicalIndex, virtualIndexOffset.Index);
                    return VirtualIndexOffsetToPhysicalAddress(virtualIndexOffset);
                }
            }

            
            // find an empty swap page
            for (var swapIndex = 0; swapIndex < PhysicalMemory.PageCount; swapIndex++)
            {
                if (!SwapToVirt.ContainsKey(swapIndex))
                {
                    MapSwapAndVirtual(swapIndex, virtualIndexOffset.Index);

                    // bring the newly created swap page in memory
                    var pageIndexToReplace = GetPageToReplace(virtualIndexOffset);
                    ReplacePage(virtualIndexOffset, pageIndexToReplace);

                    return VirtualIndexOffsetToPhysicalAddress(virtualIndexOffset);
                }
            }

            throw new MemoryFullException();
        }

        public abstract int GetPageToReplace(PageIndexOffset virtualAddress);

        public void ReplacePage(PageIndexOffset virtualAddress, int pageIndexToReplace)
        {
            var swapIndex = VirtToSwap[virtualAddress.Index];
            
            // swap pages
            var pageToReplace = PhysicalMemory.Pages[pageIndexToReplace];
            PhysicalMemory.Pages[pageIndexToReplace] = Swap.Pages[swapIndex];
            Swap.Pages[swapIndex] = pageToReplace;

            // update swap mappings
            SwapToVirt.Remove(swapIndex);
            VirtToSwap.Remove(virtualAddress.Index);

            var physToReplaceVirtual = PhysToVirt[pageIndexToReplace];
            MapSwapAndVirtual(swapIndex, physToReplaceVirtual);

            // update physical mappings
            MapPhysicalAndVirtual(pageIndexToReplace, virtualAddress.Index);
        }

        private int VirtualIndexOffsetToPhysicalAddress(PageIndexOffset virtualIndexOffset)
        {
                var translatedIndexOffset = new PageIndexOffset
                {
                    Index = VirtToPhys[virtualIndexOffset.Index],
                    Offset = virtualIndexOffset.Offset
                };
                return Utilities.IndexOffsetToAddress(translatedIndexOffset);
        }

        protected virtual void MapPhysicalAndVirtual(int physicalIndex, int virtualIndex)
        {
            if (PhysToVirt.ContainsKey(physicalIndex))
            {
                var prevVirtualIndex = PhysToVirt[physicalIndex];
                PhysToVirt.Remove(physicalIndex);
                VirtToPhys.Remove(prevVirtualIndex);
            }
            VirtToPhys[virtualIndex] = physicalIndex;
            PhysToVirt[physicalIndex] = virtualIndex;
        }

        protected virtual void MapSwapAndVirtual(int swapIndex, int virtualIndex)
        {
            SwapToVirt[swapIndex] = virtualIndex;
            VirtToSwap[virtualIndex] = swapIndex;
        }
    }
}
