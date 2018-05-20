using Microsoft.VisualStudio.TestTools.UnitTesting;
using VirtualMemory;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VirtualMemory.Tests
{
    [TestClass()]
    public class FirstInFirstOutMmuTests
    {
        private readonly PhysicalMemory _physicalMemory;
        private readonly SwapMemory _swap;
        private readonly MemoryManagementUnit _memoryManagementUnit;

        public FirstInFirstOutMmuTests()
        {
            _physicalMemory = new PhysicalMemory();
            _swap = new SwapMemory();
            _memoryManagementUnit = new FirstInFirstOutMmu(_physicalMemory, _swap);
        }

        [TestMethod()]
        public void VirtualToPhysicalTest()
        {
            // simulate writes to memory
            for (var pageIndex = 0; pageIndex < PhysicalMemory.PageCount; pageIndex++)
            {
                var address = pageIndex * Page.PageSize;
                var physicalAddress = _memoryManagementUnit.VirtualToPhysical(address);
                Assert.AreEqual(address, physicalAddress);
            }

            Assert.AreEqual(0, _memoryManagementUnit.SwapToVirt.Count);

            // should replace the first page (that is the oldest)
            var mustReplaceAddress = (PhysicalMemory.PageCount + 1) * Page.PageSize;
            var replacedPhysical = _memoryManagementUnit.VirtualToPhysical(mustReplaceAddress);
            Assert.AreEqual(0x00, replacedPhysical);

            Assert.AreEqual(1, _memoryManagementUnit.SwapToVirt.Count);

            // simulates reads to memory
            for (var pageIndex = 0; pageIndex < PhysicalMemory.PageCount; pageIndex++)
            {
                var address = pageIndex * Page.PageSize;
                var physicalAddress = _memoryManagementUnit.VirtualToPhysical(address);
            }

            Assert.AreEqual(1, _memoryManagementUnit.SwapToVirt.Count);
        }
    }
}