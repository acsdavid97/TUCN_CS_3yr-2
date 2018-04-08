using System;

namespace CompositeDP
{
    class Program
    {
        static void Main(string[] args)
        {
            Directory dir1 = new Directory("dir1");
            Directory dir2 = new Directory("dir2");
            dir1.addEntry(new File("file1"));
            dir1.addEntry(new File("file2"));
            dir1.addEntry(dir2);
            dir2.addEntry(new File("asdf"));

            dir1.Print();
        }
    }
}
