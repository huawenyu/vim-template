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

# Rust {{{1}}}

<!-- cmd:column_layout: [1, 1] -->
 <!-- cmd:column: 0 -->
 _Rust Dev Env_
 -
 <!-- cmd:pause -->
 <!-- cmd:incremental_lists: true -->
- curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
- cargo install rust-script
- source $HOME/.cargo/env     ### Append to .bashrc/.zshrc
- rustc --version
- rustup update
- TOOL - presenterm:
  + cargo install presenterm     ### Install release
  + cargo install --git https://github.com/mfontanini/presenterm   ### Install latest
  + cargo install --git https://github.com/mfontanini/presenterm --rev 2a469f3
  + Usage: presenterm -x `demo.md`
- rustup self uninstall       ### Uninstall
 <!-- cmd:incremental_lists: false -->

 <!-- cmd:pause -->
 _File C++ Demo_
 -
```file  +exec +line_numbers
path: %FULLPATH%
language: c++
```

 <!-- cmd:pause -->
 <!-- cmd:column: 1 -->
 _Rust interact demo_
 -
  <!-- cmd:pause -->
```rust-script  {4|5-7|all} +line_numbers +exec +acquire_terminal
use std::io::{self, Write};

fn main() {
    loop {
        // Prompt the user
        print!("Enter something (type 'exit' to quit): ");
        io::stdout().flush().unwrap(); // Ensure the prompt is displayed immediately

        // Read user input
        let mut input = String::new();
        io::stdin().read_line(&mut input).unwrap();

        // Trim and process the input
        let input = input.trim();
        if input.eq_ignore_ascii_case("exit") {
            println!("Goodbye!");
            break;
        } else {
            println!("You typed: {}", input);
        }
    }
}
```

 <!-- cmd:reset_layout -->
 <!-- cmd:end_slide -->

## Header2 {{{2}}}

 <!-- cmd:pause -->

 <!-- cmd:end_slide -->
# End {{{1}}}

<!-- cmd:jump_to_middle -->
  **THANKS**
  -
---
<!-- cmd:end_slide -->

[^1]: [A markdown terminal slideshow tool](https://github.com/mfontanini/presenterm)  
[^2]: [Template Var](https://github.com/aperezdc/vim-template/blob/master/doc/template.txt)  

