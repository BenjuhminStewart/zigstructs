const std = @import("std");
const LinkedList = @import("LinkedList/linked_list.zig");
const ArrayList = @import("ArrayList/array_list.zig");

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    try testLinkedList(allocator);
    try testArrayList(allocator);
}

pub fn testLinkedList(allocator: std.mem.Allocator) !void {
    var u32LinkedList = LinkedList.LinkedList(u32).new(allocator);
    try u32LinkedList.insert(2);
    try u32LinkedList.insert(3);
    try u32LinkedList.insert(1);

    u32LinkedList.traverse();
}

fn testArrayList(allocator: std.mem.Allocator) !void {
    var arrayList = ArrayList.ArrayList(u32).new(allocator);

    arrayList.push(69);
    arrayList.push(420);
    arrayList.push(1337);

    arrayList.print();
}
