# OzSEO Toolkit 🇦🇺

Free all-in-one website audit & SEO toolkit for **Australian businesses** — every state & territory (NSW, VIC, QLD, WA, SA, TAS, ACT, NT).

## What it does

**Page 1 — Free Website Audit (`/`)**
Paste any URL and get 58+ checks across 8 scored categories:

| Category | Checks include |
|---|---|
| On-Page SEO | Title, meta description, H1s, canonical, indexability, alt text, internal links, Open Graph, favicon |
| GEO / AI SEO | JSON-LD schema, llms.txt, FAQ/Article markup, semantic HTML, AI-crawler access in robots.txt (GPTBot, ClaudeBot, PerplexityBot, Google-Extended, CCBot…) |
| Technical & Health | HTTP status, HTTPS, robots.txt, XML sitemap, 404 handling, broken-link scan, DNS (A/AAAA/MX/NS), domain age via RDAP |
| Speed | TTFB, page weight, render-blocking scripts, lazy loading, compression, cache headers + live server probe + Google Lighthouse via free PSI API |
| Security | SSL cert validity & expiry days, 6 security headers, HTTP→HTTPS redirect, SPF & DMARC |
| Mobile | Viewport, touch icons, theme colour, legible font sizes |
| Content | Word count, keyword density, Flesch readability, reading time |
| Local SEO (AU) | .au domain, state/city mentions, AU phone formats, PostalAddress schema, geo meta, Maps embed, ABN, social profiles |

Plus: Google SERP snippet preview, overall A–F grade, plain-English fixes for every warning.

**Page 2 — Free Backlinks & Blogger Directory (`/backlinks`)**
- Free self-serve listing form (validated, persisted to `data/backlinks.json`)
- Filter listings by state & category
- 14 curated free backlink sources for Australia (Google Business Profile, Bing Places, Apple Business Connect, Yellow Pages, TrueLocal, Qwoted, Featured, …)
- Backlink safety tips

## Built entirely on free GitHub repos & free APIs
- [Express](https://github.com/expressjs/express) — web server
- [Cheerio](https://github.com/cheeriojs/cheerio) — HTML parsing
- [Google Lighthouse](https://github.com/GoogleChrome/lighthouse) via the free PageSpeed Insights API (optional `PAGESPEED_API_KEY` env var raises quota)
- Free RDAP for domain age, Node built-ins for DNS/TLS checks

## Run it
```bash
npm install
node server.js        # http://localhost:3000
# or self-healing launcher (reinstalls deps if wiped):
bash start.sh
```

## Deploy to Cloudflare Workers
The same audit engine runs on Cloudflare (`worker.js` + `wrangler.toml`):
```bash
npx wrangler deploy
```
- Pages (`/`, `/backlinks`, `/skills`) are served from `public/` as Static Assets.
- `/api/audit`, `/api/perf`, `/api/speed`, `/api/health` run the identical engine.
- Deterministic checks (HTML parsing, schema, hreflang, robots, links, speed probe)
  produce the **same results** on Workers and Node.
- Runtime-bound checks (raw DNS lookups, TLS certificate inspection) are not
  available in the Workers sandbox — they degrade to an "info" note there.
  For 100% identical reports, host the Node version (optionally behind the
  Cloudflare proxy) or accept the two info-level differences.
- The backlink directory needs storage; on Workers bind a KV or keep it on Node.

## Skills Hub — 25 integrated skill modules
All 25 SEO skill modules are integrated:
- **AUTO** (run in every audit): technical, geo, local, schema, sitemap, hreflang,
  images, content, sxo, ecommerce, maps, audit (scoring), drift (snapshots).
- **Guided playbooks** on `/skills`: cluster, competitor-pages, content-brief,
  plan, flow, page, programmatic, visual/image-gen, google, backlinks, dataforseo.
- **Drift tracking**: each audit is snapshotted per host (data/snapshots.json);
  re-runs show score delta ("92 → 93, +1") in the UI and API.

## API
- `GET /api/audit?url=example.com.au` — full audit JSON
- `GET /api/perf?url=…` — 3-request TTFB/weight probe
- `GET /api/speed?url=…&strategy=mobile|desktop` — Lighthouse via PSI
- `GET|POST /api/backlinks` — directory list / submit listing
