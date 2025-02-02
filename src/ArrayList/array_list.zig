const std = @import("std");

pub fn ArrayList(comptime T: type) type {
    return struct {
        const Self = @This();
        const STARTING_CAPACITY = 32;
        current_capacity: usize,
        current_size: usize,
        data: []T,
        allocator: std.mem.Allocator,

        pub fn new(allocator: std.mem.Allocator) Self {
            return Self{
                .current_capacity = STARTING_CAPACITY,
                .current_size = 0,
                .data = allocator.alloc(T, STARTING_CAPACITY) catch unreachable,
                .allocator = allocator,
            };
        }

        pub fn free(self: *Self) void {
            self.allocator.free(self.data);
        }

        pub fn push(self: *Self, value: T) void {
            if (self.current_size >= self.current_capacity) {
                self.current_capacity *= 2;
                self.data = self.allocator.realloc(self.data, self.current_capacity) catch unreachable;
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

        pub fn insert_at(self: *Self, index: usize, value: T) !void {
            if (index > self.current_size) {
                return error.ArrayListIndexOutOfBounds;
            }
            self.current_size += 1;
            if (self.current_size >= self.current_capacity) {
                self.current_capacity *= 2;
                std.debug.print("Reallocating to {}\n", .{self.current_capacity});
                self.data = self.allocator.realloc(self.data, self.current_capacity) catch unreachable;
            }
            // Move the elements after the index to the right. Start at the end and work backwards.

            var i: usize = self.current_size - 1;
            while (i >= index) : (i -= 1) {
                self.data[i + 1] = self.data[i];
            }
            self.data[index] = value;
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

        pub fn get_index(self: *Self, value: T) !usize {
            for (self.data[0..self.current_size], 0..) |item, i| {
                if (T == []const u8) {
                    if (std.mem.eql(u8, item, value)) {
                        return i;
                    }
                } else {
                    if (item == value) {
                        return i;
                    }
                }
            }
            return error.ArrayListValueNotFound;
        }

        pub fn contains(self: *Self, value: T) bool {
            var i: usize = 0;
            while (i < self.current_size) : (i += 1) {
                if (T == []const u8) {
                    if (std.mem.eql(u8, self.data[i], value)) {
                        return true;
                    }
                } else {
                    if (self.data[i] == value) {
                        return true;
                    }
                }
            }
            return false;
        }

        pub fn sort(self: *Self, comptime compare: fn (void, T, T) bool) void {
            std.mem.sort(T, self.data[0..self.current_size], {}, compare);
        }

        fn string_less_than(_: void, a: []const u8, b: []const u8) bool {
            return std.mem.order(u8, a, b) == .lt;
        }

        fn string_greater_than(_: void, a: []const u8, b: []const u8) bool {
            return std.mem.order(u8, a, b) == .gt;
        }

        pub fn sort_desc(self: *Self) void {
            if (T == []const u8) {
                std.mem.sort(T, self.data[0..self.current_size], {}, string_greater_than);
            } else {
                std.mem.sort(T, self.data[0..self.current_size], {}, std.sort.desc(T));
            }
        }

        pub fn sort_asc(self: *Self) void {
            if (T == []const u8) {
                std.mem.sort(T, self.data[0..self.current_size], {}, string_less_than);
            } else {
                std.mem.sort(T, self.data[0..self.current_size], {}, std.sort.asc(T));
            }
        }

        pub fn concat(self: *Self, other: *Self) void {
            for (other.data[0..other.current_size]) |item| {
                self.push(item);
            }
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

        pub fn print_as_chars(self: *Self) void {
            std.debug.print("[", .{});
            for (self.data[0..self.current_size], 0..) |item, i| {
                if (i == self.current_size - 1) {
                    std.debug.print("{c}", .{item});
                } else {
                    std.debug.print("{c}, ", .{item});
                }
            }
            std.debug.print("]\n", .{});
        }
    };
}
