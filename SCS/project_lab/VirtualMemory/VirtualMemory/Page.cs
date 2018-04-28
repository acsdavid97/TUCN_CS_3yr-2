using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VirtualMemory
{
    public class Page : IMemory
    {
        public static readonly int PageSize = 1 << 12;

        public readonly byte[] PageBytes;

        public Page()
        {
            PageBytes = new byte[PageSize];
        }

        private void ValidateAddress(int address)
        {
            if (address < 0 || Page.PageSize < address)
            {
                throw new ArgumentException($"address out of range for page: {address}");
            }
        }

        public byte ReadContent(int address)
        {
            ValidateAddress(address);
            return PageBytes[address];
        }

        public void WriteContent(int address, byte toWrite)
        {
            ValidateAddress(address);
            PageBytes[address] = toWrite;
        }
    }
}
