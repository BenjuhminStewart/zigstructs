const std = @import("std");
const page_allocator = std.heap.page_allocator;

pub fn LinkedList(comptime T: type) type {
    return struct {
        const Node = struct {
            data: T,
            next: ?*Node = null,

            pub fn new(data: T) Node {
                return Node{
                    .data = data,
                };
            }

            pub fn print(self: *Node) void {
                if (T == []const u8) {
                    if (self.next) |_| {
                        std.debug.print("Node: {c} .data: {s}, .next: Node... {c}\n", .{ '{', self.data, '}' });
                    } else {
                        std.debug.print("Node: {c} .data: {s}, .next: null {c}\n", .{ '{', self.data, '}' });
                    }
                } else if (T == f16 or T == f32 or T == f64 or T == f80 or T == f128) {
                    if (self.next) |_| {
                        std.debug.print("Node: {c} .data: {d}, .next: Node... {c}\n", .{ '{', self.data, '}' });
                    } else {
                        std.debug.print("Node: {c} .data: {d}, .next: null {c}\n", .{ '{', self.data, '}' });
                    }
                } else {
                    if (self.next) |_| {
                        std.debug.print("Node: {c} .data: {}, .next: Node... {c}\n", .{ '{', self.data, '}' });
                    } else {
                        std.debug.print("Node: {c} .data: {}, .next: null {c}\n", .{ '{', self.data, '}' });
                    }
                }
            }
        };
        const Self = @This();
        head: ?*Node = null,
        tail: ?*Node = null,
        len: usize = 0,
        allocator: std.mem.Allocator,

        pub fn new(allocator: std.mem.Allocator) LinkedList(T) {
            return LinkedList(T){
                .allocator = allocator,
            };
        }

        pub fn free(self: *Self) void {
            var current = self.head;
            while (current) |n| {
                const next = n.next;
                self.allocator.destroy(n);
                current = next;
            }
            self.head = null;
            self.tail = null;
        }

        pub fn prepend(self: *LinkedList(T), value: T) void {
            const node = self.allocator.create(Node) catch unreachable;
            node.* = .{ .data = value };

            if (self.head) |head| {
                node.next = head;
                self.head = node;
            } else {
                self.head = node;
            }

            self.len += 1;
        }

        pub fn push(self: *LinkedList(T), value: T) void {
            const node = self.allocator.create(Node) catch unreachable;
            node.* = .{ .data = value };

            if (self.tail) |*tail| {
                tail.*.next = node;
                tail.* = node;
            } else {
                self.head = node;
                self.tail = node;
            }

            self.len += 1;
        }

        pub fn insert_at(self: *LinkedList(T), index: usize, value: T) void {
            if (index == 0) {
                self.prepend(value);
                return;
            }
            if (index >= self.len) {
                self.push(value);
                return;
            }

            var current = self.head;
            var i: usize = 0;
            while (current) |node| : (current = node.next) {
                if (i == index - 1) {
                    const new_node = self.allocator.create(Node) catch unreachable;
                    new_node.* = .{ .data = value, .next = node.next };
                    node.next = new_node;
                    self.len += 1;
                    return;
                }
                i += 1;
            }
        }

        pub fn remove_at(self: *LinkedList(T), index: usize) !void {
            if (index >= self.len or index < 0) {
                return error.IndexOutOfBounds;
            }

            if (index == 0) {
                _ = self.pop_head();
                return;
            }
            if (index == self.len - 1) {
                _ = self.pop_tail();
                return;
            }
            var current = self.head;
            var i: usize = 0;
            while (current) |node| : (current = node.next) {
                if (i == index - 1) {
                    if (node.next) |next| {
                        node.next = next.next;
                        self.len -= 1;
                        self.allocator.destroy(next);
                        return;
                    }
                }
                i += 1;
            }

            return;
        }

        pub fn get(self: *LinkedList(T), index: usize) ?*Node {
            // if index is out of bounds, return null
            if (index >= self.len or index < 0) {
                return null;
            }

            var current = self.head;
            var i: usize = 0;
            while (current) |node| : (current = node.next) {
                if (i == index) {
                    return node;
                }
                i += 1;
            }

            return null;
        }

        pub fn get_index(self: *LinkedList(T), value: T) ?usize {
            var current = self.head;
            var i: usize = 0;
            while (current) |node| : (current = node.next) {
                if (T == []const u8) {
                    if (std.mem.eql(u8, node.data, value)) {
                        return i;
                    }
                } else if (node.data == value) {
                    return i;
                }
                i += 1;
            }
            return null;
        }

        pub fn contains(self: *LinkedList(T), value: T) bool {
            var current = self.head;
            while (current) |node| {
                if (T == []const u8) {
                    if (std.mem.eql(u8, node.data, value)) {
                        return true;
                    }
                } else if (node.data == value) {
                    return true;
                }
                current = node.next;
            }
            return false;
        }

        pub fn pop_head(self: *LinkedList(T)) ?T {
            const first = self.head orelse return null;
            const popped_value = first.data;
            self.head = first.next;
            self.len -= 1;
            self.allocator.destroy(first);

            return popped_value;
        }

        pub fn pop_tail(self: *LinkedList(T)) ?T {
            if (self.len == 0) {
                return null;
            }
            var current = self.head;
            // traverse to the element before the tail
            while (current) |node| {
                if (node.next == self.tail) {
                    break;
                }
                current = node.next;
            }

            const popped = self.tail.?;
            const popped_value = popped.data;
            self.tail = current;
            self.tail.?.next = null;
            self.len -= 1;

            self.allocator.destroy(popped);
            return popped_value;
        }

        pub fn print(self: *LinkedList(T)) void {
            var current = self.head;
            std.debug.print("{c} ", .{'{'});
            if (T == []const u8) {
                while (current) |node| {
                    std.debug.print("{c}{s}{c} -> ", .{ '"', node.data, '"' });
                    current = node.next;
                }
            } else if (T == f16 or T == f32 or T == f64 or T == f80 or T == f128) {
                while (current) |node| {
                    std.debug.print("{d} -> ", .{node.data});
                    current = node.next;
                }
            } else {
                while (current) |node| {
                    std.debug.print("{any} -> ", .{node.data});
                    current = node.next;
                }
            }
            std.debug.print("null {c}\n", .{'}'});
        }
    };
}
