#!/usr/bin/env bash
set -euo pipefail
python3 - <<'PY'
from pathlib import Path
p=Path('index.html')
s=p.read_text(encoding='utf-8')
# Restore the intended About/profile asset everywhere the homepage uses the circular profile portrait.
# Keep logo assets for branding; only target the about portrait and footer portrait by their existing classes.
s=s.replace('<div class="about-portrait"><img src="profilediscordcommunity.png"', '<div class="about-portrait"><img src="Profile(1).png"', 1)
s=s.replace('<div class="footer-brand"><img src="profilediscordcommunity.png"', '<div class="footer-brand"><img src="Profile(1).png"', 1)
# Discord: use the standard simple path and explicit fill/currentColor so the glyph cannot be clipped by inherited SVG styling.
old='''<a class="social" href="https://discord.gg/DwHKtRMX2g" target="_blank" rel="noopener" aria-label="Discord"><svg viewBox="0 0 24 24" aria-hidden="true"><path d="M20.317 4.37a19.791 19.791 0 0 0-4.885-1.515c-.213.38-.45.89-.616 1.293a18.27 18.27 0 0 0-5.632 0 13.66 13.66 0 0 0-.618-1.293A19.736 19.736 0 0 0 3.68 4.37C.533 9.046-.32 13.61.106 18.11a19.9 19.9 0 0 0 6.002 3.03c.49-.67.925-1.38 1.3-2.13a12.75 12.75 0 0 1-2.04-.98c.17-.126.337-.255.5-.386 3.93 1.84 8.18 1.84 12.063 0 .164.131.332.26.502.65-.374 1.33-.702 2.04-.98.376.75.81 1.46 1.3 2.13a19.9 19.9 0 0 0 6.002-3.03c.498-5.22-.85-9.74-3.378-13.74ZM8.02 15.33c-1.18 0-2.15-1.08-2.15-2.4s.95-2.4 2.15-2.4 2.17 1.08 2.15 2.4c0 1.32-.95 2.4-2.15 2.4Zm7.96 0c-1.18 0-2.15-1.08-2.15-2.4s.95-2.4 2.15-2.4 2.17 1.08 2.15 2.4-1.2 2.4-2.15 2.4Z"/></svg></a>'''
new='''<a class="social" href="https://discord.gg/DwHKtRMX2g" target="_blank" rel="noopener" aria-label="Discord"><svg viewBox="0 0 24 24" aria-hidden="true" fill="currentColor"><path d="M20.3 4.3A19.8 19.8 0 0 0 15.4 2.8l-.6 1.2a13.7 13.7 0 0 0-5.6 0L8.6 2.8A19.8 19.8 0 0 0 3.7 4.3C.8 8.5-.1 12.6.3 16.7a19.9 19.9 0 0 0 6.1 3.1l1.5-2.1a12.7 12.7 0 0 1-2.4-1.2l.6-.4c4.7 2.2 9.7 2.2 14.4 0l.6.4a12.7 12.7 0 0 1-2.4 1.2l1.5 2.1a19.9 19.9 0 0 0 6.1-3.1c.5-4.1-.4-8.2-3.3-12.4ZM8.7 14.4c-1.4 0-2.6-1.3-2.6-2.9S7.3 8.6 8.7 8.6s2.6 1.3 2.6 2.9-1.2 2.9-2.6 2.9Zm6.6 0c-1.4 0-2.6-1.3-2.6-2.9s1.2-2.9 2.6-2.9 2.6 1.3 2.6 2.9-1.2 2.9-2.6 2.9Z"/></svg></a>'''
if old not in s: raise SystemExit('header Discord markup not found')
s=s.replace(old,new,1)
# Community Discord icon: same corrected path.
old2='''<div class="community-icon"><svg viewBox="0 0 24 24" aria-hidden="true" fill="currentColor"><path d="M20.3 4.3A19.8 19.8 0 0 0 15.4 2.8l-.6 1.2a13.7 13.7 0 0 0-5.6 0L8.6 2.8A19.8 19.8 0 0 0 3.7 4.3C.8 8.5-.1 12.6.3 16.7a19.9 19.9 0 0 0 6.1 3.1l1.5-2.1a12.7 12.7 0 0 1-2.4-1.2l.6-.4c4.7 2.2 9.7 2.2 14.4 0l.6.4a12.7 12.7 0 0 1-2.4 1.2l1.5 2.1a19.9 19.9 0 0 0 6.1-3.1c.5-4.1-.4-8.2-3.3-12.4Z"/></svg></div>'''
new2='''<div class="community-icon"><svg viewBox="0 0 24 24" aria-hidden="true" fill="currentColor"><path d="M20.3 4.3A19.8 19.8 0 0 0 15.4 2.8l-.6 1.2a13.7 13.7 0 0 0-5.6 0L8.6 2.8A19.8 19.8 0 0 0 3.7 4.3C.8 8.5-.1 12.6.3 16.7a19.9 19.9 0 0 0 6.1 3.1l1.5-2.1a12.7 12.7 0 0 1-2.4-1.2l.6-.4c4.7 2.2 9.7 2.2 14.4 0l.6.4a12.7 12.7 0 0 1-2.4 1.2l1.5 2.1a19.9 19.9 0 0 0 6.1-3.1c.5-4.1-.4-8.2-3.3-12.4Z"/></svg></div>'''
# no-op guard: ensure the community svg is current and explicitly filled.
if old2 not in s:
    # fall back to replacing any community Discord svg block with the corrected markup by locating the Discord card.
    marker='<h3>DISCORD</h3>'
    pos=s.find(marker)
    if pos<0: raise SystemExit('community Discord card not found')
    start=s.rfind('<div class="community-icon">',0,pos)
    end=s.find('</div>',start)+6
    s=s[:start]+new2+s[end:]
else:
    s=s.replace(old2,new2,1)
# Ensure header social SVGs are constrained inside their tile.
s=s.replace('.social svg{width:20px;height:20px;display:block}', '.social svg{width:20px;height:20px;display:block;overflow:visible}',1)
s=s.replace('.header-social svg{width:18px;height:18px}', '.header-social svg{width:18px;height:18px;display:block;overflow:visible}',1)
p.write_text(s,encoding='utf-8')
PY
