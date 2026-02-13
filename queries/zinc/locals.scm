; Locals queries for Zinc - scoping and references

; Scopes
[
  (function_declaration)
  (receiver_function)
  (block)
] @local.scope

; Definitions
(function_declaration
  name: (identifier) @local.definition.function)

(receiver_function
  name: (identifier) @local.definition.method)

(variable_declaration
  name: (identifier) @local.definition.var)

(dynamic_variable_declaration
  name: (identifier) @local.definition.var)

(parameter
  name: (identifier) @local.definition.parameter)

(struct_declaration
  name: (identifier) @local.definition.type)

; References
(identifier) @local.reference
