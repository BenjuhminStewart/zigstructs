const std = @import("std");
const dprint = std.debug.print;

pub fn PriorityQueue(comptime T: type) type {
    return struct {
        const Self = @This();
        const STARTING_CAPACITY = 8;
        capacity: usize = undefined,
        len: usize = 0,
        items: []T = undefined,
        comparator: *const fn (T, T) bool,
        allocator: std.mem.Allocator,
        pub fn new(allocator: std.mem.Allocator, comparator: *const fn (T, T) bool) Self {
            return PriorityQueue(T){
                .capacity = STARTING_CAPACITY,
                .allocator = allocator,
                .items = allocator.alloc(T, STARTING_CAPACITY) catch unreachable,
                .comparator = comparator,
            };
        }

        pub fn from_array(allocator: std.mem.Allocator, comparator: *const fn (T, T) bool, array: []T) Self {
            var pq = PriorityQueue(T).new(allocator, comparator);
            for (array) |item| {
                pq.offer(item);
            }
            return pq;
        }

        pub fn free(self: *Self) void {
            self.allocator.free(self.items);
        }

        pub fn offer(self: *Self, value: T) void {
            if (self.len == self.capacity) {
                self.capacity *= 2;
                self.items = self.allocator.realloc(self.items, self.capacity) catch unreachable;
            }

            self.items[self.len] = value;
            self.len += 1;
            self.bubble_up();
        }

        pub fn poll(self: *Self) !T {
            if (self.len == 0) {
                return error.EmptyPriorityQueue;
            }

            const value = self.items[0];
            self.items[0] = self.items[self.len - 1];
            self.items[self.len - 1] = undefined;
            self.len -= 1;
            self.sink_down();
            return value;
        }

        pub fn peek(self: *Self) T {
            return self.items[0];
        }

        pub fn print(self: *Self) void {
            dprint("[", .{});
            for (0..self.len) |i| {
                const item = self.items[i];
                if (i == self.len - 1) {
                    if (T == []const u8) {
                        dprint("{c}{s}{c}", .{ '"', item, '"' });
                    } else if (T == f16 or T == f32 or T == f64 or T == f80 or T == f128) {
                        dprint("{d}", .{item});
                    } else {
                        dprint("{any}", .{item});
                    }
                } else {
                    if (T == []const u8) {
                        dprint("{c}{s}{c}, ", .{ '"', item, '"' });
                    } else if (T == f16 or T == f32 or T == f64 or T == f80 or T == f128) {
                        dprint("{d}, ", .{item});
                    } else {
                        dprint("{any}, ", .{item});
                    }
                }
            }
            dprint("]\n", .{});
        }

        fn bubble_up(self: *Self) void {
            var i = self.len - 1;
            var parent = get_parent(i);
            while (i > 0 and self.comparator(self.items[i], self.items[parent])) {
                const temp = self.items[i];
                self.items[i] = self.items[parent];
                self.items[parent] = temp;

                i = parent;
                if (i == 0) break;
                parent = get_parent(i);
            }
        }

        fn get_compared_to(self: *Self, left: usize, right: usize) usize {
            if (self.comparator(self.items[left], self.items[right])) {
                return left;
            } else {
                return right;
            }
        }

        fn sink_down(self: *Self) void {
            var parent: usize = 0;
            var left = get_left(parent);
            var right = get_right(parent);
            var compared_to = get_compared_to(self, left, right);

            while (left < self.len - 1 and self.comparator(self.items[compared_to], self.items[parent])) {
                const temp = self.items[compared_to];
                self.items[compared_to] = self.items[parent];
                self.items[parent] = temp;

                parent = compared_to;
                left = get_left(parent);
                right = get_right(parent);

                if (left >= self.len - 1) break;
                compared_to = get_compared_to(self, left, right);
            }
        }

        fn get_parent(index: usize) usize {
            if (index == 0) return 0;
            return (index - 1) / 2;
        }

        fn get_left(index: usize) usize {
            return 2 * index + 1;
        }

        fn get_right(index: usize) usize {
            return 2 * index + 2;
        }
    };
}
