using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VirtualMemory
{
    class Memory
    {
        private readonly IList<Page> _pages;

        public byte ReadContent(Address address)
        {
            int pageIndex = address.Offset / Page.PageSize;
            int pageOffset = address.Offset % Page.PageSize;
            Address pageOffsetAddress = new Address(pageOffset);

            return _pages[pageIndex].ReadContent(pageOffsetAddress);
        }

        public void WriteContent(Address address, byte toWrite)
        {
            int pageIndex = address.Offset / Page.PageSize;
            int pageOffset = address.Offset % Page.PageSize;
            Address pageOffsetAddress = new Address(pageOffset);

            _pages[pageIndex].WriteContent(pageOffsetAddress, toWrite);
        }

        public Memory(int pageCount)
        {
            _pages = new Page[pageCount];
        }
    }
}
