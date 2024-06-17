; inherits: soql
; attempting to match concepts represented here:
; https://code.visualstudio.com/api/language-extensions/semantic-highlight-guide

; Methods

(method_declaration
  name: (identifier) @function.method)

(method_declaration
  type: (type_identifier) @type)

(type_identifier) @type

(method_invocation
  name: (identifier) @function.method.call)

(argument_list
  (identifier) @variable)


(explicit_constructor_invocation
  arguments: (argument_list
               (identifier) @variable ))

; Annotations

(annotation) @decorator

(annotation_key_value) @attribute


; Types

(interface_declaration
  name: (identifier) @interface)
(class_declaration
  name: (identifier) @class)
(class_declaration
  (superclass) @class)
(enum_declaration
  name: (identifier) @enum)
(enum_constant
  name: (identifier) @enumMember)

(interfaces
  (type_list
    (type_identifier) @interface ))

(local_variable_declaration
  (type_identifier) @type )

( expression_statement (_ (identifier)) @variable)


; (identifier) @variable

((field_access
  object: (identifier) @type)
 (#match? @type "^[A-Z]"))
((scoped_identifier
   scope: (identifier) @type)
 (#match? @type "^[A-Z]"))
((method_invocation
   object: (identifier) @type)
 (#match? @type "^[A-Z]"))

(field_access
  field: (identifier) @property)

(type_identifier) @type

(field_declaration
  type: (type_identifier) @type)

(method_declaration
  (formal_parameters
    (formal_parameter
      name: (identifier) @parameter)))

(formal_parameter
  type: (type_identifier) @type)

(enhanced_for_statement
  type: (type_identifier) @type
  name: (identifier) @variable )

(enhanced_for_statement
  value: (identifier) @variable)

(enhanced_for_statement
  name: (identifier) @variable)

(object_creation_expression
  type: (type_identifier) @type)

(array_creation_expression
  type: (type_identifier) @type)

(array_type
  element: (type_identifier) @type)

(catch_formal_parameter
  (type_identifier) @type
  name: (identifier) @variable)

(return_statement
  (identifier) @variable)

(local_variable_declaration
  (variable_declarator
    name: (identifier) @variable ))

(for_statement
  condition: (binary_expression
               (identifier) @variable))

(for_statement
  update: (update_expression
            (identifier) @variable))

(constructor_declaration
  name: (identifier) @constructor)

(dml_type) @function.builtin

(bound_apex_expression
  (identifier) @variable)

(assignment_operator) @operator

(update_expression ["++" "--"] @operator)

(instanceof_expression
  left: (identifier) @variable
  right: (type_identifier) @type )

(cast_expression
  type: (type_identifier) @type
  value: (identifier) @variable)

(switch_expression
  condition: (identifier) @variable)

(switch_label
  (type_identifier) @type
  (identifier) @variable )

(switch_rule
  (switch_label
    (identifier) @enumMember ))

(trigger_declaration
  name: (identifier) @type
  object: (identifier) @type
  (trigger_event) @keyword
  ("," (trigger_event) @keyword)*)

(binary_expression
  operator: [
             ">"
             "<"
             ">="
             "<="
             "=="
             "==="
             "!="
             "!=="
             "&&"
             "||"
             "+"
             "-"
             "*"
             "/"
             "&"
             "|"
             "^"
             "%"
             "<<"
             ">>"
             ">>>"] @operator)

(binary_expression
  (identifier) @variable)

(unary_expression
  operator: ["+" "-" "!" "~"] @operator)

(map_initializer "=>" @operator)

[
 (boolean_type)
 (void_type)
 ] @type.builtin

; Variables

(field_declaration
  (modifiers (modifier "final"))
  (variable_declarator
    name: (identifier) @constant))

(variable_declarator
  (identifier) @variable)

((_ object: (identifier) @type)
  (#match? @type "^[A-Z]"))

; Only when used as the value for an assignment, or in a variable declaration
((_ right: 
    (identifier) @constant)
 (#match? @constant "^_*[A-Z][A-Z\\d_]+$"))

(variable_declarator 
  (identifier) @constant
  (#match? @constant "^_*[A-Z][A-Z\\d_]+$"))

(this) @variable.builtin
(super) @function.builtin

[
  ":"
  ";"
  "."
  ","
  (optional_chain)
] @punctuation.delimiter

[
  "("
  ")"
  "["
  "]"
  "{"
  "}"
]  @punctuation.bracket

(type_arguments "<" @punctuation.bracket)
(type_arguments ">" @punctuation.bracket)

(ternary_expression ["?" ":"] @operator)

; Literals

[
 (int)
 (decimal_floating_point_literal)
 (currency_literal)
 ] @number

(string_literal) @string

[
 (line_comment)
 (block_comment)
 ] @comment

; Keywords

[
  "abstract"
  "final"
  "private"
  "protected"
  "public"
  "static"
] @keyword.modifier

[
  "if"
  "else"
  "switch"
] @keyword.conditional

[
  "for"
  "while"
  "do"
  "break"
] @keyword.repeat

"return" @keyword.return

[
  "throw"
  "finally"
  "try"
  "catch"
] @keyword.exception

"new" @keyword.operator

[
  "abstract"
  "class"
  "continue"
  "default"
  "enum"
  "extends"
  "final"
  "get"
  "global"
  "implements"
  "instanceof"
  "interface"
  "on"
  "private"
  "protected"
  "public"
  "set"
  "static"
  "testMethod"
  "transient"
  "trigger"
  "virtual"
  "when"
  "with_sharing"
  "without_sharing"
  "inherited_sharing"
] @keyword

(assignment_expression
  left: (identifier) @variable)

(scoped_type_identifier
  (type_identifier) @type)

