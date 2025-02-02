const std = @import("std");
const Stack = @import("stack.zig");
const testing = std.testing;
const TEST_STARTING_CAPACITY = 32;

test "Creating and Freeing a Stack - Int" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var stack = Stack.Stack(i32).new(allocator);
    defer stack.free();

    try testing.expectEqual(0, stack.len);
    try testing.expectEqual(undefined, stack.top);
    try testing.expectEqual(stack.current_capacity, TEST_STARTING_CAPACITY);
}

test "Pushing and Popping - Int" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var stack = Stack.Stack(i32).new(allocator);
    defer stack.free();

    stack.push(1);
    try testing.expectEqual(1, stack.len);
    try testing.expectEqual(@as(i32, 1), stack.top);

    stack.push(2);
    try testing.expectEqual(2, stack.len);
    try testing.expectEqual(@as(i32, 2), stack.top);

    stack.push(3);
    try testing.expectEqual(3, stack.len);
    try testing.expectEqual(@as(i32, 3), stack.top);

    const popped = stack.pop();
    try testing.expectEqual(2, stack.len);
    try testing.expectEqual(@as(i32, 2), stack.top);
    try testing.expectEqual(@as(i32, 3), popped);
}

test "Peeking - Int" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var stack = Stack.Stack(i32).new(allocator);
    defer stack.free();

    stack.push(1);
    stack.push(2);
    stack.push(3);

    try testing.expectEqual(@as(i32, 3), stack.peek());
}

test "Creating and Freeing a Stack - String" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var stack = Stack.Stack([]const u8).new(allocator);
    defer stack.free();

    try testing.expectEqual(0, stack.len);
    try testing.expectEqual(stack.current_capacity, TEST_STARTING_CAPACITY);
}

fn string_equal(a: []const u8, b: []const u8) bool {
    return std.mem.eql(u8, a, b);
}

test "Pushing and Popping - String" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var stack = Stack.Stack([]const u8).new(allocator);
    defer stack.free();

    stack.push("Hello");
    try testing.expectEqual(1, stack.len);
    try testing.expect(string_equal("Hello", stack.top));

    stack.push("World");
    try testing.expectEqual(2, stack.len);

    stack.push("!");
    try testing.expectEqual(3, stack.len);

    const popped = stack.pop();
    try testing.expectEqual(2, stack.len);
    try testing.expect(string_equal("!", popped));
    try testing.expect(string_equal("World", stack.top));
}

test "Peeking - String" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var stack = Stack.Stack([]const u8).new(allocator);
    defer stack.free();

    stack.push("Hello");
    stack.push("World");
    stack.push("!");

    try testing.expect(string_equal("!", stack.peek()));
}

test "Creating and Freeing a Stack - Float" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var stack = Stack.Stack(f16).new(allocator);
    defer stack.free();

    try testing.expectEqual(0, stack.len);
    try testing.expectEqual(stack.current_capacity, TEST_STARTING_CAPACITY);
}

test "Pushing and Popping - Float" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var stack = Stack.Stack(f16).new(allocator);
    defer stack.free();

    stack.push(1.0);
    try testing.expectEqual(1, stack.len);
    try testing.expectEqual(@as(f16, 1.0), stack.top);

    stack.push(2.2);
    try testing.expectEqual(2, stack.len);
    try testing.expectEqual(@as(f16, 2.2), stack.top);

    stack.push(3.9);
    try testing.expectEqual(3, stack.len);
    try testing.expectEqual(@as(f16, 3.9), stack.top);
}

test "Peeking - Float" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var stack = Stack.Stack(f16).new(allocator);
    defer stack.free();

    stack.push(1.0);
    stack.push(2.2);
    stack.push(3.9);

    try testing.expectEqual(@as(f16, 3.9), stack.peek());
}

test "Creating and Freeing a Stack - Char" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var stack = Stack.Stack(u8).new(allocator);
    defer stack.free();

    try testing.expectEqual(0, stack.len);
    try testing.expectEqual(stack.current_capacity, TEST_STARTING_CAPACITY);
}

test "Pushing and Popping - Char" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var stack = Stack.Stack(u8).new(allocator);
    defer stack.free();

    stack.push('H');
    try testing.expectEqual(1, stack.len);
    try testing.expectEqual(@as(u8, 'H'), stack.top);

    stack.push('e');
    try testing.expectEqual(2, stack.len);
    try testing.expectEqual(@as(u8, 'e'), stack.top);

    stack.push('l');
    try testing.expectEqual(3, stack.len);
    try testing.expectEqual(@as(u8, 'l'), stack.top);

    const popped = stack.pop();
    try testing.expectEqual(2, stack.len);
    try testing.expectEqual(@as(u8, 'l'), popped);
    try testing.expectEqual(@as(u8, 'e'), stack.top);
}

test "Peeking - Char" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var stack = Stack.Stack(u8).new(allocator);
    defer stack.free();

    stack.push('H');
    stack.push('e');
    stack.push('l');
    stack.push('l');
    stack.push('o');

    try testing.expectEqual(@as(u8, 'o'), stack.peek());
}
