[
  "!in"
  "!instanceof"
  "as"
  "assert"
  "case"
  "catch"
  "class"
  "def"
  "default"
  "else"
  "extends"
  "finally"
  "for"
  "if"
  "import"
  "in"
  "instanceof"
  "package"
  "pipeline"
  "return"
  "switch"
  "try"
  "while"
  (break)
  (continue)
] @keyword.control.groovy

[
  "true"
  "false"
] @constant.language.boolean.groovy

(null) @constant.other.groovy
"this" @variable.language.groovy

[
  "int"
  "char"
  "short"
  "long"
  "boolean"
  "float"
  "double"
  "void"
] @support.type.builtin.groovy

[
  "final"
  "private"
  "protected"
  "public"
  "static"
  "synchronized"
] @support.type.qualifier.groovy

(comment) @comment.line.groovy
(shebang) @comment.line.groovy

(string) @string.quoted.double.groovy
(string (escape_sequence) @keyword.operator.groovy)
(string (interpolation ([ "$" ]) @keyword.operator.groovy))

"(" @punctuation.definition.arguments.begin.bracket.round.groovy
")" @punctuation.definition.arguments.end.bracket.round.groovy
"[" @punctuation.definition.list.begin.bracket.square.groovy
"]" @punctuation.definition.list.end.bracket.square.groovy
"{" @punctuation.definition.block.begin.bracket.curly.groovy
"}" @punctuation.definition.block.end.bracket.curly.groovy
":" @punctuation.separator.key-value.groovy
"," @punctuation.separator.comma.groovy
"." @punctuation.separator.property.groovy

(number_literal) @constant.numeric.groovy
(identifier) @variable.other.groovy
((identifier) @variable.parameter.groovy
  )

((identifier) @constant.other.groovy
  (#match? @constant.other.groovy "^[A-Z][A-Z_]+"))

[
  "%" "*" "/" "+" "-" "<<" ">>" ">>>" ".." "..<" "<..<" "<.." "<"
  "<=" ">" ">=" "==" "!=" "<=>" "===" "!==" "=~" "==~" "&" "^" "|"
  "&&" "||" "?:" "+" "*" ".&" ".@" "?." "*." "*" "*:" "++" "--" "!"
] @keyword.operator.groovy

(string ("/") @string.quoted.double.groovy)

(ternary_op ([ "?" ":" ]) @keyword.operator.groovy)

(map (map_item key: (identifier) @variable.parameter.groovy))

(parameter type: (identifier) @support.type.groovy name: (identifier) @variable.parameter.groovy)
(generic_param name: (identifier) @variable.parameter.groovy)

(declaration type: (identifier) @support.type.groovy)
(function_definition type: (identifier) @support.type.groovy)
(function_declaration type: (identifier) @support.type.groovy)
(class_definition name: (identifier) @support.type.groovy)
(class_definition superclass: (identifier) @support.type.groovy)
(generic_param superclass: (identifier) @support.type.groovy)

(type_with_generics (identifier) @support.type.groovy)
(type_with_generics (generics (identifier) @support.type.groovy))
(generics [ "<" ">" ] @punctuation.bracket)
(generic_parameters [ "<" ">" ] @punctuation.bracket)
; TODO: Class literals with PascalCase

(declaration ("=") @keyword.operator.groovy)
(assignment ("=") @keyword.operator.groovy)

(function_call
  function: (identifier) @entity.name.function.groovy)
(function_call
  function: (dotted_identifier
	  (identifier) @entity.name.function.groovy . ))
(function_call (argument_list
		 (map_item key: (identifier) @variable.parameter.groovy)))
(juxt_function_call
  function: (identifier) @entity.name.function.groovy)
(juxt_function_call
  function: (dotted_identifier
	  (identifier) @entity.name.function.groovy . ))
(juxt_function_call (argument_list
		      (map_item key: (identifier) @variable.parameter.groovy)))

(function_definition
  function: (identifier) @entity.name.function.groovy)
(function_declaration
  function: (identifier) @entity.name.function.groovy)

(annotation) @entity.name.function.macro.groovy
(annotation (identifier) @entity.name.function.macro.groovy)
"@interface" @entity.name.function.macro.groovy

"pipeline" @keyword.control.groovy

(groovy_doc) @comment.block.documentation.groovy
(groovy_doc
  [
    (groovy_doc_param)
    (groovy_doc_throws)
    (groovy_doc_tag)
  ] @string.other.groovy)
(groovy_doc (groovy_doc_param (identifier) @variable.parameter.groovy))
(groovy_doc (groovy_doc_throws (identifier) @support.type.groovy))
