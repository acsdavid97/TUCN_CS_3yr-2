using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VirtualMemory
{
    public abstract class MmuLogEntry
    {
        protected MmuLogEntry(string message)
        {
            Message = message;
        }

        public string Message { get; set; }

        public override string ToString()
        {
            return Message;
        }

        protected bool Equals(MmuLogEntry other)
        {
            return string.Equals(Message, other.Message);
        }

        public override bool Equals(object obj)
        {
            if (ReferenceEquals(null, obj)) return false;
            if (ReferenceEquals(this, obj)) return true;
            if (obj.GetType() != this.GetType()) return false;
            return Equals((MmuLogEntry) obj);
        }

        public override int GetHashCode()
        {
            return (Message != null ? Message.GetHashCode() : 0);
        }
    }

    public class NoMoreMemoryMmuLogEntry : MmuLogEntry
    {
        public NoMoreMemoryMmuLogEntry(int virtualAddress) 
            : base($"Virtual address: {virtualAddress} does not correspond to any page, and we could not allocate any new pages")
        {
        }
    }

    public class NewSwapMemoryMmuLogEntry : MmuLogEntry
    {
        public int VirtualAddress { get; }
        public int NewSwapPageIndex { get; }
        public int ReplacePhysicalPageIndex { get; }

        public NewSwapMemoryMmuLogEntry(int virtualAddress, int newSwapPageIndex, int replacePhysicalPageIndex) 
            : base($"Virtual address: {virtualAddress} is put in new swap page: {newSwapPageIndex}, which is swapped in place of {replacePhysicalPageIndex}")
        {
            VirtualAddress = virtualAddress;
            NewSwapPageIndex = newSwapPageIndex;
            ReplacePhysicalPageIndex = replacePhysicalPageIndex;
        }
    }

    public class NewPhysicalMemoryMmuLogEntry : MmuLogEntry
    {
        public int VirtualAddress { get; }
        public int PhysicalPageIndex { get; }

        public NewPhysicalMemoryMmuLogEntry(int virtualAddress, int physicalPageIndex) 
            : base($"Virtual address: {virtualAddress} is put in new physical page: {physicalPageIndex}")
        {
            VirtualAddress = virtualAddress;
            PhysicalPageIndex = physicalPageIndex;
        }
    }

    public class InSwapMemoryMmuLogEntry : MmuLogEntry
    {
        public int VirtualAddress { get; }
        public int SwapPageIndex { get; }
        public int PhysicalPageIndex { get; }

        public InSwapMemoryMmuLogEntry(int virtualAddress, int swapPageIndex, int physicalPageIndex) 
            : base($"Virtual address: {virtualAddress} found in swap page: {swapPageIndex} swapped with physical page: {physicalPageIndex}")
        {
            VirtualAddress = virtualAddress;
            SwapPageIndex = swapPageIndex;
            PhysicalPageIndex = physicalPageIndex;
        }
    }

    public class InPhysicalMemoryMmuLogEntry : MmuLogEntry
    {
        public int VirtualAddress { get; }
        public int PhysicalPageIndex { get; }

        public InPhysicalMemoryMmuLogEntry(int virtualAddress, int physicalPageIndex)
            : base($"Virtual address: {virtualAddress} found in page: {physicalPageIndex}")
        {
            VirtualAddress = virtualAddress;
            PhysicalPageIndex = physicalPageIndex;
        }
    }
}
