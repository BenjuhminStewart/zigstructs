# Zig Structs

Recreating Data Structures In Zig!

## ArrayList

This is a generic `ArrayList` data structure

### Usage

```zig
const std = @import("std");
const ArrayList = @import("ArrayList/array_list.zig").ArrayList;

pub fn main() void {
  var gpa = std.heap.GeneralPurposeAllocator(.{}){}; // GPA saves memory as opposed to the page allocator
  defer _ = gpa.deinit();
  const allocator = gpa.allocator();

  // to make array list of strings
  var list_str = ArrayList([]const u8).new(allocator)
  defer list_str.free(); // don't forget to free the list when using a GPA


  // to make array list of i8
  var list_i8 = ArrayList(i8).new(allocator)
  defer list_i8.free(); // don't forget to free the list when using a GPA
}
```

### Methods:

- `new(allocator: std.mem.Allocator) -> ArrayList<T>`
- `free() -> void`
- `push(value: T) -> void`
- `pop(value: T) -> T`
- `remove_at(index: usize) -> void`
- `get(index: usize) -> T`
- `update_at(index: usize, value: T) -> void`
- `print() -> void`

## Linked List

This is a generic `LinkedList` data structure

### Usage

```zig
const std = @import("std");
const LinkedList = @import("LinkedList/linked_list.zig").LinkedList;

pub fn main() void {
  var gpa = std.heap.GeneralPurposeAllocator(.{}){}; // GPA saves memory as opposed to the page allocator
  defer _ = gpa.deinit();
  const allocator = gpa.allocator();

  // to make linked list of strings
  var list_str = LinkedList([]const u8).new(allocator)
  defer list_str.free(); // don't forget to free the list when using a GPA

  // to make linked list of i8
  var list_i8 = LinkedList(i8).new(allocator)
  defer list_i8.free(); // don't forget to free the list when using a GPA
}
```

### Methods:

- `new(allocator: std.mem.Allocator) -> LinkedList<T>`
- `free() -> void`
- `prepend(value: T) -> void`
- `push(value: T) -> void`
- `insert_at(index: usize, value: T) -> void`
- `remove_at(index: usize) -> !void`
- `get(index: usize) -> ?*Node`
- `get_index(value: T) -> ?usize`
- `contains(value: T) -> bool`
- `pop_head() -> ?T`
- `pop_tail() -> ?T`
- `print() -> void`

## Stack

This is a generic `Stack` data structure

### Usage

```zig
const std = @import("std");
const Stack = @import("Stack/stack.zig").Stack;

pub fn main() void {
  var gpa = std.heap.GeneralPurposeAllocator(.{}){}; // GPA saves memory as opposed to the page allocator
  defer _ = gpa.deinit();
  const allocator = gpa.allocator();

  // to make stack of strings
  var list_str = Stack([]const u8).new(allocator)
  defer list_str.free(); // don't forget to free the list when using a GPA

  // to make stack of i8
  var list_i8 = Stack(i8).new(allocator)
  defer list_i8.free(); // don't forget to free the list when using a GPA
}
```

### Methods:

- `new(allocator: std.mem.Allocator) -> Stack<T>`
- `free() -> void`
- `push(value: T) -> void`
- `pop() -> T`
- `peek() -> T`
- `print() -> void`

## Contributing

If you want to contribute, feel free to submit an issue or a PR and I will get around to looking at it.

