exports.activate = function () {};

exports.consumeHyperlinkInjection = (hyperlink) => {
  hyperlink.addInjectionPoint("source.groovy", {
    types: ["comment"],
  });
};

exports.consumeTodoInjection = (todo) => {
  todo.addInjectionPoint("source.groovy", {
    types: ["comment"],
  });
};
