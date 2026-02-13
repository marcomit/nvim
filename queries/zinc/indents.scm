; Indents for Zinc language

; Indent after opening braces
[
  (block)
  (struct_declaration)
] @indent.begin

; Closing braces end indent
[
  "}"
] @indent.end @indent.branch

; Align closing brackets
[
  ")"
  "]"
] @indent.branch

; Don't indent these nodes themselves
[
  (comment)
] @indent.ignore
