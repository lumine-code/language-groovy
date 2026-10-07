describe("Groovy parameter and member highlighting", () => {
  let editor;

  beforeEach(async () => {
    await lumine.packages.activatePackage("language-groovy");
    editor = await lumine.workspace.open();
    editor.setGrammar(lumine.grammars.grammarForScopeName("source.groovy"));
  });

  afterEach(() => editor?.destroy());

  it("scopes untyped parameters, ordinary variables, member access and method references", async () => {
    editor.setText(
      "void greet(name) {\n  def value = 1;\n  value **= 2;\n  value?.field;\n  this.&greet;\n}\n",
    );
    await editor.languageMode.ready;
    expect(editor.languageMode.tree.rootNode.hasError).toBe(false);
    const scopes = (row, needle) =>
      editor
        .scopeDescriptorForBufferPosition([row, editor.lineTextForBufferRow(row).indexOf(needle)])
        .getScopesArray();
    expect(scopes(0, "name")).toContain("variable.parameter.groovy");
    expect(scopes(1, "value")).not.toContain("variable.parameter.groovy");
    expect(scopes(2, "**=")).toContain("keyword.operator.groovy");
    expect(scopes(3, "field")).toContain("variable.other.member.groovy");
    expect(scopes(4, "greet")).toContain("entity.name.function.groovy");
  });
});
