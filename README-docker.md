# Running Phantom locally with Docker on macOS

## Prerequisites
- [Docker Desktop for Mac](https://www.docker.com/products/docker-desktop/) (no Ruby needed)

---

## One-time setup

```bash
# 1. Clone the repo
git clone https://github.com/jamigibbs/phantom.git
cd phantom

# 2. Drop Dockerfile and docker-compose.yml into the repo root
#    (these two files — you're reading the README that came with them)

# 3. Build the image (~2–3 min first time; installs Ruby 2.7 + gems)
docker compose build
```

---

## Daily workflow

```bash
# Start the server
docker compose up

# Visit the site
open http://localhost:4000
```

Edit any file on your Mac — Jekyll picks it up automatically and livereload
refreshes the browser. Press `Ctrl-C` to stop.

---

## Troubleshooting

**Port 4000 already in use**
Another Jekyll server (or AirPlay Receiver on macOS 12+) may be on 4000.
Change the host-side port in `docker-compose.yml`:
```yaml
ports:
  - "4001:4000"
```
Then visit `http://localhost:4001`.

**Gem changes / bundle errors**
If you edit `phantom.gemspec` or `Gemfile`, rebuild the image to pick up
the new dependencies:
```bash
docker compose build --no-cache
```

**Slow polling / file changes not detected**
`--force_polling` is set in the Dockerfile CMD because Docker on macOS uses
a virtualized filesystem (VirtioFS) that doesn't deliver inotify events
reliably inside containers. If you find polling too slow, you can try
removing `--force_polling` — it works on some Docker Desktop versions.

---

## Why Ruby 2.7?

`phantom.gemspec` pins `jekyll ~> 3.8`. Jekyll 3.x has known incompatibilities
with Ruby 3's keyword-argument changes. Ruby 2.7 is the last version that
ships with Jekyll 3's ecosystem cleanly.
