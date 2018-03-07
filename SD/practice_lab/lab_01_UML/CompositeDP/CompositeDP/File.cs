using System;

namespace CompositeDP
{
    public class File : Entry
    {
        public string Name { get; set; }

        public File(string name)
        {
            Name = name;
        }

        public void Print()
        {
            Console.WriteLine(Name);
        }
    }
}