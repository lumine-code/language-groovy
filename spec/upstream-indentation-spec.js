describe("Groovy structural indentation", () => {
  let editor;

  beforeEach(async () => {
    await lumine.packages.activatePackage("language-groovy");
    editor = await lumine.workspace.open("indentation.groovy");
    editor.setTabLength(2);
  });

  afterEach(() => editor.destroy());

  it("indents multiline parameters and returns to the method body after their closing delimiter", async () => {
    editor.setText("void greet(\nname,\nother\n) {\nreturn name\n}\n");
    expect(await editor.whenGrammarSettled()).toBe(true);
    expect(editor.languageMode.tree.rootNode.hasError).toBe(false);
    expect(editor.suggestedIndentForBufferRow(1)).toBe(1);
    await editor.autoIndentBufferRows(0, 5);
    expect(editor.lineTextForBufferRow(1)).toBe("  name,");
    expect(editor.lineTextForBufferRow(2)).toBe("  other");
    expect(editor.lineTextForBufferRow(3)).toBe(") {");
    expect(editor.lineTextForBufferRow(4)).toBe("  return name");
    expect(editor.lineTextForBufferRow(5)).toBe("}");
  });
});
