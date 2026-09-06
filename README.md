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

## Homepage architecture
`index.html` is the homepage master and contains protected areas. See `HOMEPAGE_PROTECTION.md` for the maintenance contract.

Protected areas include the desktop/mobile header icons, footer icons, Games section, Latest Videos section and its thumbnail/data contract, plus the distinct profile/community assets.

## Automation
Only `update-youtube.yml` is intended to remain as a recurring site automation. It updates generated video/podcast content and must not rewrite the homepage structure.

`protect-homepage-architecture.yml` validates protected homepage markers on pull requests targeting `main`.

## Maintenance rule
Do not introduce one-time self-modifying workflows for normal page edits. Make targeted pull requests to the affected file instead. If a protected homepage area genuinely needs to change, make that change deliberately and update the protection contract in the same review.
