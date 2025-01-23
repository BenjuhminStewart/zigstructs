const std = @import("std");
const linkedList = @import("zll/zll.zig");

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    const allocator = arena.allocator();

    defer arena.deinit();

    var u32LinkedList = linkedList.Zll(u32).new(allocator);
    try u32LinkedList.insert(2);
    try u32LinkedList.insert(3);
    try u32LinkedList.insert(1);

    u32LinkedList.traverse();
}
