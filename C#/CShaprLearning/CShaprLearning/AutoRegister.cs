using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using AutoMapper;
using Microsoft.CSharp.RuntimeBinder;
using Xunit;

namespace DefaultNamespace
{
    public record Op { }
    public record Add : Op { }
    public record Sub : Op { }
    
    public class AutoRegister
    {
        public static int VisitAdd(Add add)
        {
            return 1;
        }

        public static int VisitSub(Sub sub)
        {
            return -1;
        }
        
        public static Dictionary<Type, Func<Op, int>> Register(Type ty, string nameSpace, string prefix = "Visit")
        {
            var methods = ty.GetMethods().Where(x => x.Name.StartsWith(prefix));
            var mDict = new Dictionary<Type, Func<Op, int>>();
            foreach (var method in methods)
            {
                var type = Type.GetType("DefaultNamespace." + method.Name[prefix.Length..]);
                mDict[type] = (x => (int)method.Invoke(null, new object[]{x}));
            }

            return mDict;
        }
        
        [Fact]
        public void TestAutoRegister()
        {
            var dict = Register(typeof(AutoRegister), "DefaultNamespace");
            Assert.Equal(1, dict[typeof(Add)](new Add()));
            Assert.Equal(-1, dict[typeof(Sub)](new Sub()));
        }

        [Fact]
        public void TestAutoMapper()
        {
            
            // var conf = new MapperConfiguration(cfg =>
            // {
            //     cfg.CreateMap<Op, Func<Op, int>>();
            // });
            // conf.AssertConfigurationIsValid();
            // var mapper = conf.CreateMapper();
            // mapper.Map<Add>(VisitAdd);
        }
    }
}