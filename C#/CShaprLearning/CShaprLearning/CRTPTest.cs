using System;
using Xunit;

public enum NodeId
{
}

public class Node
{
    public Node(NodeId id)
    {
    }

    public NodeId Id;
}

public class Unary : Node
{
    public Unary(NodeId id) : base(id)
    {
    }
}

/// <summary>
/// CRTP Class
/// </summary>
/// <typeparam name="ModeType"></typeparam>
/// <typeparam name="SubClass"></typeparam>
public class UnaryWithMode<ModeType, SubClass> : Unary
    where SubClass : UnaryWithMode<ModeType, SubClass>
{
    public UnaryWithMode(NodeId id) : base(id)
    {
    }

    public void InheritProperties(Node other)
    {
        /// TypeConvert
        var rNode = (SubClass) Convert.ChangeType(other, GetType());
        Mode = rNode.Mode;
    }

    public ModeType Mode = (ModeType) (object) 0;
}

public enum LogMode
{
    Begin = 1,
    End = 2,
}

public class Log : UnaryWithMode<LogMode, Log>
{
    public Log(NodeId id) : base(id)
    {
    }
}

public class CreateGenericInstance
{
    public static T GetDevice<T>(int index) where T : Node, new()
    {
        var device = typeof(T).Name + index;
        var id = (NodeId) Enum.Parse(typeof(NodeId), device);
        return (T) Activator.CreateInstance(typeof(T), id);
    }
}


public class Context
{
}

public class Item
{
}

public interface IEvaluator
{
    public int Visit(Context ctx, Item target);
}
    
// call subclass method
public interface IEvaluator<T> : IEvaluator
    where T: Item
{
    public int Visit(Context ctx, T target);

    int IEvaluator.Visit(Context ctx, Item target)
    {
        return Visit(ctx, (T)target);
    }
}

public class Var : Item
{
    
}
public class IntEvaluator : IEvaluator<Var>
{
    public int Visit(Context ctx, Var target)
    {
        throw new NotImplementedException();
    }
}