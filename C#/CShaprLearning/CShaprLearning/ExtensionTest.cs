using Xunit;

namespace CShaprLearning
{
    public class Foo
    {
        public int Value = 0;
    }

    /// static class and static method
    /// (this Class instance_name, args)
    public static class FooExtension
    {
        public static int Add(this Foo f, int a)
        {
            return f.Value + a;
        }
    }
    
    public class ExtensionTest
    {
        [Fact]
        public void test()
        {
            var f = new Foo();
            Assert.Equal(1, f.Add(1));
        }
    }
}
