#!/usr/bin/env bash
set -euo pipefail
python3 - <<'PY'
from pathlib import Path
p=Path('index.html'); s=p.read_text(encoding='utf-8')
css='''<style id="liuksoryu-surgical-fix">.social svg{fill:currentColor}.social:nth-child(n+4){display:grid}.footer-socials{display:flex;gap:8px;align-items:center;justify-content:flex-end;min-width:0}.footer-social{flex:0 0 44px}.footer-social svg{fill:currentColor}@media(max-width:900px){.footer-inner{flex-direction:column;align-items:center;gap:18px}.footer-right{width:100%;align-items:center}.footer-socials{justify-content:center}}@media(max-width:600px){.footer-socials{width:100%;justify-content:flex-start;overflow-x:auto;scrollbar-width:none}.footer-socials::-webkit-scrollbar{display:none}.footer-social{flex-basis:42px;width:42px;height:42px}}</style>'''
if 'id="liuksoryu-surgical-fix"' not in s: s=s.replace('</head>',css+'</head>',1)
# Footer: keep the existing footer-only social links and add Spotify once.
if 'open.spotify.com/show/3Fa75fsoqh2IGwPEzOxyUg' not in s:
    marker='</div><div class="footer-links">'
    spotify='<a class="footer-social" href="https://open.spotify.com/show/3Fa75fsoqh2IGwPEzOxyUg" target="_blank" rel="noopener" aria-label="Spotify"><svg viewBox="0 0 24 24" aria-hidden="true" fill="currentColor"><path d="M12 2a10 10 0 1 0 0 20 10 10 0 0 0 0-20zm4.4 13.9c-.2.3-.6.4-.9.2-2.6-1.6-5.9-2-9.8-1.1-.4.1-.7-.1-.8-.5-.1-.4.1-.7.5-.8 4.2-1 7.8-.6 10.7 1.2.4.2.5.6.3 1zm1.2-2.6c-.2.4-.7.5-1 .3-3-1.8-7.5-2.3-11-1.2-.4.1-.8-.1-.9-.5-.1-.4.1-.8.5-.9 4-1.2 8.9-.6 12.2 1.4.4.2.5.7.2.9zm.1-2.7C14.1 8.5 8.3 8.3 5 9.4c-.5.2-1-.1-1.1-.6-.2-.5.1-1 .6-1.1 3.8-1.2 10.2-1 14.1 1.4.4.3.6.8.3 1.2-.3.4-.8.6-1.3.3z"/></svg></a>'
    pos=s.find(marker)
    if pos<0: raise SystemExit('footer links marker missing')
    # Insert Spotify immediately before footer links, inside the footer-socials container.
    s=s[:pos]+spotify+s[pos:]
# Remove the four duplicated primary platforms from footer by CSS rather than rewriting their markup.
css2='<style id="liuksoryu-footer-platforms">.footer-socials .footer-social:nth-child(-n+4){display:none!important}</style>'
if 'id="liuksoryu-footer-platforms"' not in s: s=s.replace('</head>',css2+'</head>',1)
# Populate Latest Videos from the existing videos.json, without changing the surrounding section.
if 'id="liuksoryu-video-loader"' not in s:
    js='''<script id="liuksoryu-video-loader">(function(){const grid=document.querySelector('.videos');if(!grid)return;fetch('videos.json').then(r=>{if(!r.ok)throw new Error();return r.json()}).then(data=>{const list=Array.isArray(data)?data:(data.videos||[]);grid.innerHTML='';list.slice(0,5).forEach(v=>{const a=document.createElement('a');a.className='card video';a.href=v.url||v.link||'#';a.target='_blank';a.rel='noopener';const slot=document.createElement('div');slot.className='image-slot';const im=document.createElement('img');im.src=v.thumbnail||v.thumbnail_url||'';im.alt=v.title||'Latest video';im.loading='lazy';slot.appendChild(im);const play=document.createElement('span');play.className='play';play.textContent='▶';slot.appendChild(play);const info=document.createElement('div');info.className='video-info';const title=document.createElement('div');title.className='video-title';title.textContent=v.title||'Latest video';const meta=document.createElement('div');meta.className='video-meta';meta.textContent=v.publishedAt?new Date(v.publishedAt).toLocaleDateString(undefined,{year:'numeric',month:'short',day:'numeric'}):(v.date||'');info.append(title,meta);a.append(slot,info);grid.appendChild(a)})}).catch(()=>{})})();</script>'''
    s=s.replace('</body>',js+'</body>',1)
p.write_text(s,encoding='utf-8')
PY
