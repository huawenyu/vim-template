---
  title: %CAMELCLASS%
  sub_title: _
  authors:
    - %USER%
    - %MAIL%
    - presenterm -x [^1]
    - %FDATE%
  options:
    command_prefix: "cmd:"
    image_attributes_prefix: ""
    strict_front_matter_parsing: false
    incremental_lists: false
    implicit_slide_ends: false
    end_slide_shorthand: false
---

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
path: %FULLPATH%
language: c++
```
 <!-- cmd:reset_layout -->
 <!-- cmd:end_slide -->

## Header2 {{{2}}}

  <!-- cmd:pause -->
  <!-- cmd:incremental_lists: true -->
- item 1
- item 2
- item 3
 <!-- cmd:incremental_lists: false -->
 <!-- cmd:end_slide -->

# End {{{1}}}

<!-- cmd:jump_to_middle -->
  **THANKS**
  -
---
<!-- cmd:end_slide -->

[^1]: [A markdown terminal slideshow tool](https://github.com/mfontanini/presenterm)

