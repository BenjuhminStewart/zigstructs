const std = @import("std");
const pageAllocator = std.heap.page_allocator;

pub fn Zbt(comptime T: type) type {
    return struct {
        const Self = @This();
        const LeafNode = struct {
            const Self = @This();
            value: T,
            left: ?*LeafNode = null,
            right: ?*LeafNode = null,
        };

        root: ?*LeafNode = null,
        length: u32,
        allocator: std.mem.Allocator,

        pub fn new(allocator: std.mem.Allocator) Zbt(T) {
            return Self{
                .length = 0,
                .allocator = allocator,
                .root = null,
            };
        }
    };
}

test "initializing builds an empty tree with no root" {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    const tree = Zbt(u32).new(allocator);

    // act/assert
    try std.testing.expect(tree.length == 0);
    try std.testing.expect(tree.root == null);
}
