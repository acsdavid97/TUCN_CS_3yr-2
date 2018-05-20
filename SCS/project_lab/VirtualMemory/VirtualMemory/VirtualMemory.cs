using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VirtualMemory
{
    public class VirtualMemory : IMemory
    {
        public static readonly int PageCount = 1 << 10;

        private readonly MemoryManagementUnit _memoryManagementUnit;
        private readonly PhysicalMemory _physicalMemory;

        public VirtualMemory(MemoryManagementUnit memoryManagementUnit, PhysicalMemory physicalMemory)
        {
            _memoryManagementUnit = memoryManagementUnit;
            _physicalMemory = physicalMemory;
        }

        private void ValidateAddress(int address)
        {
            if (address < 0 || Page.PageSize * PageCount < address)
            {
                throw new ArgumentException($"address out of range for virtual memory: {address}");
            }
        }

        public byte ReadContent(int address)
        {
            ValidateAddress(address);
            var physicalAddress = _memoryManagementUnit.VirtualToPhysical(address);
            return _physicalMemory.ReadContent(physicalAddress);
        }

        public void WriteContent(int address, byte toWrite)
        {
            ValidateAddress(address);
            var physicalAddress = _memoryManagementUnit.VirtualToPhysical(address);
            _physicalMemory.WriteContent(physicalAddress, toWrite);
        }
    }
}
