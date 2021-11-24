function formatDescription(description) {
  if (typeof description !== "object") {
    return "";
  }

  return description.reduce((acc, line) => {
    // Support '\n' notation
    const content = line.replace("\\n", "\n");

    // Paragraph (line with only '.' appears as empty string here)
    if (!content) return `${acc}\n\n`;

    return !acc || acc[acc.length - 1] === "\n"
      ? // on beginning of line
        `${acc}${content}`
      : // within line
        `${acc} ${content}`;
  }, "");
}
