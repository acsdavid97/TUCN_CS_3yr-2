using System;
using System.Collections.Generic;

namespace CompositeDP
{
    public class Directory : Entry

    {
    private ICollection<Entry> _contents;

    public Directory(string name)
    {
        Name = name;
        _contents = new List<Entry>();
    }

    public void addEntry(Entry entry)
    {
        _contents.Add(entry);
    }

        public void Print()
        {
            Console.WriteLine(Name);
            foreach (var entry in _contents)
            {
                entry.Print();
            }
        }

        public string Name { get; set; }
    }
}