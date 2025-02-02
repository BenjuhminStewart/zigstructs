const std = @import("std");

pub fn Queue(comptime T: type) type {
    return struct {
        const Self = @This();
        const STARTING_CAPACITY = 32;
        current_capacity: usize = STARTING_CAPACITY,
        rear: usize = 0,
        front: usize = 0,
        data: []T,
        len: usize = 0,
        allocator: std.mem.Allocator,

        pub fn new(allocator: std.mem.Allocator) Self {
            return Queue(T){
                .allocator = allocator,
                .data = allocator.alloc(T, STARTING_CAPACITY) catch unreachable,
            };
        }

        pub fn free(self: *Self) void {
            self.allocator.free(self.data);
        }

        pub fn enqueue(self: *Self, value: T) void {
            if (self.len == self.current_capacity) {
                self.current_capacity *= 2;
                self.data = self.allocator.realloc(self.data, self.current_capacity) catch unreachable;
            }
            self.data[self.rear] = value;
            self.rear += 1;
            self.len += 1;
        }

        pub fn dequeue(self: *Self) T {
            if (self.len == 0) {
                return undefined;
            }
            self.len -= 1;
            self.front += 1;
            return self.data[self.front - 1];
        }

        pub fn peek(self: *Self) T {
            if (self.len == 0) {
                return undefined;
            }
            return self.data[self.front];
        }

        pub fn print(self: *Self) void {
            var i: usize = 0;
            std.debug.print("{c} ", .{'{'});
            while (i < self.len) : (i += 1) {
                if (T == []const u8) {
                    std.debug.print("{c}{s}{c}", .{ '"', self.data[self.len - 1 - i], '"' });
                } else if (T == f16 or T == f32 or T == f64 or T == f80 or T == f128) {
                    std.debug.print("{d}", .{self.data[self.len - 1 - i]});
                } else {
                    std.debug.print("{any}", .{self.data[self.len - 1 - i]});
                }

                if (i != self.len - 1) {
                    std.debug.print(" -> ", .{});
                }
            }
            std.debug.print(" {c}\n", .{'}'});
        }
    };
}
