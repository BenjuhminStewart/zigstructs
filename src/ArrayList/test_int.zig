const std = @import("std");
const testing = std.testing;
const ArrayList = @import("array_list.zig");
const STARTING_CAPACITY_TEST = 32;

test "ArrayList as an Int List" {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    var list = ArrayList.ArrayList(i32).new(allocator);

    // test pushing and popping

    list.push(1);
    list.push(2);
    list.push(3);
    list.push(4);

    const popped = list.pop();
    try testing.expectEqual(@as(i32, 4), popped);
    try testing.expectEqual(list.current_capacity, STARTING_CAPACITY_TEST);
    try testing.expectEqual(list.current_size, 3);

    // test inserting at an index
    list.insert_at(1, 10) catch unreachable;
    try testing.expectEqual(10, list.get(1));
    try testing.expectEqual(4, list.current_size);

    // test removing at an index
    list.remove_at(1) catch unreachable;
    try testing.expectEqual(3, list.current_size);

    // test getting the index of an element
    try testing.expectEqual(1, list.get_index(2));
    try testing.expectEqual(error.ArrayListValueNotFound, list.get_index(10));

    // test checking if an element is in the list
    try testing.expectEqual(true, list.contains(2));
    try testing.expectEqual(false, list.contains(10));

    // test concatenating two lists
    var list2 = ArrayList.ArrayList(i32).new(allocator);
    list2.push(4);
    list2.push(5);
    list2.push(6);
    list2.push(7);
    list2.push(8);
    list2.push(9);

    list.concat(&list2);

    try testing.expectEqual(9, list.current_size);
    try testing.expectEqual(@as(i32, 1), list.get(0));
    try testing.expectEqual(@as(i32, 2), list.get(1));
    try testing.expectEqual(@as(i32, 3), list.get(2));
    try testing.expectEqual(@as(i32, 4), list.get(3));
    try testing.expectEqual(@as(i32, 5), list.get(4));
    try testing.expectEqual(@as(i32, 6), list.get(5));
    try testing.expectEqual(@as(i32, 7), list.get(6));
    try testing.expectEqual(@as(i32, 8), list.get(7));
    try testing.expectEqual(@as(i32, 9), list.get(8));

    // test sorting the list
    list.sort_asc();
    try testing.expectEqual(@as(i32, 1), list.get(0));
    try testing.expectEqual(@as(i32, 2), list.get(1));
    try testing.expectEqual(@as(i32, 3), list.get(2));
    try testing.expectEqual(@as(i32, 4), list.get(3));
    try testing.expectEqual(@as(i32, 5), list.get(4));
    try testing.expectEqual(@as(i32, 6), list.get(5));
    try testing.expectEqual(@as(i32, 7), list.get(6));
    try testing.expectEqual(@as(i32, 8), list.get(7));
    try testing.expectEqual(@as(i32, 9), list.get(8));

    // test sorting the list in descending order
    list.sort_desc();
    try testing.expectEqual(@as(i32, 9), list.get(0));
    try testing.expectEqual(@as(i32, 8), list.get(1));
    try testing.expectEqual(@as(i32, 7), list.get(2));
    try testing.expectEqual(@as(i32, 6), list.get(3));
    try testing.expectEqual(@as(i32, 5), list.get(4));
    try testing.expectEqual(@as(i32, 4), list.get(5));
    try testing.expectEqual(@as(i32, 3), list.get(6));
    try testing.expectEqual(@as(i32, 2), list.get(7));
    try testing.expectEqual(@as(i32, 1), list.get(8));
}
