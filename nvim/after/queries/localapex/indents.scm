[
 (class_body)
 (enum_body)
 (interface_body)
 (constructor_body)
 (block)
 (switch_block)
 (argument_list)
 (formal_parameters)
 (query_expression)
 (subquery)
] @indent.begin


(soql_query_body (_) @indent.begin)

[
 ")"
 "}"
 "]"
] @indent.branch

[
 "}"
 ; "]"
 ; ")"
] @indent.end

(line_comment) @indent.ignore

[
 (ERROR)
 (block_comment)
] @indent.auto

