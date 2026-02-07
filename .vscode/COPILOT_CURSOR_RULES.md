# VS Code — Copilot / Inline Suggest Cursor Rules

Purpose: Guidance and recommended settings for working with GitHub Copilot (inline suggestions) and the VS Code cursor so you get predictable completions across this project.

Why this file: teams and contributors have different editor settings. This short README documents the recommended behavior and a small `settings.json` snippet you can use in your workspace or user settings.

Quick recommendations

- Keep inline suggestions enabled so Copilot can show completions as you type.
- Position the cursor at the logical continuation point (end of statement, after a space/newline) to get the most relevant inline suggestions.
- Use `Tab` or `Right Arrow` to accept an inline suggestion (this depends on your personal keybindings; see Troubleshooting below).
- Use `Ctrl+Space` to open the full IntelliSense/completion list when inline suggestions don't appear.

Recommended `.vscode/settings.json` snippet
Copy this into your workspace or user settings to align behavior for contributors. It is intentionally conservative about accepting suggestions to avoid accidental accepts.

```json
{
  "editor.inlineSuggest.enabled": true,
  "editor.suggestSelection": "first",
  "editor.quickSuggestions": {
    "other": true,
    "comments": false,
    "strings": false
  },
  "editor.acceptSuggestionOnEnter": "off",
  "editor.acceptSuggestionOnCommitCharacter": false,
  "editor.suggestOnTriggerCharacters": true,
  "editor.suggest.snippetsPreventQuickSuggestions": false,
  "github.copilot.inlineSuggest.enable": true,
  "github.copilot.enable": {
    "*": true
  }
}
```

Cursor / acceptance rules (practical)

- To get a continuation suggestion for the current line: place the cursor where the next token would go (usually end-of-line or after a single space) and wait ~200–600ms.
- To get a block or function body suggestion: place the cursor at the start of the new line (press Enter to create the line) and wait.
- To get suggestions for comments or commit messages: start a comment line (`//`, `/*`, `#`, etc.) and Copilot will often provide contextual suggestions.
- If Copilot's inline suggestion is not the one you want, press `Ctrl+Space` to open the suggestion widget and pick another completion.
- If you want to accept only part of a suggestion, use keyboard navigation (arrow keys) to move the cursor and manually type the wanted text instead of accepting the whole suggestion.

Troubleshooting

- No inline suggestions: ensure the Copilot extension is installed and signed in; confirm `github.copilot.inlineSuggest.enable` and `editor.inlineSuggest.enabled` are `true` in settings.
- Suggestions not accepting on `Tab`: check `editor.acceptSuggestionOnEnter`, `editor.tabCompletion`, and any conflicting keybindings. You can open Keyboard Shortcuts and search for "accept" or "copilot" to inspect bindings.
- Font/glyph/spacing issues: these are unrelated to Copilot, but may affect rendering. If changing fonts (like Lato), restart VS Code to ensure UI and suggestion overlays render correctly.

Notes and best practices

- Avoid relying on exact formatting from Copilot for critical logic — always review generated code.
- For pair programming consistency, add the recommended snippet to your workspace `.vscode/settings.json` (this repo already contains a `.vscode` folder where this README lives).
- These recommendations are intentionally general to work across platforms and personal preferences. Adjust as needed for your workflow.

If you want, I can add the `settings.json` file to the workspace with this snippet — tell me if you'd like me to commit it.
