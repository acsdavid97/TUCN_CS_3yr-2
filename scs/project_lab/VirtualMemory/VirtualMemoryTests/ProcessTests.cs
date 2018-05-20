using Microsoft.VisualStudio.TestTools.UnitTesting;
using VirtualMemory;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Unity;

namespace VirtualMemory.Tests
{
    [TestClass()]
    public class ProcessTests
    {
        private readonly Process _process;

        public ProcessTests()
        {
            _process = UnityConfig.Container.Resolve<Process>();
        }

        [TestMethod()]
        public void ReadMemoryTest()
        {
            const int address = 0x8432;
            const int content = 0x42;
            _process.WriteMemory(address, content);
            var readByte = _process.ReadMemory(address);
            Assert.AreEqual(readByte, content);
        }

        private void PageReadWriteTest(int maxPageCount)
        {
            byte contentToWrite = 0;
            for (var pageIndex = 0; pageIndex < maxPageCount; pageIndex++)
            {
                var address = pageIndex * Page.PageSize;
                _process.WriteMemory(address, contentToWrite);
                contentToWrite++;
            }

            byte contentToRead = 0;
            for (var pageIndex = 0; pageIndex < maxPageCount; pageIndex++)
            {
                var address = pageIndex * Page.PageSize;
                var contentRead = _process.ReadMemory(address);
                Assert.AreEqual(contentRead, contentToRead);
                contentToRead++;
            }
        }

        [TestMethod()]
        public void AllPhysicalMemoryTest()
        {
            PageReadWriteTest(PhysicalMemory.PageCount);
        }

        [TestMethod()]
        public void MustReplacePageTest()
        {
            PageReadWriteTest(PhysicalMemory.PageCount + 1);
        }

        [TestMethod()]
        public void RandomReadWriteTest()
        {
            var addressToValue = new Dictionary<int, byte>();
            var random = new Random();
            for (var i = 0; i < 2 * PhysicalMemory.PageCount; i++)
            {
                var nextAddress = random.Next(0, VirtualMemory.PageCount * Page.PageSize);
                var nextWrite = (byte) random.Next(0, Byte.MaxValue);
                addressToValue[nextAddress] = nextWrite;
                _process.WriteMemory(nextAddress, nextWrite);
            }

            foreach (var addressValue in addressToValue)
            {
                var address = addressValue.Key;
                var contentExpected = addressValue.Value;
                var contentRead = _process.ReadMemory(address);
                Assert.AreEqual(contentExpected, contentRead);
            }

        }
    }
}