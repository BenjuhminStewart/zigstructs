const std = @import("std");
const testing = std.testing;
const ArrayList = @import("array_list.zig");

test "ArrayList as a string of characters" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // test pushing and popping
    var list = ArrayList.ArrayList(u8).new(allocator);
    defer list.free();

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
    defer list2.free();
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

test "ArrayList as a Float List" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();
    var list = ArrayList.ArrayList(f16).new(allocator);
    defer list.free();

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
    defer list2.free();

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

const STARTING_CAPACITY_TEST = 32;

test "ArrayList as an Int List" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();
    var list = ArrayList.ArrayList(i32).new(allocator);
    defer list.free();

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
    defer list2.free();

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

test "ArrayList as a String List" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var list = ArrayList.ArrayList([]const u8).new(allocator);
    defer list.free();

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
    defer list2.free();

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
