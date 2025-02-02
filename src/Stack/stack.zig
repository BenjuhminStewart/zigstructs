const std = @import("std");
const Allocator = std.mem.Allocator;
pub fn Stack(comptime T: type) type {
    return struct {
        const Self = @This();
        const STARTING_CAPACITY = 32;
        data: []T,
        len: usize,
        top: T,
        current_capacity: usize,
        allocator: Allocator,

        pub fn new(allocator: Allocator) Self {
            return Self{
                .data = allocator.alloc(T, STARTING_CAPACITY) catch unreachable,
                .len = 0,
                .top = undefined,
                .current_capacity = STARTING_CAPACITY,
                .allocator = allocator,
            };
        }

        pub fn free(self: *Self) void {
            self.allocator.free(self.data);
        }

        pub fn push(self: *Self, value: T) void {
            if (self.len == self.current_capacity) {
                self.current_capacity *= 2;
                self.data = self.allocator.realloc(self.data, self.current_capacity) catch unreachable;
            }
            self.data[self.len] = value;
            self.top = value;
            self.len += 1;
        }

        pub fn pop(self: *Self) T {
            if (self.len == 0) {
                return undefined;
            }

            self.len -= 1;
            const value = self.data[self.len];

            if (self.len == 0) {
                self.top = undefined;
                return value;
            }
            self.top = self.data[self.len - 1];
            return value;
        }

        pub fn peek(self: *Self) T {
            if (self.len == 0) {
                return undefined;
            }
            return self.data[self.len - 1];
        }

        pub fn print(self: *Self) void {
            std.debug.print("[ ", .{});
            for (self.data[0..self.len], 0..) |item, i| {
                if (T == []const u8) {
                    std.debug.print("{c}{s}{c}", .{ '"', item, '"' });
                } else if (T == f16 or T == f32 or T == f64 or T == f80 or T == f128) {
                    std.debug.print("{d}", .{item});
                } else {
                    std.debug.print("{}", .{item});
                }
                if (i != self.len - 1) {
                    std.debug.print(", ", .{});
                }
            }
            std.debug.print(" ]\n", .{});
        }
    };
}
