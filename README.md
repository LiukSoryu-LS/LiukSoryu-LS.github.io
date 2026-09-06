# LIUKSORYU Website

Static GitHub Pages site for LIUKSORYU.

## Site pages
- `index.html` — homepage
- `character-guides.html` — character guide index/viewer
- `podcasts.html` — podcast page
- `stream-suggestions.html` — stream suggestions page

## Data and assets
- `videos.json` — latest video data used by the homepage
- `playlist-thumbnails.json` — playlist metadata
- Image assets remain at repository root so existing relative URLs continue to work.
- `character-guide-viewer.css` — shared character guide viewer styles
- `LIUKSORYU_Guide_Builder_OBS_EXPORT_READY_SELF_CONTAINED_CLEANED.html` — guide builder tool

## Automation
Only `update-youtube.yml` is intended to remain as a recurring site automation. It updates generated video/podcast content and is not intended to rewrite the homepage structure.

## Maintenance rule
Do not introduce one-time self-modifying workflows for normal page edits. Make targeted commits to the affected file instead.
