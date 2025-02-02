const std = @import("std");
const testing = std.testing;
const Queue = @import("queue.zig").Queue;

test "create and free queue - int" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var q = Queue(i32).new(allocator);
    defer q.free();

    try testing.expectEqual(@as(usize, 0), q.len);
}

test "enqueue and dequeue - int" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var q = Queue(i32).new(allocator);
    defer q.free();

    q.enqueue(1);
    q.enqueue(2);
    q.enqueue(3);

    try testing.expectEqual(@as(usize, 3), q.len);

    try testing.expectEqual(@as(i32, 1), q.dequeue());
    try testing.expectEqual(@as(i32, 2), q.dequeue());
    try testing.expectEqual(@as(i32, 3), q.dequeue());

    try testing.expectEqual(@as(usize, 0), q.len);
}

test "peek - int" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var q = Queue(i32).new(allocator);
    defer q.free();

    q.enqueue(1);
    try testing.expectEqual(@as(i32, 1), q.peek());
    q.enqueue(2);
    try testing.expectEqual(@as(i32, 1), q.peek());
    q.enqueue(3);
    try testing.expectEqual(@as(i32, 1), q.peek());
}

test "create and free queue - char" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var q = Queue(u8).new(allocator);
    defer q.free();

    try testing.expectEqual(@as(usize, 0), q.len);
}

test "enqueue and dequeue - char" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var q = Queue(u8).new(allocator);
    defer q.free();

    q.enqueue('a');
    q.enqueue('b');
    q.enqueue('c');

    try testing.expectEqual(@as(usize, 3), q.len);

    try testing.expectEqual(@as(u8, 'a'), q.dequeue());
    try testing.expectEqual(@as(u8, 'b'), q.dequeue());
    try testing.expectEqual(@as(u8, 'c'), q.dequeue());

    try testing.expectEqual(@as(usize, 0), q.len);
}

test "peek - char" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var q = Queue(u8).new(allocator);
    defer q.free();

    q.enqueue('a');
    try testing.expectEqual(@as(u8, 'a'), q.peek());
    q.enqueue('b');
    try testing.expectEqual(@as(u8, 'a'), q.peek());
    q.enqueue('c');
    try testing.expectEqual(@as(u8, 'a'), q.peek());
}

test "create and free queue - string" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var q = Queue([]const u8).new(allocator);
    defer q.free();

    try testing.expectEqual(@as(usize, 0), q.len);
}

test "enqueue and dequeue - string" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var q = Queue([]const u8).new(allocator);
    defer q.free();

    q.enqueue("hello");
    q.enqueue("world");
    q.enqueue("zig");

    try testing.expectEqual(@as(usize, 3), q.len);

    try testing.expectEqualStrings("hello", q.dequeue());
    try testing.expectEqualStrings("world", q.dequeue());
    try testing.expectEqualStrings("zig", q.dequeue());

    try testing.expectEqual(@as(usize, 0), q.len);
}

test "peek - string" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var q = Queue([]const u8).new(allocator);
    defer q.free();

    q.enqueue("hello");
    try testing.expectEqualStrings("hello", q.peek());
    q.enqueue("world");
    try testing.expectEqualStrings("hello", q.peek());
    q.enqueue("zig");
    try testing.expectEqualStrings("hello", q.peek());
}

test "create and free queue - float" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var q = Queue(f32).new(allocator);
    defer q.free();

    try testing.expectEqual(@as(usize, 0), q.len);
}

test "enqueue and dequeue - float" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var q = Queue(f32).new(allocator);
    defer q.free();

    q.enqueue(1.0);
    q.enqueue(2.0);
    q.enqueue(3.0);

    try testing.expectEqual(@as(usize, 3), q.len);

    try testing.expectEqual(@as(f32, 1.0), q.dequeue());
    try testing.expectEqual(@as(f32, 2.0), q.dequeue());
    try testing.expectEqual(@as(f32, 3.0), q.dequeue());

    try testing.expectEqual(@as(usize, 0), q.len);
}

test "peek - float" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    var q = Queue(f32).new(allocator);
    defer q.free();

    q.enqueue(1.0);
    try testing.expectEqual(@as(f32, 1.0), q.peek());
    q.enqueue(2.0);
    try testing.expectEqual(@as(f32, 1.0), q.peek());
    q.enqueue(3.0);
    try testing.expectEqual(@as(f32, 1.0), q.peek());
}
