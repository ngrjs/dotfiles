#!/usr/bin/python3
# PreToolUse hook: block dangerous Bash commands no matter how they're phrased
# (permission deny rules only match the start of a command).
import json
import re
import sys

BLOCKED = [
    (r"\bgit\s+(-[cC]\s+\S+\s+|--?\S+\s+)*push\b", "git push"),
    (r"\bgit\s+(-[cC]\s+\S+\s+)*reset\s+.*--hard\b", "git reset --hard"),
    (r"\brm\s+(-\S+\s+)*-[a-zA-Z]*(r[a-zA-Z]*f|f[a-zA-Z]*r)", "rm -rf"),
    (r"\brm\s+.*(-[a-zA-Z]*[rR]\b.*-[a-zA-Z]*f\b|-[a-zA-Z]*f\b.*-[a-zA-Z]*[rR]\b|--recursive.*--force|--force.*--recursive)", "rm -rf"),
    (r"(^|[;&|(`\s])sudo\b", "sudo"),
]

command = json.load(sys.stdin).get("tool_input", {}).get("command", "")
for pattern, name in BLOCKED:
    if re.search(pattern, command):
        print(f"Blocked by guard-bash hook: {name} is not allowed.", file=sys.stderr)
        sys.exit(2)
