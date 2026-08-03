// Assertions live in the comments: `<- scope` checks the marker's own column
// on the previous non-comment line, `^ scope` checks the caret's. Scopes
// match by prefix, so the trailing `.groovy` segment is left off.

def greet(String name) {
//       ^ punctuation.definition.arguments.begin.bracket.round
//                     ^ punctuation.definition.block.begin.bracket.curly

    println "hi"
//           ^ string

}
// <- punctuation.definition.block.end.bracket.curly

// a comment
// <- comment
