using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.ComponentModel;
using System.IO;
using System.Runtime.CompilerServices;
using Microsoft.Practices.Prism.Commands;
using VirtualMem = VirtualMemory.VirtualMemory;
using VirtualMemory;
using VirtualMemoryApp.Annotations;
using WpfHexaEditor;

namespace VirtualMemoryApp
{
    public class VirtualMemoryViewModel : INotifyPropertyChanged
    {
        public IList<Page> PhysicalPages => _physicalMemory.Pages;
        public IList<Page> SwapPages => _swap.Pages;
        public Page SelectedPhysicalPage { get; set; }

        public Page SelectedSwapPage
        {

            get { return _selectedSwapPage; }
            set
            {
                _selectedSwapPage = value;
                OnPropertyChanged(nameof(SelectedSwapPage));
            }
        }


        public MemoryStream HexViewStream => new MemoryStream(SelectedSwapPage.PageBytes);

        private readonly PhysicalMemory _physicalMemory;
        private readonly SwapMemory _swap;
        private Page _selectedSwapPage;

        public VirtualMemoryViewModel()
        {
            _physicalMemory = new PhysicalMemory();
            _swap = new SwapMemory();
            var memoryManagementUnit = new FirstInFirstOutMmu(_physicalMemory, _swap);
            
            var virtualMemory = new VirtualMem(memoryManagementUnit, _physicalMemory);
            var process = new Process(virtualMemory);
        }

        public event PropertyChangedEventHandler PropertyChanged;

        [NotifyPropertyChangedInvocator]
        protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}