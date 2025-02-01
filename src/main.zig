const std = @import("std");
const ArrayList = @import("ArrayList/array_list.zig");

pub fn main() !void {
    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    try testArrayList(allocator);
}

fn testArrayList(allocator: std.mem.Allocator) !void {
    var string_list = ArrayList.ArrayList([]const u8).new(allocator);
    defer string_list.free();

    string_list.push("Hello");
    string_list.push("World");
    string_list.push("!");
    string_list.print();

    var int_list = ArrayList.ArrayList(i32).new(allocator);
    defer int_list.free();

    int_list.push(1);
    int_list.push(2);
    int_list.push(3);
    int_list.print();

    var float_list = ArrayList.ArrayList(f32).new(allocator);
    defer float_list.free();

    float_list.push(1.1);
    float_list.push(2.1);
    float_list.push(3.2);
    float_list.push(1.79);
    float_list.print();

    var bool_list = ArrayList.ArrayList(bool).new(allocator);
    defer bool_list.free();

    bool_list.push(true);
    bool_list.push(false);
    bool_list.push(true);
    bool_list.print();

    var u128_list = ArrayList.ArrayList(u128).new(allocator);
    defer u128_list.free();

    u128_list.push(11010002010);
    u128_list.push(2123134123131);
    u128_list.push(3.123e+21);
    u128_list.print();
}
