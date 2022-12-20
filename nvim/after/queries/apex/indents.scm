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
 (annotation_argument_list)
 (local_variable_declaration)
 (assignment_expression)
 (formal_parameters)
 (query_expression)
 (soql_query_body)
 (subquery)
 (accessor_list)
 ] @indent


(soql_query_body 
  (_) @indent)

(subquery
   (soql_query_body) @dedent)

[
 ")"
 "{"
 "}"
 "["
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
; (block_comment) @ignore



; ((array_initializer) @indent
;   (#set! "scope" "all"))
