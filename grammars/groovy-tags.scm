(class_definition name: (identifier) @name) @definition.class
[(function_definition function: [(identifier) (quoted_identifier)] @name
  (#is-not? test.descendantOfType "class_definition"))
 (function_declaration function: [(identifier) (quoted_identifier)] @name
  (#is-not? test.descendantOfType "class_definition"))] @definition.function
(class_definition body: (closure
  [(function_definition function: [(identifier) (quoted_identifier)] @name)
   (function_declaration function: [(identifier) (quoted_identifier)] @name)] @definition.method))
(declaration name: (identifier) @name) @definition.variable
