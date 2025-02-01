const std = @import("std");
const testing = std.testing;
const ArrayList = @import("array_list.zig");

test "ArrayList as a Float List" {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    var list = ArrayList.ArrayList(f16).new(allocator);

    // test pushing and popping
    list.push(1.0);
    list.push(2.2);
    list.push(3.9);
    list.push(4.1);
    list.push(5.1);
    list.push(6.5);

    const popped = list.pop();
    try testing.expectEqual(@as(f16, 6.5), popped);
    try testing.expectEqual(5, list.current_size);

    // test inserting at an index
    list.insert_at(1, 10.0) catch unreachable;
    try testing.expectEqual(@as(f16, 10.0), list.get(1));
    try testing.expectEqual(6, list.current_size);

    // test removing at an index
    list.remove_at(1) catch unreachable;
    try testing.expectEqual(5, list.current_size);
    try testing.expectEqual(@as(f16, 2.2), list.get(1));

    // test getting the index of an element
    try testing.expectEqual(@as(usize, 1), list.get_index(@as(f16, 2.2)));
    try testing.expectEqual(error.ArrayListValueNotFound, list.get_index(10.0));

    // test checking if an element is in the list
    try testing.expectEqual(true, list.contains(2.2));
    try testing.expectEqual(false, list.contains(10.0));

    // test concatenating two lists
    var list2 = ArrayList.ArrayList(f16).new(allocator);
    list2.push(1.0);
    list2.push(2.2);
    list2.push(3.9);
    list2.push(4.1);
    list2.push(5.1);

    list.concat(&list2);

    try testing.expectEqual(10, list.current_size);
    try testing.expectEqual(@as(f16, 1.0), list.get(0));
    try testing.expectEqual(@as(f16, 2.2), list.get(1));
    try testing.expectEqual(@as(f16, 3.9), list.get(2));
    try testing.expectEqual(@as(f16, 4.1), list.get(3));
    try testing.expectEqual(@as(f16, 5.1), list.get(4));
    try testing.expectEqual(@as(f16, 1.0), list.get(5));
    try testing.expectEqual(@as(f16, 2.2), list.get(6));
    try testing.expectEqual(@as(f16, 3.9), list.get(7));
    try testing.expectEqual(@as(f16, 4.1), list.get(8));
    try testing.expectEqual(@as(f16, 5.1), list.get(9));

    // test sorting the list
    list.sort_asc();
    try testing.expectEqual(@as(f16, 1.0), list.get(0));
    try testing.expectEqual(@as(f16, 1.0), list.get(1));
    try testing.expectEqual(@as(f16, 2.2), list.get(2));
    try testing.expectEqual(@as(f16, 2.2), list.get(3));
    try testing.expectEqual(@as(f16, 3.9), list.get(4));
    try testing.expectEqual(@as(f16, 3.9), list.get(5));
    try testing.expectEqual(@as(f16, 4.1), list.get(6));
    try testing.expectEqual(@as(f16, 4.1), list.get(7));
    try testing.expectEqual(@as(f16, 5.1), list.get(8));
    try testing.expectEqual(@as(f16, 5.1), list.get(9));

    // test sorting the list in descending order
    list.sort_desc();
    try testing.expectEqual(@as(f16, 5.1), list.get(0));
    try testing.expectEqual(@as(f16, 5.1), list.get(1));
    try testing.expectEqual(@as(f16, 4.1), list.get(2));
    try testing.expectEqual(@as(f16, 4.1), list.get(3));
    try testing.expectEqual(@as(f16, 3.9), list.get(4));
    try testing.expectEqual(@as(f16, 3.9), list.get(5));
    try testing.expectEqual(@as(f16, 2.2), list.get(6));
    try testing.expectEqual(@as(f16, 2.2), list.get(7));
    try testing.expectEqual(@as(f16, 1.0), list.get(8));
    try testing.expectEqual(@as(f16, 1.0), list.get(9));
}
