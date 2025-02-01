# Zig Structs

Recreating Data Structures In Zig!

## ArrayList

This is a generic `ArrayList` data structure

### Instantiation

```
const std = @import("std");
const ArrayList = @import("ArrayList/array_list.zig");

pub fn main() void {
  var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
  defer arena.deinit();
  const allocator = arena.allocator();

  // to make list of strings
  var list_str = ArrayList.ArrayList([]const u8).new(allocator)

  // to make list of i8
  var list_i8 = ArrayList.ArrayList(i8).new(allocator)
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

## Contributing

If you want to contribute, feel free to submit an issue or a PR and I will get around to looking at it.

