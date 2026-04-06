# Contributing to MoVP Plugins

This repository is the source of truth for MoVP agent files — the plugin harnesses for Claude Code, Codex, and Cursor. The MoVP backend and CLI are available separately.

---

## Repository structure

```
claude-plugin/    Claude Code plugin (commands + skills)
codex-plugin/     Codex plugin (skills only)
cursor-plugin/    Cursor plugin (skills only)
scripts/          Install scripts and Homebrew formula
```

Each plugin directory is self-contained and independently installable. Claude Code gets both `commands/` (slash-invocable) and `skills/` (model-invoked). Codex and Cursor have `skills/` only.

---

## Dogfooding

Load the Claude Code plugin locally to test changes:

```bash
claude --plugin-dir ./claude-plugin
```

Use `/reload-plugins` in the Claude Code session to pick up edits without restarting.

For Cursor and Codex, see their respective plugin documentation for local install and reload workflows.

---

## How skills work

Skills in `skills/*/SKILL.md` are model-invoked — the model reads the `description` frontmatter field and decides when to activate the skill. Precise, specific descriptions fire reliably; vague ones don't.

When editing a skill's `description`, test it by starting a new session and checking whether the expected trigger phrases activate it. If a skill consistently fails to fire, copy its content to `.claude/rules/` in your project as a fallback (always-on).

---

## Keeping SKILL.md files in sync

All three plugins carry identical `SKILL.md` files:

- `claude-plugin/skills/movp-review/SKILL.md`
- `codex-plugin/skills/movp-review/SKILL.md`
- `cursor-plugin/skills/movp-review/SKILL.md`

And same for `movp-control-plane`. **When editing a SKILL.md, update all three copies.** Verify with:

```bash
diff claude-plugin/skills/movp-review/SKILL.md codex-plugin/skills/movp-review/SKILL.md
diff claude-plugin/skills/movp-review/SKILL.md cursor-plugin/skills/movp-review/SKILL.md
diff claude-plugin/skills/movp-control-plane/SKILL.md codex-plugin/skills/movp-control-plane/SKILL.md
diff claude-plugin/skills/movp-control-plane/SKILL.md cursor-plugin/skills/movp-control-plane/SKILL.md
```

All four diffs should be empty.

---

## Never commit credentials

Plugin `.mcp.json` files contain API keys — they are gitignored via `*/.mcp.json`. Only `.mcp.json.example` (with placeholder values) is committed.

`.claude/settings.json` and `.claude/settings.local.json` are also gitignored. If project-wide defaults are ever needed, revisit this policy.
