namespace CompositeDP
{
    /// <summary>
    /// An entry in a file system. Currently could be a file or a directory. 
    /// A directory could contain more than one entry (which could be a file or directory, again).
    /// This code is written to illustrate the Composite design pattern.
    /// </summary>
    public interface Entry
    {
        void Print();
    }
}