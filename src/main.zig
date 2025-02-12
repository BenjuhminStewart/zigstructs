const std = @import("std");
const ArrayList = @import("ArrayList/array_list.zig").ArrayList;
const LinkedList = @import("LinkedList/linked_list.zig").LinkedList;
const Stack = @import("Stack/stack.zig").Stack;
const Queue = @import("Queue/queue.zig").Queue;
const PriorityQueue = @import("PriorityQueue/priority_queue.zig").PriorityQueue;

pub fn main() void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    testLinkedList(allocator);
    testArrayList(allocator);
    testStack(allocator);
    testQueue(allocator);
    testPriorityQueue(allocator);
}

fn testLinkedList(allocator: std.mem.Allocator) void {
    std.debug.print("\n----Testing LinkedList----\n\n", .{});
    var string_list = LinkedList([]const u8).new(allocator);
    defer string_list.free();

    string_list.push("Hello");
    string_list.push("World");
    string_list.push("!");
    string_list.print();

    var int_list = LinkedList(i32).new(allocator);
    defer int_list.free();

    int_list.push(1);
    int_list.push(2);
    int_list.push(3);
    int_list.print();

    var float_list = LinkedList(f32).new(allocator);
    defer float_list.free();

    float_list.push(1.1);
    float_list.push(2.1);
    float_list.push(3.2);
    float_list.push(1.79);
    float_list.print();

    var bool_list = LinkedList(bool).new(allocator);
    defer bool_list.free();

    bool_list.push(true);
    bool_list.push(false);
    bool_list.push(true);
    bool_list.print();

    var u128_list = LinkedList(u128).new(allocator);
    defer u128_list.free();

    u128_list.push(11010002010);
    u128_list.push(2123134123131);
    u128_list.push(3.123e+21);
    u128_list.print();
    std.debug.print("\n--------------------------\n", .{});
}

fn testArrayList(allocator: std.mem.Allocator) void {
    std.debug.print("\n----Testing  ArrayList----\n\n", .{});
    var string_list = ArrayList([]const u8).new(allocator);
    defer string_list.free();

    string_list.push("Hello");
    string_list.push("World");
    string_list.push("!");
    string_list.print();

    var int_list = ArrayList(i32).new(allocator);
    defer int_list.free();

    int_list.push(1);
    int_list.push(2);
    int_list.push(3);
    int_list.print();

    var float_list = ArrayList(f32).new(allocator);
    defer float_list.free();

    float_list.push(1.1);
    float_list.push(2.1);
    float_list.push(3.2);
    float_list.push(1.79);
    float_list.print();

    var bool_list = ArrayList(bool).new(allocator);
    defer bool_list.free();

    bool_list.push(true);
    bool_list.push(false);
    bool_list.push(true);
    bool_list.print();

    var u128_list = ArrayList(u128).new(allocator);
    defer u128_list.free();

    u128_list.push(11010002010);
    u128_list.push(2123134123131);
    u128_list.push(3.123e+21);
    u128_list.print();
    std.debug.print("\n--------------------------\n", .{});
}

fn testStack(allocator: std.mem.Allocator) void {
    std.debug.print("\n----  Testing  Stack  ----\n\n", .{});
    var string_stack = Stack([]const u8).new(allocator);
    defer string_stack.free();
    string_stack.push("Hello");
    string_stack.push("World");
    string_stack.push("!");
    string_stack.print();

    var int_stack = Stack(i32).new(allocator);
    defer int_stack.free();
    int_stack.push(1);
    int_stack.push(2);
    int_stack.push(3);
    int_stack.push(4);
    _ = int_stack.pop();
    int_stack.print();

    var float_stack = Stack(f32).new(allocator);
    defer float_stack.free();
    float_stack.push(1.1);
    float_stack.push(2.1);
    float_stack.push(3.2);
    float_stack.push(1.79);
    float_stack.print();

    var bool_stack = Stack(bool).new(allocator);
    defer bool_stack.free();
    bool_stack.push(true);
    bool_stack.push(false);
    bool_stack.push(true);
    bool_stack.print();

    var u128_stack = Stack(u128).new(allocator);
    defer u128_stack.free();
    u128_stack.push(11010002010);
    u128_stack.push(2123134123131);
    u128_stack.push(3.123e+21);
    u128_stack.print();
    std.debug.print("\n--------------------------\n", .{});
}

fn testQueue(allocator: std.mem.Allocator) void {
    std.debug.print("\n----  Testing  Queue  ----\n\n", .{});
    var string_queue = Queue([]const u8).new(allocator);
    defer string_queue.free();
    string_queue.enqueue("Hello");
    string_queue.enqueue("World");
    string_queue.enqueue("!");
    string_queue.print();

    var int_queue = Queue(i32).new(allocator);
    defer int_queue.free();
    int_queue.enqueue(1);
    int_queue.enqueue(2);
    int_queue.enqueue(3);
    int_queue.enqueue(4);
    _ = int_queue.dequeue();
    int_queue.print();

    var float_queue = Queue(f32).new(allocator);
    defer float_queue.free();
    float_queue.enqueue(1.1);
    float_queue.enqueue(2.1);
    float_queue.enqueue(3.2);
    float_queue.enqueue(1.79);
    float_queue.print();

    var bool_queue = Queue(bool).new(allocator);
    defer bool_queue.free();
    bool_queue.enqueue(true);
    bool_queue.enqueue(false);
    bool_queue.enqueue(true);
    bool_queue.print();

    var u128_queue = Queue(u128).new(allocator);
    defer u128_queue.free();
    u128_queue.enqueue(11010002010);
    u128_queue.enqueue(2123134123131);
    u128_queue.enqueue(3.123e+21);
    u128_queue.print();
    std.debug.print("\n--------------------------\n", .{});
}

fn testPriorityQueue(allocator: std.mem.Allocator) void {
    std.debug.print("\n----Testing PriorityQueue----\n\n", .{});
    const comparator_int: *const fn (i32, i32) bool = struct {
        pub fn comparator(a: i32, b: i32) bool {
            return a < b;
        }
    }.comparator;

    const comparator_float: *const fn (f32, f32) bool = struct {
        pub fn comparator(a: f32, b: f32) bool {
            return a < b;
        }
    }.comparator;
    const comparator_u128: *const fn (u128, u128) bool = struct {
        pub fn comparator(a: u128, b: u128) bool {
            return a < b;
        }
    }.comparator;

    const comparator_string: *const fn ([]const u8, []const u8) bool = struct {
        pub fn comparator(a: []const u8, b: []const u8) bool {
            return std.mem.lessThan(u8, a, b);
        }
    }.comparator;

    var string_queue = PriorityQueue([]const u8).new(allocator, comparator_string);
    defer string_queue.free();
    string_queue.offer("Hello");
    string_queue.offer("Worldey");
    string_queue.offer("!");
    string_queue.print();

    var int_queue = PriorityQueue(i32).new(allocator, comparator_int);
    defer int_queue.free();
    int_queue.offer(1);
    int_queue.offer(2);
    int_queue.offer(3);
    int_queue.offer(4);
    _ = int_queue.poll() catch unreachable;
    int_queue.print();

    var float_queue = PriorityQueue(f32).new(allocator, comparator_float);
    defer float_queue.free();
    float_queue.offer(1.1);
    float_queue.offer(2.1);
    float_queue.offer(3.2);
    float_queue.offer(1.79);
    float_queue.print();

    var u128_queue = PriorityQueue(u128).new(allocator, comparator_u128);
    defer u128_queue.free();
    u128_queue.offer(11010002010);
    u128_queue.offer(2123134123131);
    u128_queue.offer(3.123e+21);
    u128_queue.print();
    std.debug.print("\n--------------------------\n", .{});
}
