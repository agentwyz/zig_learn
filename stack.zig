const std = @import("std");
const Allocator = std.mem.Allocator;


pub const Stack = struct {
    const Self = @This();

    pub const Node = struct {
        next: ?*Node = null,
        data: f64,
    };

    head: ?*Node = null,

    allocator: Allocator,

    pub fn push(self: *Self, val: f64) !void {
        const next: ?*Node = self.head;

        //创建一个新的节点
        var new: *Node = try self.allocator.create(Node);
        
        //新的节点下一个是原来栈的头结点
        new.next = next;
        new.data = val;

        self.head = new;
    }

    pub fn pop(self: *Self) ?f64 {
        const head: *Node = self.head orelse return null; //首先取出当前栈的头结点
        defer self.allocator.destroy(head); //删除当前栈的头结点
        self.head = head.next; //将当前头结点转换成为

        return head.data;
    }

    pub fn peek(self: *Self) ?f64 {
        var next: *Node = self.head orelse return null;
        return next.data;
    }

    pub fn init(allocator : Allocator) Self {
        return Self{
            .head = null,
            .allocator = allocator,
        };
    }

    pub fn deinit(self: *Self) void {
        while (self.pop()) {

        }
    }
};


const testing = std.testing;

const alloc = std.testing.allocator;

test "Create push pop" {
    var stack = Stack.init(alloc);

    try std.testing.expectEqual(@as(?f64, null), stack.peek());
    try std.testing.expectEqual(@as(?f64, null), stack.pop());
}
