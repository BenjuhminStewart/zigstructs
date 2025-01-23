const std = @import("std");
const pageAllocator = std.heap.page_allocator;
const testing = std.testing;

pub fn Zll(comptime T: type) type {
    return struct {
        const Node = struct { value: T, next: ?*Node };

        head: ?*Node,
        length: u32,
        allocator: std.mem.Allocator,

        pub fn new(allocator: std.mem.Allocator) Zll(T) {
            return .{ .length = 0, .head = null, .allocator = allocator };
        }

        pub fn insert(self: *Zll(T), value: T) !void {
            var newNode = try self.allocator.create(Node);

            const currentHead = self.head;
            newNode.value = value;
            newNode.next = currentHead;

            self.head = newNode;
            self.length += 1;
        }

        pub fn pop(self: *Zll(T)) ?T {
            if (self.head == null) {
                return null;
            }

            const currentHead = self.head;
            const updatedHead = self.head.?.next;

            self.head = updatedHead;
            self.length -= 1;

            return currentHead.?.value;
        }

        pub fn traverse(self: *Zll(T)) void {
            if (self.head == null) {
                return;
            }

            var currentNode = self.head;

            while (currentNode != null) : (currentNode = currentNode.?.next) {
                std.log.info("value: {}", .{currentNode.?.value});
            }
        }
    };
}

test "initializing builds an empty linked list with no head or tail" {
    // arrange, setup and allocator for our linked list to create nodes internally
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    const linkedList = Zll(u32).new(allocator);

    // act/assert
    try std.testing.expect(linkedList.length == 0);
    try std.testing.expect(linkedList.head == null);
}

test "inserting a value appends to the head of the linked list" {
    // arrange
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    var linkedList = Zll(u32).new(allocator);

    // act
    try linkedList.insert(69);
    try linkedList.insert(420);
    try linkedList.insert(1337);

    // assert
    try std.testing.expect(linkedList.length == 3);
    try std.testing.expect(linkedList.head != null);
    try std.testing.expect(linkedList.head.?.value == 1337);
}

test "popping nodes off the linked list returns a value" {
    // arrange
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    const allocator = gpa.allocator();
    var linkedList = Zll(u32).new(allocator);

    // act, with order 1337 -> 420 -> 69 -> null
    try linkedList.insert(69);
    try linkedList.insert(420);
    try linkedList.insert(1337);

    // after popping, our list should be 420 -> 69 -> null
    const popped = linkedList.pop();

    // assert
    try std.testing.expect(linkedList.length == 2);
    try std.testing.expect(linkedList.head != null);
    try std.testing.expect(linkedList.head.?.value == 420);
    try std.testing.expect(popped != null);
    try std.testing.expect(popped.? == 1337);
}

test "popping a node off a linked list with one item returns it's value" {
    // arrange, setup and allocator for our linked list to create nodes internally
    var arena = std.heap.ArenaAllocator.init(pageAllocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    var linkedList = Zll(u32).new(allocator);

    // act
    try linkedList.insert(69);
    const poppedValue = linkedList.pop();

    // assert
    try std.testing.expect(linkedList.length == 0);
    try std.testing.expect(linkedList.head == null);
    try std.testing.expect(poppedValue != null);
    try std.testing.expect(poppedValue.? == 69);
}

test "popping a node off an empty linked list returns null" {
    // arrange, setup and allocator for our linked list to create nodes internally
    var arena = std.heap.ArenaAllocator.init(pageAllocator);
    defer arena.deinit();
    const allocator = arena.allocator();
    var linkedList = Zll(u32).new(allocator);

    // act
    const poppedValue = linkedList.pop();

    // assert
    try std.testing.expect(linkedList.length == 0);
    try std.testing.expect(linkedList.head == null);
    try std.testing.expect(poppedValue == null);
}
