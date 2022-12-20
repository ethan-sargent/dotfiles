;; attempting to match concepts represented here:
;; https://code.visualstudio.com/api/language-extensions/semantic-highlight-guide

;; Methods

(method_declaration
  name: (identifier) @method)

(method_declaration
  type: (type_identifier) @type)

(type_identifier) @type

(method_invocation
  name: (identifier) @method)

(argument_list
  (identifier) @variable)


(explicit_constructor_invocation
  arguments: (argument_list
               (identifier) @variable ))

;; Annotations

(annotation) @decorator

(annotation_key_value) @attribute


;; Types

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
  name: (identifier) @class)

(dml_type) @function.defaultLibrary

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
 ] @type.defaultLibrary

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

[
 ":"
] @punctuation

(ternary_expression ["?" ":"] @operator)

; Literals

[
 (int)
 (decimal_floating_point_literal)
 ] @number

[
 (string_literal)
 ] @string

[
 (line_comment)
 (block_comment)
 ] @comment

;; ;; Keywords

[
 "abstract"
 "break"
 "catch"
 "class"
 "continue"
 "default"
 "do"
 "else"
 "enum"
 "extends"
 "final"
 "finally"
 "for"
 "get"
 "global"
 "if"
 "implements"
 "instanceof"
 "interface"
 "new"
 "on"
 "private"
 "protected"
 "public"
 "return"
 "set"
 "static"
 "switch"
 "testMethod"
 "throw"
 "transient"
 "try"
 "trigger"
 "virtual"
 "when"
 "while"
 "with_sharing"
 "without_sharing"
 "inherited_sharing"
 ] @keyword

(assignment_expression
  left: (identifier) @variable)

; (type_identifier) @type ;; not respecting precedence...
;; I don't love this but couldn't break them up right now
;; can't figure out how to let that be special without conflicting
;; in the grammar
"System.runAs" @method.defaultLibrary

(scoped_type_identifier
  (type_identifier) @type)

; SOQL Highlights
(field_identifier
  (identifier) @property)

(field_identifier
  (dotted_identifier
    (identifier) @property))

(type_of_clause
  (identifier) @property)

(when_expression
  (identifier) @type)

(when_expression
  (field_list
    (identifier) @property))

(when_expression
  (field_list
    (dotted_identifier
      (identifier) @property )))

(else_expression
  (field_list
    (identifier) @property ))

(else_expression
  (field_list
    (dotted_identifier
      (identifier) @property )))

(alias_expression
  (identifier) @label)

(storage_identifier) @type
(function_name) @function
(date_literal) @variable.readonly.defaultLibrary

[
 "AND"
 "OR"
 "NOT"
 "LIKE"
 "NOT_IN"
 "INCLUDES"
 "EXCLUDES"
 ] @keyword

(set_comparison_operator "IN" @keyword)

[
 "="
 "!="
 ] @operator

(value_comparison_operator "<" @operator)
(value_comparison_operator ">" @operator)

"<=" @operator
">=" @operator

(int) @number
(decimal) @number
(currency_literal) @number
(string_literal) @string
(date) @variable.readonly
(date_time) @variable.readonly

[
 "TRUE"
 "FALSE"
 (null_literal)
 ] @constant.builtin
[
 "ABOVE"
 "ABOVE_OR_BELOW"
 "ALL_ROWS"
 "ALL"
 "AS"
 "ASC"
 "AT"
 "BELOW"
 "CUSTOM"
 "DATA_CATEGORY"
 "DESC"
 "ELSE"
 "END"
 "FIELDS"
 "FOR"
 "FROM"
 "GROUP_BY"
 "HAVING"
 "LIMIT"
 "NULLS_FIRST"
 "NULLS_LAST"
 "OFFSET"
 "ORDER_BY"
 "REFERENCE"
 "SELECT"
 "STANDARD"
 "THEN"
 "TRACKING"
 "TYPEOF"
 "UPDATE"
 "USING_SCOPE"
 "VIEW"
 "VIEWSTAT"
 "WITH"
 "WHERE"
 "WHEN"
 ] @keyword

; Using Scope
[
 "delegated"
 "everything"
 "mine"
 "mine_and_my_groups"
 "my_territory"
 "my_team_territory"
 "team"
 ] @enumMember

; With
[
 "maxDescriptorPerRecord"
 "RecordVisibilityContext"
 "Security_Enforced"
 "supportsDomains"
 "supportsDelegates"
 "System_Mode"
 "User_Mode"
 "UserId"
 ] @enumMember

