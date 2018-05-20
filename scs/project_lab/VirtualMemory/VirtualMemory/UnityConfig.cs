using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Unity;

namespace VirtualMemory
{
    public class UnityConfig
    {
        private static Lazy<UnityContainer> container = 
            new Lazy<UnityContainer>(() =>
                {
                    var container = new UnityContainer();
                    RegisterTypes(container);
                    return container;
                });

        public static IUnityContainer Container => container.Value;

        private static void RegisterTypes(UnityContainer unityContainer)
        {
            unityContainer.RegisterType<MemoryManagementUnit, FirstInFirstOutMmu>();

            unityContainer.RegisterInstance(new PhysicalMemory());
            unityContainer.RegisterInstance(new SwapMemory());
        }
    }
}
