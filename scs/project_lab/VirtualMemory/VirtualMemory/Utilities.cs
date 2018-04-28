using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace VirtualMemory
{
    static class Utilities
    {
        public static PageIndexOffset AddressToIndexOffset(int address)
        {
            var indexOffset = new PageIndexOffset
            {
                Index = address / Page.PageSize,
                Offset = address % Page.PageSize
            };

            return indexOffset;
        }

        public static int IndexOffsetToAddress(PageIndexOffset indexOffset)
        {
            return indexOffset.Index * Page.PageSize + indexOffset.Offset;
        }
    }
}
