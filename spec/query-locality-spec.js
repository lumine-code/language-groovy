const fs = require("fs");
const path = require("path");
const { Point } = require("lumine");

describe("Groovy highlight query locality", () => {
  let editor;

  beforeEach(async () => {
    await lumine.packages.activatePackage("language-groovy");
    editor = await lumine.workspace.open();
    editor.setGrammar(lumine.grammars.grammarForScopeName("source.groovy"));
  });

  afterEach(() => editor?.destroy());

  async function setUp(text) {
    editor.setText(text);
    await editor.languageMode.ready;
  }

  function capturesForRows(startRow, endRow) {
    const layer = editor.languageMode.rootLanguageLayer;
    return layer.queries.highlightsQuery.captures(layer.tree.rootNode, {
      startPosition: new Point(startRow, 0),
      endPosition: new Point(endRow, 0),
    });
  }

  it("keeps named arguments local inside a 6000-row call", async () => {
    const query = fs.readFileSync(
      path.join(__dirname, "..", "grammars", "groovy-highlights.scm"),
      "utf8",
    );
    expect(query).not.toContain("(function_call (argument_list");
    expect(query).not.toContain("(juxt_function_call (argument_list");

    await setUp("foo(key: value)");
    expect(editor.scopeDescriptorForBufferPosition([0, 4]).getScopesArray()).toContain(
      "variable.parameter.groovy",
    );

    const lines = ["foo("];
    for (let i = 0; i < 6000; i++) lines.push(`  key_${i}: value_${i},`);
    lines.push(")");
    await setUp(lines.join("\r\n"));
    expect(editor.languageMode.rootLanguageLayer.tree.rootNode.hasError).toBe(false);
    expect(capturesForRows(2998, 3004).length).toBeLessThanOrEqual(96);
  });

  it("keeps strings, generics, and documentation local inside 6000-row parents", async () => {
    const query = fs.readFileSync(
      path.join(__dirname, "..", "grammars", "groovy-highlights.scm"),
      "utf8",
    );
    expect(query).not.toContain("(string (escape_sequence)");
    expect(query).not.toContain("(string (interpolation");
    expect(query).not.toContain("(type_with_generics (generics");
    expect(query).not.toMatch(/\((?:generics|generic_parameters)\s+"<"/);
    expect(query).not.toMatch(/\(groovy_doc\s+\[/);

    await setUp('def text = "line ${value}"\nFoo<Bar, Baz> value');
    expect(editor.scopeDescriptorForBufferPosition([0, 17]).getScopesArray()).toContain(
      "keyword.operator.groovy",
    );
    expect(editor.scopeDescriptorForBufferPosition([1, 3]).getScopesArray()).toContain(
      "punctuation.definition.generics.begin.bracket.angle.groovy",
    );
    expect(editor.scopeDescriptorForBufferPosition([1, 4]).getScopesArray()).toContain(
      "support.type.groovy",
    );

    const stringLines = ['def text = """'];
    for (let i = 0; i < 6000; i++) stringLines.push(`line \${value_${i}}`);
    stringLines.push('"""');
    await setUp(stringLines.join("\r\n"));
    expect(editor.languageMode.rootLanguageLayer.tree.rootNode.hasError).toBe(false);
    expect(capturesForRows(2998, 3004).length).toBeLessThanOrEqual(64);

    const genericLines = ["Foo<"];
    for (let i = 0; i < 6000; i++) {
      genericLines.push(`  Type${i}${i === 5999 ? "" : ","}`);
    }
    genericLines.push("> value");
    await setUp(genericLines.join("\r\n"));
    expect(editor.languageMode.rootLanguageLayer.tree.rootNode.hasError).toBe(false);
    expect(capturesForRows(2998, 3004).length).toBeLessThanOrEqual(64);

    const docLines = ["/**"];
    for (let i = 0; i < 6000; i++) docLines.push(` * @param value${i} description`);
    docLines.push(" */", "def value() {}");
    await setUp(docLines.join("\r\n"));
    expect(editor.languageMode.rootLanguageLayer.tree.rootNode.hasError).toBe(false);
    expect(capturesForRows(2998, 3004).length).toBeLessThanOrEqual(64);
  });
});
