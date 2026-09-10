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

((comment) @comment.line.groovy
  (#set! adjust.endBeforeFirstMatchOf "\\r?$"))
((shebang) @comment.line.groovy
  (#set! adjust.endBeforeFirstMatchOf "\\r?$"))

(string) @string.quoted.double.groovy
((escape_sequence) @keyword.operator.groovy
  (#is? test.childOfType string))
((interpolation ([ "$" ]) @keyword.operator.groovy)
  (#is? test.typeAt "parent.parent string"))

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

("/" @string.quoted.double.groovy
  (#is? test.childOfType string))

(ternary_op ([ "?" ":" ]) @keyword.operator.groovy)

(map_item
  key: (identifier) @variable.parameter.groovy
  (#is? test.typeAt "parent.parent map"))

(parameter type: (identifier) @support.type.groovy name: (identifier) @variable.parameter.groovy)
(generic_param name: (identifier) @variable.parameter.groovy)

(declaration type: (identifier) @support.type.groovy)
(function_definition type: (identifier) @support.type.groovy)
(function_declaration type: (identifier) @support.type.groovy)
(class_definition name: (identifier) @support.type.groovy)
(class_definition superclass: (identifier) @support.type.groovy)
(generic_param superclass: (identifier) @support.type.groovy)

(type_with_generics (identifier) @support.type.groovy)
((identifier) @support.type.groovy
  (#is? test.typeAt "parent generics")
  (#is? test.typeAt "parent.parent type_with_generics"))
("<" @punctuation.definition.generics.begin.bracket.angle.groovy
  (#is? test.childOfType "generics generic_parameters")
  (#is? test.first true))
(">" @punctuation.definition.generics.end.bracket.angle.groovy
  (#is? test.childOfType "generics generic_parameters")
  (#is? test.last true))
; TODO: Class literals with PascalCase

(declaration ("=") @keyword.operator.groovy)
(assignment ("=") @keyword.operator.groovy)

(function_call
  function: (identifier) @entity.name.function.groovy)
(function_call
  function: (dotted_identifier
	  (identifier) @entity.name.function.groovy . ))
((identifier) @variable.parameter.groovy
  (#is? test.typeAt "parent map_item")
  (#is? test.typeAt "parent.parent argument_list")
  (#is? test.typeAt "parent.parent.parent function_call"))
(juxt_function_call
  function: (identifier) @entity.name.function.groovy)
(juxt_function_call
  function: (dotted_identifier
	  (identifier) @entity.name.function.groovy . ))
((identifier) @variable.parameter.groovy
  (#is? test.typeAt "parent map_item")
  (#is? test.typeAt "parent.parent argument_list")
  (#is? test.typeAt "parent.parent.parent juxt_function_call"))

(function_definition
  function: (identifier) @entity.name.function.groovy)
(function_declaration
  function: (identifier) @entity.name.function.groovy)

(annotation) @entity.name.function.macro.groovy
(annotation (identifier) @entity.name.function.macro.groovy)
"@interface" @entity.name.function.macro.groovy

"pipeline" @keyword.control.groovy

(groovy_doc) @comment.block.documentation.groovy
[
  (groovy_doc_param)
  (groovy_doc_throws)
  (groovy_doc_tag)
] @string.other.groovy
(groovy_doc_param (identifier) @variable.parameter.groovy)
(groovy_doc_throws (identifier) @support.type.groovy)
