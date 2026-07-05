# skills-Epic

Curated collection of AI agent skills for Flutter, Dart, and mobile development workflows. Each skill is a packaged instruction set that trains your AI coding assistant (Claude Code, OpenCode, etc.) to handle specific tasks with precision.

## Quick Install

**One-liner (recommended):**

```bash
curl -fsSL https://raw.githubusercontent.com/workspaccode/skills-Epic/main/install.sh | bash
```

This installs all skills to your detected AI assistant and places the `skills` CLI in `/usr/local/bin`.

**Install to specific target manually:**

```bash
# Download the CLI, then run
./skills install all --target ~/.config/opencode/skills
./skills install all --target ~/.claude/skills
```

**After install:**

```bash
skills list       # see available skills
skills status     # see what's installed where
skills update     # download latest versions
```

## Skills

| Skill | Description |
|-------|-------------|
| **project-scope-guard** | Keeps work anchored to the project's actual goal — prevents drift into unrelated features or tangents |
| **flutter-anti-tamper** | Hardens Flutter apps against reverse engineering, decompilation, and runtime tampering |
| **flutter-arch-selector** | Prompts to choose MVVM, MVC, or Clean Architecture before writing structural code |
| **flutter-perf-guardian** | Reviews Flutter/Dart code for performance mistakes and anti-patterns |
| **flutter-security-guardian** | Scans for hardcoded secrets, insecure storage, missing cert pinning |
| **flutter-uix-architect** | Scaffolds responsive clean-code Flutter UI with DI and state management |
| **gh-actions-guardian** | Sets up GitHub Actions workflows for Flutter/Dart CI/CD and security scanning |
| **gradle-doctor** | Diagnoses and fixes Gradle/Android build errors |
| **ios-build-doctor** | Diagnoses and fixes iOS/Xcode build errors, CocoaPods, code signing |

## CLI Reference

```bash
skills list                           # list all skills
skills status                         # show install targets + counts
skills install all                    # install all skills (auto-detect target)
skills install <name> [<name>...]     # install specific skills
skills install all --target <path>    # install to custom directory
skills uninstall <name>               # remove a skill
skills update                         # download latest from GitHub
```

The CLI auto-detects these targets:

| Target | Path |
|--------|------|
| **OpenCode** | `~/.config/opencode/skills/` |
| **Claude Code** | `~/.claude/skills/` |
| **Cursor** | `~/.cursor/agent-skills/` |

## File Format

Each `.skill` file is a zip archive containing a `SKILL.md` — the instruction document your AI assistant reads before performing a task. You can inspect any skill:

```bash
unzip -p project-scope-guard.skill project-scope-guard/SKILL.md
```
