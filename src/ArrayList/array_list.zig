const std = @import("std");
const page_allocator = std.heap.page_allocator;
const testing = std.testing;

pub fn ArrayList(comptime T: type) type {
    return struct {
        const Self = @This();
        const STARTING_CAPACITY = 10;
        current_capacity: usize,
        current_size: usize,
        data: []T,
        allocator: std.mem.Allocator,

        pub fn new(allocator: std.mem.Allocator) Self {
            return Self{
                .current_capacity = STARTING_CAPACITY,
                .current_size = 0,
                .data = page_allocator.alloc(T, STARTING_CAPACITY) catch unreachable,
                .allocator = allocator,
            };
        }

        pub fn free(self: *Self) void {
            page_allocator.free(self.data);
        }

        pub fn push(self: *Self, value: T) void {
            if (self.current_size == self.current_capacity) {
                self.current_capacity *= 2;
                self.data = page_allocator.realloc(self.data, self.current_capacity) catch unreachable;
            }
            self.data[self.current_size] = value;
            self.current_size += 1;
        }

        pub fn pop(self: *Self) !T {
            if (self.current_size == 0) {
                return error.ArrayListEmpty;
            }

            self.current_size -= 1;
            return self.data[self.current_size];
        }

        pub fn remove_at(self: *Self, index: usize) !void {
            if (index >= self.current_size) {
                return error.ArrayListIndexOutOfBounds;
            }
            self.current_size -= 1;
            const last_index = self.current_size;
            for (self.data[index..last_index], 0..) |_, i| {
                self.data[index + i] = self.data[index + i + 1];
                self.data[index + i + 1] = undefined;
            }
            self.data[last_index] = undefined;
        }

        pub fn update_at(self: *Self, index: usize, value: T) !void {
            if (index >= self.current_size) {
                return error.ArrayListIndexOutOfBounds;
            }
            self.data[index] = value;
        }

        pub fn get(self: *Self, index: usize) !T {
            if (index >= self.current_size) {
                return error.ArrayListIndexOutOfBounds;
            }
            return self.data[index];
        }

        pub fn print(self: *Self) void {
            std.debug.print("[", .{});
            for (self.data[0..self.current_size], 0..) |item, i| {
                if (T == []const u8) {
                    if (i == self.current_size - 1) {
                        std.debug.print("\"{s}\"", .{item});
                    } else {
                        std.debug.print("\"{s}\", ", .{item});
                    }
                } else if (T == f16 or T == f32 or T == f64 or T == f80 or T == f128) {
                    if (i == self.current_size - 1) {
                        std.debug.print("{d}", .{item});
                    } else {
                        std.debug.print("{d}, ", .{item});
                    }
                } else if (T == u8 or T == u16 or T == u32 or T == u64 or T == u128 or T == i8 or T == i16 or T == i32 or T == i64 or T == i128) {
                    if (i == self.current_size - 1) {
                        std.debug.print("{}", .{item});
                    } else {
                        std.debug.print("{}, ", .{item});
                    }
                } else {
                    if (i == self.current_size - 1) {
                        std.debug.print("{any}", .{item});
                    } else {
                        std.debug.print("{any}, ", .{item});
                    }
                }
            }
            std.debug.print("]\n", .{});
        }
    };
}

test "Create an ArrayList" {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    const list = ArrayList(i32).new(allocator);

    try testing.expectEqual(list.current_capacity, 10);
    try testing.expectEqual(list.current_size, 0);
}

test "Push an element into an ArrayList" {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    var list = ArrayList(i32).new(allocator);

    list.push(1);

    try testing.expectEqual(list.current_capacity, 10);
    try testing.expectEqual(list.current_size, 1);
}

test "Reallocate when the ArrayList is full" {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    var list = ArrayList(i32).new(allocator);
    var i: i32 = 0;
    for (0..11) |_| {
        list.push(i);
        i += 1;
    }

    try testing.expectEqual(list.current_capacity, 20);
    try testing.expectEqual(list.current_size, 11);
}

test "Pop an element from an ArrayList" {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    var list = ArrayList(i32).new(allocator);
    var i: i32 = 0;
    for (0..6) |_| {
        list.push(i);
        i += 1;
    }

    const popped = list.pop();
    try testing.expectEqual(@as(i32, 5), popped);
    try testing.expectEqual(5, list.current_size);
}

test "Update an element in an ArrayList" {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    var list = ArrayList(i32).new(allocator);
    var i: i32 = 0;
    for (0..6) |_| {
        list.push(i);
        i += 1;
    }
    list.update_at(1, 10) catch unreachable;
    try testing.expectEqual(10, list.get(1));
}

test "Remove an element at an index in an ArrayList" {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    var list = ArrayList(i32).new(allocator);
    var i: i32 = 0;
    for (0..6) |_| {
        list.push(i);
        i += 1;
    }

    list.remove_at(0) catch unreachable;
    try testing.expectEqual(5, list.current_size);
}

test "ArrayList as a String List" {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    var list = ArrayList([]const u8).new(allocator);

    list.push("Hello");
    list.push("World");
    list.push("!");
    list.push("How");
    list.push("Are");
    list.push("You");

    list.remove_at(0) catch unreachable;
    try testing.expectEqual(5, list.current_size);
}

test "ArrayList as a Float List" {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    var list = ArrayList(f16).new(allocator);

    list.push(1.0);
    list.push(2.2);
    list.push(3.9);
    list.push(4.1);
    list.push(5.1);
    list.push(6.5);

    list.remove_at(0) catch unreachable;
    try testing.expectEqual(5, list.current_size);
}

test "ArrayList as a string of characters" {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    var list = ArrayList(u8).new(allocator);

    list.push('H');
    list.push('e');
    list.push('l');
    list.push('l');
    list.push('o');
    list.push('o');

    const popped = list.pop();
    try testing.expectEqual(@as(u8, 'o'), popped);
    try testing.expectEqual(5, list.current_size);
}
