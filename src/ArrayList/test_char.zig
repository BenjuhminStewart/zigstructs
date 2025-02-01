const std = @import("std");
const testing = std.testing;
const ArrayList = @import("array_list.zig");

test "ArrayList as a string of characters" {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    // test pushing and popping
    var list = ArrayList.ArrayList(u8).new(allocator);

    list.push('H');
    list.push('e');
    list.push('l');
    list.push('l');
    list.push('o');
    list.push('o');

    const popped = list.pop();
    try testing.expectEqual(@as(u8, 'o'), popped);
    try testing.expectEqual(5, list.current_size);

    // test inserting at an index
    list.insert_at(1, 'W') catch unreachable;
    try testing.expectEqual(@as(u8, 'W'), list.get(1));
    try testing.expectEqual(6, list.current_size);

    // test removing at an index
    list.remove_at(1) catch unreachable;
    try testing.expectEqual(5, list.current_size);

    // test getting the index of an element
    try testing.expectEqual(1, list.get_index('e'));
    try testing.expectEqual(error.ArrayListValueNotFound, list.get_index('!'));

    // test checking if an element is in the list
    try testing.expectEqual(true, list.contains('e'));
    try testing.expectEqual(false, list.contains('!'));

    // test concatenating two lists
    var list2 = ArrayList.ArrayList(u8).new(allocator);
    list2.push('H');
    list2.push('e');
    list2.push('l');
    list2.push('l');
    list2.push('o');

    list.concat(&list2);

    try testing.expectEqual(10, list.current_size);
    try testing.expectEqual(@as(u8, 'H'), list.get(0));
    try testing.expectEqual(@as(u8, 'e'), list.get(1));
    try testing.expectEqual(@as(u8, 'l'), list.get(2));
    try testing.expectEqual(@as(u8, 'l'), list.get(3));
    try testing.expectEqual(@as(u8, 'o'), list.get(4));
    try testing.expectEqual(@as(u8, 'H'), list.get(5));
    try testing.expectEqual(@as(u8, 'e'), list.get(6));
    try testing.expectEqual(@as(u8, 'l'), list.get(7));
    try testing.expectEqual(@as(u8, 'l'), list.get(8));
    try testing.expectEqual(@as(u8, 'o'), list.get(9));

    // test sorting the list
    list.sort_desc();
    try testing.expectEqual(@as(u8, 'o'), list.get(0));
    try testing.expectEqual(@as(u8, 'o'), list.get(1));
    try testing.expectEqual(@as(u8, 'l'), list.get(2));
    try testing.expectEqual(@as(u8, 'l'), list.get(3));
    try testing.expectEqual(@as(u8, 'l'), list.get(4));
    try testing.expectEqual(@as(u8, 'l'), list.get(5));
    try testing.expectEqual(@as(u8, 'e'), list.get(6));
    try testing.expectEqual(@as(u8, 'e'), list.get(7));
    try testing.expectEqual(@as(u8, 'H'), list.get(8));
    try testing.expectEqual(@as(u8, 'H'), list.get(9));
    try testing.expectEqual(10, list.current_size);
}
