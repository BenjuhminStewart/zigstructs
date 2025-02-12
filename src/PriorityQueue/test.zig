const std = @import("std");
const PriorityQueue = @import("priority_queue.zig").PriorityQueue;
const testing = std.testing;
const print = std.debug.print;

test "PriorityQueue Min" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const comparator: *const fn (i32, i32) bool = struct {
        pub fn comparator(a: i32, b: i32) bool {
            return a < b;
        }
    }.comparator;
    var pq = PriorityQueue(i32).new(allocator, comparator);

    pq.offer(10);
    pq.offer(5);
    pq.offer(3);
    pq.offer(1);
    pq.offer(2);
    pq.offer(0);
    pq.offer(4);
    pq.offer(12);

    var polled = try pq.poll();
    try testing.expectEqual(polled, 0);

    polled = try pq.poll();
    try testing.expectEqual(polled, 1);

    pq.free();
}

test "PriorityQueue Max" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const comparator: *const fn (i32, i32) bool = struct {
        pub fn comparator(a: i32, b: i32) bool {
            return a > b;
        }
    }.comparator;
    var pq = PriorityQueue(i32).new(allocator, comparator);

    pq.offer(10);
    pq.offer(5);
    pq.offer(3);
    pq.offer(1);
    pq.offer(2);
    pq.offer(0);
    pq.offer(4);
    pq.offer(12);

    var polled = try pq.poll();
    try testing.expectEqual(polled, 12);

    polled = try pq.poll();
    try testing.expectEqual(polled, 10);

    pq.free();
}

test "PriorityQueue Closest to three" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const comparator: *const fn (i32, i32) bool = struct {
        pub fn comparator(a: i32, b: i32) bool {
            return @abs(a - 3) < @abs(b - 3);
        }
    }.comparator;
    var pq = PriorityQueue(i32).new(allocator, comparator);

    pq.offer(10);
    pq.offer(5);
    pq.offer(3);
    pq.offer(1);
    pq.offer(2);
    pq.offer(0);
    pq.offer(4);
    pq.offer(12);

    var polled = try pq.poll();
    try testing.expectEqual(polled, 3);

    polled = try pq.poll();
    try testing.expectEqual(polled, 4);

    pq.free();
}

test "PriorityQueue Min from a list" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const comparator: *const fn (i32, i32) bool = struct {
        pub fn comparator(a: i32, b: i32) bool {
            return a < b;
        }
    }.comparator;
    var list = std.ArrayList(i32).init(allocator);
    defer list.deinit();
    try list.append(0);
    try list.append(1);
    try list.append(2);
    try list.append(3);
    try list.append(10);
    try list.append(5);
    try list.append(3);
    try list.append(1);
    var pq = PriorityQueue(i32).from_array(allocator, comparator, list.items);
    defer pq.free();
}

test "PriorityQueue Max From - String" {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    const comparator: *const fn ([]const u8, []const u8) bool = struct {
        pub fn comparator(a: []const u8, b: []const u8) bool {
            return a.len > b.len;
        }
    }.comparator;

    var pq = PriorityQueue([]const u8).new(allocator, comparator);
    defer pq.free();

    pq.offer("Helloey");
    pq.offer("World");
    pq.offer("Zig");
    pq.offer("Structs");
    pq.offer("Zig");

    const polled = try pq.poll();
    try testing.expectEqualStrings("Helloey", polled);

    const polled2 = try pq.poll();
    try testing.expectEqualStrings("Structs", polled2);
}
