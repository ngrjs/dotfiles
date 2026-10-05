#!/usr/bin/python3
# Claude Code status line: shows plan usage (5h / 7d) when available.
import json, sys
from datetime import datetime

import os, subprocess

try:
    data = json.load(sys.stdin) or {}
except Exception:
    data = {}
rl = data.get("rate_limits") or {}

# robbyrussell-style prompt segments: cwd basename (cyan) + git:(branch) (blue/red)
def prompt_parts():
    out = []
    ws = data.get("workspace") or {}
    cwd = ws.get("current_dir") or data.get("cwd") or ""
    if not cwd:
        return out
    out.append(f"\033[1;36m{os.path.basename(cwd.rstrip('/')) or '/'}\033[0m")
    try:
        br = subprocess.run(
            ["git", "--no-optional-locks", "-C", cwd, "symbolic-ref", "--short", "-q", "HEAD"],
            capture_output=True, text=True, timeout=2).stdout.strip()
        if not br:
            br = subprocess.run(
                ["git", "--no-optional-locks", "-C", cwd, "rev-parse", "--short", "HEAD"],
                capture_output=True, text=True, timeout=2).stdout.strip()
        if br:
            dirty = subprocess.run(
                ["git", "--no-optional-locks", "-C", cwd, "status", "--porcelain", "-uno"],
                capture_output=True, text=True, timeout=2).stdout.strip()
            mark = " \033[33m✗\033[0m" if dirty else ""
            out.append(f"\033[1;34mgit:(\033[31m{br}\033[34m)\033[0m{mark}")
    except Exception:
        pass
    return out

def seg(label, key, fmt):
    d = rl.get(key) or {}
    pct = d.get("used_percentage")
    if pct is None:
        return None
    try:
        pct = float(pct)
    except Exception:
        return None
    clamped = max(0.0, min(100.0, pct))
    filled = int(round(clamped / 10))
    color = "32" if clamped < 50 else ("33" if clamped < 80 else "31")
    bar = f"\033[{color}m{'▓' * filled}{'░' * (10 - filled)}\033[0m"
    s = f"{label} {bar} {round(pct)}%"
    if d.get("resets_at"):
        try:
            t = datetime.fromtimestamp(float(d["resets_at"]))
            s += f" (resets {t.strftime(fmt).lstrip('0').replace(' 0', ' ')}{t.strftime('%p').lower()})"
        except Exception:
            pass
    return s

try:
    pre = prompt_parts()
except Exception:
    pre = []
m = data.get("model") or {}
mname = (m.get("display_name") or m.get("id") or "") if isinstance(m, dict) else ""
model_part = [f"\033[35m{mname}\033[0m"] if mname else []
parts = model_part + pre + [p for p in (seg("5h", "five_hour", "%I:%M"), seg("7d", "seven_day", "%a %I:%M")) if p]
print(" · ".join(parts), end="")
