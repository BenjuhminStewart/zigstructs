const std = @import("std");
const ArrayList = @import("ArrayList/array_list.zig");
const LinkedList = @import("LinkedList/linked_list.zig");

pub fn main() void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    testLinkedList(allocator);
    testArrayList(allocator);
}

fn testLinkedList(allocator: std.mem.Allocator) void {
    std.debug.print("\n----Testing LinkedList----\n\n", .{});
    var string_list = LinkedList.LinkedList([]const u8).new(allocator);
    defer string_list.free();

    string_list.push("Hello");
    string_list.push("World");
    string_list.push("!");
    string_list.print();

    var int_list = LinkedList.LinkedList(i32).new(allocator);
    defer int_list.free();

    int_list.push(1);
    int_list.push(2);
    int_list.push(3);
    int_list.print();

    var float_list = LinkedList.LinkedList(f32).new(allocator);
    defer float_list.free();

    float_list.push(1.1);
    float_list.push(2.1);
    float_list.push(3.2);
    float_list.push(1.79);
    float_list.print();

    var bool_list = LinkedList.LinkedList(bool).new(allocator);
    defer bool_list.free();

    bool_list.push(true);
    bool_list.push(false);
    bool_list.push(true);
    bool_list.print();

    var u128_list = LinkedList.LinkedList(u128).new(allocator);
    defer u128_list.free();

    u128_list.push(11010002010);
    u128_list.push(2123134123131);
    u128_list.push(3.123e+21);
    u128_list.print();
    std.debug.print("\n--------------------------\n", .{});
}

fn testArrayList(allocator: std.mem.Allocator) void {
    std.debug.print("\n----Testing  ArrayList----\n\n", .{});
    var string_list = ArrayList.ArrayList([]const u8).new(allocator);
    defer string_list.free();

    string_list.push("Hello");
    string_list.push("World");
    string_list.push("!");
    string_list.print();

    var int_list = ArrayList.ArrayList(i32).new(allocator);
    defer int_list.free();

    int_list.push(1);
    int_list.push(2);
    int_list.push(3);
    int_list.print();

    var float_list = ArrayList.ArrayList(f32).new(allocator);
    defer float_list.free();

    float_list.push(1.1);
    float_list.push(2.1);
    float_list.push(3.2);
    float_list.push(1.79);
    float_list.print();

    var bool_list = ArrayList.ArrayList(bool).new(allocator);
    defer bool_list.free();

    bool_list.push(true);
    bool_list.push(false);
    bool_list.push(true);
    bool_list.print();

    var u128_list = ArrayList.ArrayList(u128).new(allocator);
    defer u128_list.free();

    u128_list.push(11010002010);
    u128_list.push(2123134123131);
    u128_list.push(3.123e+21);
    u128_list.print();
    std.debug.print("\n--------------------------\n", .{});
}
