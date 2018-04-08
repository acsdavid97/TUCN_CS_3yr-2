using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VirtualMemory
{
    class Page
    {
        public static readonly int PageSize = 1 << 12;

        private readonly IList<byte> _pageBytes;

        public Page()
        {
            _pageBytes = new byte[PageSize];
        }

        public byte ReadContent(Address address)
        {
            return _pageBytes[address.Offset];
        }

        public void WriteContent(Address address, byte toWrite)
        {
            _pageBytes[address.Offset] = toWrite;
        }
    }
}
