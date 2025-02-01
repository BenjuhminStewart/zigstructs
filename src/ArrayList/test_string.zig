const std = @import("std");
const testing = std.testing;
const ArrayList = @import("array_list.zig");

test "ArrayList as a String List" {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    var list = ArrayList.ArrayList([]const u8).new(allocator);

    // test pushing and popping

    list.push("Hello");
    list.push("World");
    list.push("!");
    list.push("!");

    const popped = list.pop();
    try testing.expectEqual("!", popped);
    try testing.expectEqual(3, list.current_size);

    // test inserting at an index
    list.insert_at(1, "World") catch unreachable;
    try testing.expectEqual("World", list.get(1));
    try testing.expectEqual(4, list.current_size);

    // test removing at an index
    list.remove_at(1) catch unreachable;
    try testing.expectEqual(3, list.current_size);

    // test getting the index of an element
    try testing.expectEqual(1, list.get_index("World"));
    try testing.expectEqual(error.ArrayListValueNotFound, list.get_index("ArrayList"));

    // test checking if an element is in the list
    try testing.expectEqual(true, list.contains("World"));
    try testing.expectEqual(false, list.contains("ArrayList"));

    // test concatenating two lists
    var list2 = ArrayList.ArrayList([]const u8).new(allocator);
    list2.push("How");
    list2.push("Are");
    list2.push("You");
    list2.push("?");

    list.concat(&list2);

    try testing.expectEqual(7, list.current_size);
    try testing.expectEqual("Hello", list.get(0));
    try testing.expectEqual("World", list.get(1));
    try testing.expectEqual("!", list.get(2));
    try testing.expectEqual("How", list.get(3));
    try testing.expectEqual("Are", list.get(4));
    try testing.expectEqual("You", list.get(5));
    try testing.expectEqual("?", list.get(6));

    // test sorting the list
    list.sort_asc();
    try testing.expectEqual("!", list.get(0));
    try testing.expectEqual("?", list.get(1));
    try testing.expectEqual("Are", list.get(2));
    try testing.expectEqual("Hello", list.get(3));
    try testing.expectEqual("How", list.get(4));
    try testing.expectEqual("World", list.get(5));
    try testing.expectEqual("You", list.get(6));
}
