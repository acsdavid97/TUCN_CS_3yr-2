using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VirtualMemory
{
    public class PhysicalMemory : IMemory
    {
        public static readonly int PageCount = 1 << 1;
        public IList<Page> Pages;

        public PhysicalMemory()
        {
            Pages = new Page[PageCount];
            for(var i = 0; i < Pages.Count; i++)
            {
                Pages[i] = new Page();
            }
        }

        private void ValidateAddress(int address)
        {
            if (address < 0 || Page.PageSize * PageCount < address)
            {
                throw new ArgumentException($"address out of range for physical memory: {address}");
            }
        }

        public byte ReadContent(int address)
        {
            ValidateAddress(address);
            var indexOffset = Utilities.AddressToIndexOffset(address);
            return Pages[indexOffset.Index].ReadContent(indexOffset.Offset);
        }

        public void WriteContent(int address, byte toWrite)
        {
            ValidateAddress(address);
            var indexOffset = Utilities.AddressToIndexOffset(address);
            var page = Pages[indexOffset.Index];
            page.WriteContent(indexOffset.Offset, toWrite);
        }

    }
}
