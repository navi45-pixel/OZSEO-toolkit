#!/bin/bash
# Self-healing launcher: reinstalls dependencies if the sandbox reset wiped them,
# then starts the server.
cd "$(dirname "$0")"
if [ ! -d node_modules/express ] || [ ! -d node_modules/cheerio ]; then
  echo "→ Installing dependencies..."
  npm install express cheerio --no-audit --no-fund --silent
fi
exec node server.js
