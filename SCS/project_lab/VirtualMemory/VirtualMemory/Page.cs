using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using VirtualMemory.Annotations;

namespace VirtualMemory
{
    public class Page : IMemory, INotifyPropertyChanged
    {
        public static readonly int PageSize = 1 << 12;

        public int MappedTo
        {
            get => _mappedTo;
            set
            {
                _mappedTo = value;
                OnPropertyChanged(nameof(MappedTo));
            }
        }

        public readonly byte[] PageBytes;
        private int _mappedTo;

        public Page()
        {
            MappedTo = -1;
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

        public event PropertyChangedEventHandler PropertyChanged;

        [NotifyPropertyChangedInvocator]
        protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }

        public override string ToString()
        {
            return $"{nameof(MappedTo)}: {MappedTo}";
        }

    }
}
