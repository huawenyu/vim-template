---
  title: Markdown PPT
  sub_title: (by presenterm!)
  authors:
    -  Me
    - You
  options:
    command_prefix: "cmd:"
---
<!-- PPT: presenterm -x the.md -->

# Header1 {{{1}}}

<!-- cmd:column_layout: [1, 1] -->
  <!-- cmd:column: 0 -->
  _Column 0_
  -
```rust-script +line_numbers
struct Node {
    value: i32,
    next: Option<Box<Node>>,
}
```
  <!-- cmd:pause -->
  <!-- cmd:column: 1 -->
  <!-- cmd:column: 0 -->
  _Column 1_
  -
```file  +exec +line_numbers
path: assets/demo.cxx
language: c++
```
 <!-- cmd:reset_layout -->
 <!-- cmd:end_slide -->

## Header2 {{{2}}}

  <!-- pause -->
  <!-- incremental_lists: true -->
- item 1
- item 2
- item 3
 <!-- incremental_lists: false -->
 <!-- cmd:end_slide -->

# End {{{1}}}

<!-- jump_to_middle -->
  **THANKS**
  -
---
![](assets/option.png)
<!-- end_slide -->

