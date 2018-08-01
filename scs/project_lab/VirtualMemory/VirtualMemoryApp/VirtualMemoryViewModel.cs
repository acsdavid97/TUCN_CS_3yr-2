using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.ComponentModel;
using System.IO;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Windows.Input;
using GalaSoft.MvvmLight.Command;
using VirtualMem = VirtualMemory.VirtualMemory;
using VirtualMemory;
using VirtualMemoryApp.Annotations;

namespace VirtualMemoryApp
{
    public class VirtualMemoryViewModel : INotifyPropertyChanged
    {
        public IList<Page> PhysicalPages
        {
            get { return new List<Page>(_physicalMemory.Pages); }
        }

        public IList<Page> SwapPages
        {
            get { return new List<Page>(_swap.Pages); }
        }

        public IList<MmuLogEntry> MmuLogs
        {
            get { return new List<MmuLogEntry>(_memoryManagementUnit.Logs); }
        }

        private bool ValidAddress()
        {
            return Address >= 0 && Page.PageSize * VirtualMem.PageCount > Address;
        }

        public ICommand ReadFromAddressCommand => new RelayCommand(ReadFromAddress, CanReadFromAddress);

        private void ReadFromAddress()
        {
            Content = _process.ReadMemory(Address);
            OnPropertyChanged(nameof(MmuLogs));
        }

        private bool CanReadFromAddress()
        {
            return ValidAddress();
        }

        public ICommand WriteToAddressCommand => new RelayCommand(WriteToAddress, CanWriteToAddress);

        private bool CanWriteToAddress()
        {
            return ValidAddress();
        }

        private void WriteToAddress()
        {
            _process.WriteMemory(Address, Content);
            OnPropertyChanged(nameof(PhysicalHexViewStream));
            OnPropertyChanged(nameof(SwapHexViewStream));
            OnPropertyChanged(nameof(MmuLogs));
            OnPropertyChanged(nameof(PhysicalPages));
            OnPropertyChanged(nameof(SwapPages));
        }

        public Page SelectedPhysicalPage
        {
            get
            {
                if (_selectedPhysicalPage == null)
                {
                    return new Page();
                }
                return _selectedPhysicalPage;
            }
            set
            {
                _selectedPhysicalPage = value;
                OnPropertyChanged(nameof(SelectedPhysicalPage));
                OnPropertyChanged(nameof(PhysicalHexViewStream));
            }
        }

        public Page SelectedSwapPage
        {
            get
            {
                if (_selectedSwapPage == null)
                {
                    return new Page();
                }
                return _selectedSwapPage;
            }
            set
            {
                _selectedSwapPage = value;
                OnPropertyChanged(nameof(SelectedSwapPage));
                OnPropertyChanged(nameof(SwapHexViewStream));
            }
        }

        public MemoryStream PhysicalHexViewStream
        {
            get { return new MemoryStream(SelectedPhysicalPage.PageBytes, writable: false); }
        }

        public int Address { get; set; }

        public byte Content
        {
            get => _content;
            set
            {
                _content = value;
                OnPropertyChanged(nameof(Content));
            }
        }

        public MemoryStream SwapHexViewStream => new MemoryStream(SelectedSwapPage.PageBytes, writable:false);

        private readonly PhysicalMemory _physicalMemory;
        private readonly SwapMemory _swap;
        private Page _selectedSwapPage;
        private Page _selectedPhysicalPage;
        private readonly Process _process;
        private readonly FirstInFirstOutMmu _memoryManagementUnit;
        private byte _content;

        public VirtualMemoryViewModel()
        {
            _physicalMemory = new PhysicalMemory();
            _swap = new SwapMemory();
             _memoryManagementUnit = new FirstInFirstOutMmu(_physicalMemory, _swap);
            
            var virtualMemory = new VirtualMem(_memoryManagementUnit, _physicalMemory);
            _process = new Process(virtualMemory);
        }

        #region INotifyPropertyChanged

        public event PropertyChangedEventHandler PropertyChanged;

        [NotifyPropertyChangedInvocator]
        protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            if (PropertyChanged == null)
            {
                return;
            }
            PropertyChanged.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }

        #endregion

    }
}