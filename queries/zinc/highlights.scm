; Highlights for Zinc language

; Errors
(ERROR) @error

; Keywords
[
  "struct"
  "type"
  "foreign"
  "if"
  "else"
  "while"
  "for"
  "return"
] @keyword

; Operators
[
  "="
  ":="
  "=="
  "!="
  "<"
  ">"
  "<="
  ">="
  "+"
  "-"
  "*"
  "/"
  "%"
  "and"
  "or"
  "not"
  "&"
] @operator

; Types
(basic_type) @type.builtin

[
  "char"
  "u8"
  "u16"
  "u32"
  "u64"
  "i8"
  "i16"
  "i32"
  "i64"
  "f32"
  "f64"
  "void"
] @type.builtin

; Function declarations
(function_declaration
  name: (identifier) @function)

(foreign_function_declaration
  name: (identifier) @function)

(receiver_function
  name: (identifier) @function.method)

; Function calls
(call_expression) @function.call

; Struct declarations
(struct_declaration
  name: (identifier) @type)

(struct_type
  name: (identifier) @type)

; Typedef
(typedef_declaration
  name: (identifier) @type)

; Variables
(variable_declaration
  name: (identifier) @variable)

(dynamic_variable_declaration
  name: (identifier) @variable)

(parameter
  name: (identifier) @variable.parameter)

; Member access
(member_expression
  member: (identifier) @variable.member)

; Constants
(integer_constant) @number
(float_constant) @number.float
(char_constant) @character
(string_literal) @string

; Comments
(comment) @comment

; Identifiers (fallback)
(identifier) @variable

; Punctuation
[
  "("
  ")"
  "{"
  "}"
  "["
  "]"
] @punctuation.bracket

[
  ","
  "."
] @punctuation.delimiter
