const std = @import("std");
const ArrayList = @import("ArrayList/array_list.zig").ArrayList;
const LinkedList = @import("LinkedList/linked_list.zig").LinkedList;
const Stack = @import("Stack/stack.zig").Stack;

pub fn main() void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    testLinkedList(allocator);
    testArrayList(allocator);
    testStack(allocator);
}

fn testLinkedList(allocator: std.mem.Allocator) void {
    std.debug.print("\n----Testing LinkedList----\n\n", .{});
    var string_list = LinkedList([]const u8).new(allocator);
    defer string_list.free();

    string_list.push("Hello");
    string_list.push("World");
    string_list.push("!");
    string_list.print();

    var int_list = LinkedList(i32).new(allocator);
    defer int_list.free();

    int_list.push(1);
    int_list.push(2);
    int_list.push(3);
    int_list.print();

    var float_list = LinkedList(f32).new(allocator);
    defer float_list.free();

    float_list.push(1.1);
    float_list.push(2.1);
    float_list.push(3.2);
    float_list.push(1.79);
    float_list.print();

    var bool_list = LinkedList(bool).new(allocator);
    defer bool_list.free();

    bool_list.push(true);
    bool_list.push(false);
    bool_list.push(true);
    bool_list.print();

    var u128_list = LinkedList(u128).new(allocator);
    defer u128_list.free();

    u128_list.push(11010002010);
    u128_list.push(2123134123131);
    u128_list.push(3.123e+21);
    u128_list.print();
    std.debug.print("\n--------------------------\n", .{});
}

fn testArrayList(allocator: std.mem.Allocator) void {
    std.debug.print("\n----Testing  ArrayList----\n\n", .{});
    var string_list = ArrayList([]const u8).new(allocator);
    defer string_list.free();

    string_list.push("Hello");
    string_list.push("World");
    string_list.push("!");
    string_list.print();

    var int_list = ArrayList(i32).new(allocator);
    defer int_list.free();

    int_list.push(1);
    int_list.push(2);
    int_list.push(3);
    int_list.print();

    var float_list = ArrayList(f32).new(allocator);
    defer float_list.free();

    float_list.push(1.1);
    float_list.push(2.1);
    float_list.push(3.2);
    float_list.push(1.79);
    float_list.print();

    var bool_list = ArrayList(bool).new(allocator);
    defer bool_list.free();

    bool_list.push(true);
    bool_list.push(false);
    bool_list.push(true);
    bool_list.print();

    var u128_list = ArrayList(u128).new(allocator);
    defer u128_list.free();

    u128_list.push(11010002010);
    u128_list.push(2123134123131);
    u128_list.push(3.123e+21);
    u128_list.print();
    std.debug.print("\n--------------------------\n", .{});
}

fn testStack(allocator: std.mem.Allocator) void {
    std.debug.print("\n----  Testing  Stack  ----\n\n", .{});
    var string_stack = Stack([]const u8).new(allocator);
    defer string_stack.free();
    string_stack.push("Hello");
    string_stack.push("World");
    string_stack.push("!");
    string_stack.print();

    var int_stack = Stack(i32).new(allocator);
    defer int_stack.free();
    int_stack.push(1);
    int_stack.push(2);
    int_stack.push(3);
    int_stack.push(4);
    _ = int_stack.pop();
    int_stack.print();

    var float_stack = Stack(f32).new(allocator);
    defer float_stack.free();
    float_stack.push(1.1);
    float_stack.push(2.1);
    float_stack.push(3.2);
    float_stack.push(1.79);
    float_stack.print();

    var bool_stack = Stack(bool).new(allocator);
    defer bool_stack.free();
    bool_stack.push(true);
    bool_stack.push(false);
    bool_stack.push(true);
    bool_stack.print();

    var u128_stack = Stack(u128).new(allocator);
    defer u128_stack.free();
    u128_stack.push(11010002010);
    u128_stack.push(2123134123131);
    u128_stack.push(3.123e+21);
    u128_stack.print();
    std.debug.print("\n--------------------------\n", .{});
}
