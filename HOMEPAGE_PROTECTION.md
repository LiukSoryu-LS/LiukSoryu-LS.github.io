# LIUKSORYU Homepage Protection Contract

`index.html` is the homepage master. Its layout is intentionally protected because it contains several independent systems that previously conflicted during one-off repairs.

## Protected areas

### Header social icons
- YouTube
- Twitch
- Discord
- X
- Desktop and mobile rendering are protected.
- Do not use generic `nth-child` rules to control these icons.

### Footer social icons
- Instagram
- TikTok
- Bilibili
- Spotify
- Desktop and mobile rendering are protected.
- Keep footer selectors separate from the header social selectors.

### Games
- Preserve the `.games` container, game cards, game names, and image slots.
- Do not replace or restructure the game-card markup as part of unrelated work.
- Preserve the existing game assets and responsive behavior.

### Latest Videos
- Preserve the `.videos` container and `.video` card structure.
- The homepage reads generated data from `videos.json`.
- Video records must retain their thumbnail field so thumbnails continue to render.
- Content automation may refresh `videos.json`, but must not rewrite the homepage video markup or loader.

### Profile/community assets
- `Profile.jpg` is the personal About/profile portrait.
- `profilediscordcommunity.png` is the community/logo artwork.
- These assets are intentionally different and must never be substituted for one another.

## Automation policy

Only `update-youtube.yml` is a recurring content automation. It may update `videos.json` and podcast content. It must not modify `index.html`.

`protect-homepage-architecture.yml` runs on pull requests targeting `main` and checks the protected contract before a change is merged.

Do not create one-time self-modifying workflows to patch `index.html`. For homepage changes, make a deliberate, surgical pull request and preserve the protected areas unless the change explicitly targets one of them.
