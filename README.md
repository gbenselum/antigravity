# Google Antigravity Safe Commands Policy

This repository contains the global permission configuration policy for [Google Antigravity](https://antigravity.google) agents, pre-approving standard read-only, informational, and navigation shell utilities.

## Overview

By default, Antigravity prompts the user for approval or confines shell commands to sandbox environments depending on the execution preset. 

Antigravity evaluates sensitive agent actions across three prioritized lists:
$$\text{Deny} > \text{Ask} > \text{Allow}$$

Adding commands to `globalPermissionGrants.allow` allows the agent to execute them automatically without blocking for manual confirmation.

## Included Safe Commands

The policy approves the following 22 commands using prefix matching (`command(<name>)`):

| Command | Category | Purpose |
| :--- | :--- | :--- |
| `cat` | File Inspection | Display and concatenate file contents |
| `cd` | Navigation | Change working directory in subshells |
| `cut` | Text Processing | Filter columns/fields from text |
| `date` | System Info | Query current date and time |
| `diff` | Comparison | Compare files line by line |
| `du` | Disk Usage | Check file and folder sizes |
| `echo` | Output | Output strings or environment variables |
| `find` | File Search | Search files and directories by name/attributes |
| `gh repo view` | GitHub CLI | View repository details, README, and status |
| `grep` | Text Search | Search regular expressions in files |
| `head` | File Inspection | View first lines of a file |
| `jq` | Data Processing | Parse and query JSON structures |
| `ls` | Directory Listing | List files and directories |
| `ps` | Process Info | Inspect running system processes |
| `pwd` | Navigation | Print current working directory |
| `rg` | Text Search | Fast regex code search (ripgrep) |
| `sort` | Text Processing | Sort lines in text streams |
| `tail` | File Inspection | View last lines or follow log output |
| `uname` | System Info | Display operating system and architecture |
| `wc` | Metrics | Count words, lines, and characters |
| `which` | Binary Path | Locate executable path |
| `whoami` | User Info | Query current username |

## How Prefix Matching Works

In Antigravity, rules specified as `command(<prefix>)` match commands beginning with that token. For example:
- `command(cat)` matches `cat README.md`, `cat file1 file2`, etc.
- `command(gh repo view)` matches `gh repo view`, `gh repo view owner/repo`, etc.
- `command(grep)` matches `grep -rn "pattern" .`
- `command(rg)` matches `rg -i "term"`

If you wish to restrict specific subcommands or unsafe arguments (e.g. `rm -rf`), add them to the `deny` list in your configuration, as `deny` rules always take precedence over `allow` rules.

## Installation

### Method 1: Using the installation script

Run the included installation script to safely merge this policy into your local `~/.gemini/config/config.json`:

```bash
chmod +x install.sh
./install.sh
```

### Method 2: Manual Configuration

Merge the `globalPermissionGrants` block into your `~/.gemini/config/config.json` under `userSettings`:

```json
{
  "userSettings": {
    "globalPermissionGrants": {
      "allow": [
        "command(cat)",
        "command(cd)",
        "command(cut)",
        "command(date)",
        "command(diff)",
        "command(du)",
        "command(echo)",
        "command(find)",
        "command(gh repo view)",
        "command(grep)",
        "command(head)",
        "command(jq)",
        "command(ls)",
        "command(ps)",
        "command(pwd)",
        "command(rg)",
        "command(sort)",
        "command(tail)",
        "command(uname)",
        "command(wc)",
        "command(which)",
        "command(whoami)"
      ],
      "ask": [],
      "deny": []
    }
  }
}
```

### Method 3: Interactive TUI

In any active Antigravity CLI session, you can open the Permissions Manager TUI by running:

```text
/permissions
```
