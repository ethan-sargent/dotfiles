[
 (class_body)
 (enum_body)
 (interface_body)
 (constructor_declaration)
 (constructor_body)
 (block)
 (switch_block)
 (field_declaration)
 (argument_list)
 (local_variable_declaration)
 (annotation_argument_list)
 (assignment_expression)
 (parenthesized_expression)
 (formal_parameters)
 (ternary_expression)
 (query_expression)
 ; (soql_query)
 (subquery)
 (accessor_list)
] @indent


(soql_query_body 
  (_) @indent)

[
 ")"
 "}"
 "]"
] @branch

[
 "}"
 "]"
 ")"
] @indent_end

(line_comment) @ignore

[
 (ERROR)
 (block_comment)
] @auto

