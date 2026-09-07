# LIUKSORYU Homepage Contract

The homepage is a protected UI surface. Changes must preserve the existing structure and behavior unless a deliberate redesign is explicitly requested.

## Protected runtime components

- Header social navigation: YouTube, Twitch, Discord, X.
- Footer social navigation: Instagram, TikTok, Bilibili, Spotify.
- Games cards and horizontal/mobile scrolling behavior.
- Latest Videos five-card structure and `videos.json` loader.
- Guides links and artwork.
- About section and approved copy.
- Mobile Preview toggle, overlay, device frame, label, close button, iframe, recursion guard, and preview script.
- Protected artwork: `Profile.jpg` and `profilediscordcommunity.png`.

## Change policy

1. Never remove or replace protected components as a side effect of a cosmetic change.
2. Never add generic selectors that can hide or override protected social icons or Mobile Preview UI.
3. Do not add self-modifying repair code, runtime source rewriting, or workflows that rewrite `index.html` after deployment.
4. Prefer surgical CSS/DOM changes over rebuilding the homepage from scratch.
5. Every homepage PR must pass the protection workflow before merge.
6. After a homepage PR, verify both desktop and mobile rendering before considering the change complete.

## Recovery policy

If a protected component is broken, restore the last known-good homepage commit first. Then make a focused fix in a separate PR. Do not layer additional emergency patches on top of a broken page.
