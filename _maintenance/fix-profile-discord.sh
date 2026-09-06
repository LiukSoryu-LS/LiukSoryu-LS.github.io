#!/usr/bin/env bash
set -euo pipefail
python3 - <<'PY'
from pathlib import Path
import re
p=Path('index.html')
s=p.read_text(encoding='utf-8')
# Restore the intended About/profile asset only in the existing About portrait.
s=s.replace('src="profilediscordcommunity.png"', 'src="Profile(1).png"', 1)
# Correct every Discord SVG glyph on the homepage without touching other social icons.
discord_path='M20.3 4.3A19.8 19.8 0 0 0 15.4 2.8l-.6 1.2a13.7 13.7 0 0 0-5.6 0L8.6 2.8A19.8 19.8 0 0 0 3.7 4.3C.8 8.5-.1 12.6.3 16.7a19.9 19.9 0 0 0 6.1 3.1l1.5-2.1a12.7 12.7 0 0 1-2.4-1.2l.6-.4c4.7 2.2 9.7 2.2 14.4 0l.6.4a12.7 12.7 0 0 1-2.4 1.2l1.5 2.1a19.9 19.9 0 0 0 6.1-3.1c.5-4.1-.4-8.2-3.3-12.4ZM8.7 14.4c-1.4 0-2.6-1.3-2.6-2.9S7.3 8.6 8.7 8.6s2.6 1.3 2.6 2.9-1.2 2.9-2.6 2.9Zm6.6 0c-1.4 0-2.6-1.3-2.6-2.9s1.2-2.9 2.6-2.9 2.6 1.3 2.6 2.9-1.2 2.9-2.6 2.9Z'
# Header Discord anchor: replace its complete SVG path, preserving the anchor/layout.
pat=r'(<a class="social"[^>]*aria-label="Discord"[^>]*>\s*<svg[^>]*)(>)(\s*<path[^>]*>.*?</path>)(\s*</svg>)'
s,n=re.subn(pat, lambda m: m.group(1)+' fill="currentColor"'+m.group(2)+f'<path d="{discord_path}"/>'+m.group(4), s, count=1, flags=re.S)
if n != 1: raise SystemExit('header Discord icon not found')
# Community Discord card: replace only the icon SVG immediately before the DISCORD heading.
pos=s.find('<h3>DISCORD</h3>')
if pos < 0: raise SystemExit('community Discord card not found')
start=s.rfind('<div class="community-icon">',0,pos)
if start < 0: raise SystemExit('community Discord icon container not found')
end=s.find('</div>',start)
if end < 0: raise SystemExit('community Discord icon closing tag not found')
icon='<div class="community-icon"><svg viewBox="0 0 24 24" aria-hidden="true" fill="currentColor"><path d="'+discord_path+'"/></svg>'
s=s[:start]+icon+s[end:]
# Ensure the Discord glyph cannot be clipped by its tile.
s=s.replace('.social svg{width:20px;height:20px;display:block}', '.social svg{width:20px;height:20px;display:block;overflow:visible}', 1)
p.write_text(s,encoding='utf-8')
PY
rm -f _maintenance/fix-profile-discord.sh .github/workflows/fix-profile-discord-once.yml
git config user.name "github-actions[bot]"
git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
git add index.html _maintenance/fix-profile-discord.sh .github/workflows/fix-profile-discord-once.yml
git commit -m "Fix profile asset and Discord icons"
git push
