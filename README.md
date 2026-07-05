# skills-Epic

Curated collection of AI agent skills for Flutter, Dart, and mobile development workflows. Each skill is a packaged instruction set that trains your AI coding assistant (Claude Code, OpenCode, etc.) to handle specific tasks with precision.

## Skills

| Skill | Description |
|-------|-------------|
| **project-scope-guard** | Keeps work anchored to the project's actual goal and architecture — prevents drift into unrelated features, frameworks, or tangents |
| **flutter-anti-tamper** | Hardens Flutter apps against reverse engineering, decompilation, repackaging, and runtime tampering |
| **flutter-arch-selector** | Prompts to choose MVVM, MVC, or Clean Architecture before writing structural code |
| **flutter-perf-guardian** | Reviews Flutter/Dart code for performance mistakes, jank, unnecessary rebuilds, and anti-patterns |
| **flutter-security-guardian** | Scans for hardcoded secrets, insecure storage, missing cert pinning, and other security issues |
| **flutter-uix-architect** | Scaffolds responsive, clean-code Flutter UI with DI and state management |
| **gh-actions-guardian** | Sets up and maintains GitHub Actions workflows for Flutter/Dart CI/CD and security scanning |
| **gradle-doctor** | Diagnoses and fixes Gradle/Android build errors in Flutter projects |
| **ios-build-doctor** | Diagnoses and fixes iOS/Xcode build errors, CocoaPods, code signing, and provisioning profiles |

## Install

Use the included CLI to install skills to your AI assistant:

```bash
# Install all skills
./skills install all

# Install specific skills
./skills install flutter-perf-guardian flutter-security-guardian

# Install to a custom directory
./skills install all --target ~/.config/opencode/skills

# List available skills
./skills list

# Show where skills are currently installed
./skills status
```

The CLI auto-detects common install targets:

| Target | Path |
|--------|------|
| **OpenCode** | `~/.config/opencode/skills/` |
| **Claude Code** | `~/.claude/skills/` |
| **Custom** | any directory via `--target` |

## File Format

Each `.skill` file is a zip archive containing a `SKILL.md` — the instruction document your AI assistant reads before performing a task.

## Usage

Load a skill in your AI session:

```
@skills load project-scope-guard
```

Or reference it in a prompt:

```
Use the project-scope-guard skill before making changes.
```
