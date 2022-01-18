using System;
using Autofac;
using Xunit;

namespace CShaprLearning
{
    public class EvaluatorContext { }

    public class Op {}
    public class Binary : Op {}

    public interface IEvaluator <T> where T:Op 
    {
    }

    public class BinaryEvaluator : IEvaluator <Binary>
    {
        public int Visit(EvaluatorContext ctx, Binary b)
        {
            return 1;
        }
    }

    public class AutoFacTest
    {
        [Fact]
        public void test()
        {
            var builder = new ContainerBuilder();
            builder.RegisterType(typeof(BinaryEvaluator)).AsImplementedInterfaces();
            builder.RegisterAssemblyTypes(typeof(BinaryEvaluator).Assembly);
            var container = builder.Build();
            var obn = new Binary();
            var gt = typeof(IEvaluator<>).MakeGenericType(obn.GetType());
            var context = new EvaluatorContext();
            container.Resolve<BinaryEvaluator>().Visit(context, obn);
            var o = container.Resolve(typeof(IEvaluator<>).MakeGenericType(obn.GetType()));
            var result = o.GetType().GetMethod("Visit").Invoke(o, new object[] {context, obn});
            Assert.Equal(1, result);
        }
    }
}