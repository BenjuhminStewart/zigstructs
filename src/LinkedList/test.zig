const std = @import("std");
const testing = std.testing;
const LinkedList = @import("linked_list.zig");

test "LinkedList as a Char List" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var list = LinkedList.LinkedList(u8).new(allocator);
    defer list.free();

    // test pushing and popping

    list.push('a');
    list.push('b');
    list.push('c');
    list.push('d');

    try testing.expectEqual(@as(usize, 4), list.len);

    _ = list.pop_head();
    try testing.expectEqual(@as(usize, 3), list.len);

    _ = list.pop_tail();

    try testing.expectEqual(@as(usize, 2), list.len);

    // test prepending
    list.prepend('a');
    try testing.expectEqual(@as(usize, 3), list.len);

    // test inserting at an index
    list.insert_at(2, 'b');
    try testing.expectEqual(@as(usize, 4), list.len);

    // test removing at an index
    try list.remove_at(2);
    try testing.expectEqual(@as(usize, 3), list.len);

    // test getting an element
    const element = list.get(2);
    try testing.expect(element != null);

    const element2 = list.get(10);
    try testing.expect(element2 == null);

    // test getting the index of an element
    try testing.expectEqual(1, list.get_index('b'));

    // test checking if an element is in the list
    try testing.expectEqual(true, list.contains('b'));
    try testing.expectEqual(false, list.contains('z'));
}

test "LinkedList as a Float List" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var list = LinkedList.LinkedList(f32).new(allocator);
    defer list.free();

    // test pushing and popping

    list.push(0.0);
    list.push(1.2);
    list.push(2.3);
    list.push(3.9);
    list.push(4.1);

    try testing.expectEqual(@as(usize, 5), list.len);

    _ = list.pop_head();
    try testing.expectEqual(@as(usize, 4), list.len);

    _ = list.pop_tail();

    try testing.expectEqual(@as(usize, 3), list.len);

    // test prepending
    list.prepend(0.0);
    try testing.expectEqual(@as(usize, 4), list.len);

    // test inserting at an index
    list.insert_at(2, 10.0);
    try testing.expectEqual(@as(usize, 5), list.len);

    // test removing at an index
    try list.remove_at(2);
    try testing.expectEqual(@as(usize, 4), list.len);

    // test getting an element
    const element = list.get(3);
    try testing.expect(element != null);

    const element2 = list.get(10);
    try testing.expect(element2 == null);

    // test getting the index of an element
    try testing.expectEqual(1, list.get_index(1.2));

    // test checking if an element is in the list
    try testing.expectEqual(true, list.contains(1.2));
    try testing.expectEqual(false, list.contains(12.765));
}

test "LinkedList as an Int List" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var list = LinkedList.LinkedList(i32).new(allocator);
    defer list.free();

    // test pushing and popping

    list.push(0);
    list.push(1);
    list.push(2);
    list.push(3);
    list.push(4);

    try testing.expectEqual(@as(usize, 5), list.len);

    _ = list.pop_head();
    try testing.expectEqual(@as(usize, 4), list.len);

    _ = list.pop_tail();

    try testing.expectEqual(@as(usize, 3), list.len);

    // test prepending
    list.prepend(0);
    try testing.expectEqual(@as(usize, 4), list.len);

    // test inserting at an index
    list.insert_at(2, 10);
    try testing.expectEqual(@as(usize, 5), list.len);

    // test removing at an index
    try list.remove_at(2);
    try testing.expectEqual(@as(usize, 4), list.len);

    // test getting an element
    const element = list.get(3);
    try testing.expect(element != null);

    const element2 = list.get(10);
    try testing.expect(element2 == null);

    // test getting the index of an element
    try testing.expectEqual(2, list.get_index(2));

    // test checking if an element is in the list
    try testing.expectEqual(true, list.contains(2));
    try testing.expectEqual(false, list.contains(12));
}

test "LinkedList as a String List" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var list = LinkedList.LinkedList([]const u8).new(allocator);
    defer list.free();

    // test pushing and popping

    list.push("hello");
    list.push("world");
    list.push("zig");
    list.push("structs");

    try testing.expectEqual(@as(usize, 4), list.len);

    _ = list.pop_head();
    try testing.expectEqual(@as(usize, 3), list.len);

    _ = list.pop_tail();

    try testing.expectEqual(@as(usize, 2), list.len);

    // test prepending
    list.prepend("hello");
    try testing.expectEqual(@as(usize, 3), list.len);

    // test inserting at an index
    list.insert_at(1, "world");
    try testing.expectEqual(@as(usize, 4), list.len);

    // test removing at an index
    try list.remove_at(1);
    try testing.expectEqual(@as(usize, 3), list.len);

    // test getting an element
    const element = list.get(2);
    try testing.expect(element != null);

    const element2 = list.get(10);
    try testing.expect(element2 == null);

    // test getting the index of an element
    try testing.expectEqual(1, list.get_index("world"));

    // test checking if an element is in the list
    try testing.expectEqual(true, list.contains("world"));
    try testing.expectEqual(false, list.contains("LinkedList"));
}
