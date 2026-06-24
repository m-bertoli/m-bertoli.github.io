# Academic website — task & plan

## Goal
Build Matteo Bertoli's **personal academic homepage** using the **al-folio** Jekyll
theme (same theme as colleague Kirill Kazantcev: https://kkazantcev.github.io/).
Clean, minimal, single-column. Host TBD (GitHub Pages is the al-folio default).

## Reference sites
- **Kazantcev** — https://kkazantcev.github.io/ — Jekyll + **al-folio**, GitHub Pages.
  Nav: About / Research / CV / Teaching. (Theme we're using.)
- **Sawler** — https://sites.google.com/view/dot-sawler/research — Google Sites.
  Liked its **research-page structure**: Peer-Reviewed → Under Review (R&R) →
  Working Papers → Book Chapters. Use this as the content model for Research.

## Decisions made
- Tooling: **al-folio (Jekyll)**, NOT Google Sites (Sites has no API; all-manual).
- Site location: **`~/academic-website/`** (outside Dropbox, to avoid sync churn
  on build artifacts / vendored gems).
- Pages: **Home/About · Research · CV · Teaching** (mirror the two references).

## Environment / toolchain status (as of pivot)
- macOS system Ruby is **2.6.10** — too old; al-folio needs **Ruby 3.x**.
- Homebrew present (`/opt/homebrew/bin/brew`). Plan: `brew install ruby` (3.x),
  then put its bin on PATH, `gem install bundler`, `bundle install`.
- No `jekyll`, no rbenv/rvm/asdf, **no Docker**, **no `gh` CLI**.
- Node v25 and git present. Home dir is writable.

## Next steps (build order)
1. `brew install ruby` → modern Ruby; export PATH `/opt/homebrew/opt/ruby/bin`.
2. `gem install bundler jekyll`.
3. Get al-folio source into `~/academic-website/` (clone
   https://github.com/alshedivat/al-folio), `bundle install`.
4. `bundle exec jekyll serve` → preview at localhost:4000.
5. Customize:
   - `_config.yml` — name, email, Scholar, GitHub, social links, site title.
   - `_pages/about.md` — home/bio + research interests + profile photo.
   - `_bibliography/papers.bib` + `_pages/publications.md` — Research (al-folio is
     BibTeX-driven). Group like Sawler: published / under review / working papers.
   - CV: drop PDF in `assets/pdf/` and/or fill `_data/cv.yml`; `_pages/cv.md`.
   - `_pages/teaching.md` — chronological, like Kazantcev.
   - Profile photo → `assets/img/prof_pic.*`.
6. Deploy: GitHub Pages via al-folio's built-in GitHub Action (needs a GitHub
   account + repo; `gh` not installed yet) — OR decide hosting later.

## Content still needed from Matteo
- Name + title/position + affiliation (e.g. "PhD candidate, [dept], [university]").
- Links: email to display, Google Scholar URL, GitHub, personal/social.
- **Profile photo** (a file path I can read — NOT `~/Downloads`, sandbox-blocked).
- **CV PDF**: currently `~/Downloads/New_CV__Copy_.pdf` — sandbox can't read
  `~/Downloads`; move/copy it under the project (e.g. into `~/academic-website/`).
- **Papers** for Research: title, coauthors, status (published / R&R / working),
  link — incl. the extremism→welfare paper (its current title + status + link).
- Teaching: course, role, institution, term.
- One-line bio / research interests for the home page.

## Notes / gotchas
- `~/Downloads` is **sandbox-blocked** ("operation not permitted") — any file I
  need to read (CV, photo) must live under Dropbox or `~/academic-website/`.
- al-folio's many native-extension gems (nokogiri, etc.) can be slow to build on
  arm64; allow time on first `bundle install`.
- Keep build artifacts (`_site/`, `vendor/`) out of Dropbox (hence home-dir location).
