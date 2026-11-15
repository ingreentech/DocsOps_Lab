#!/usr/bin/env bash
# Rebuilds data/releases.db from the GitHub Releases API.
# Run from the repository root with the virtual environment active.
set -euo pipefail

REPOS="simonw/datasette simonw/sqlite-utils pallets/click encode/httpx"
DB="data/releases.db"
RAW="data/raw"

mkdir -p "$RAW"
rm -f "$DB"

for repo in $REPOS; do
  page=1
  while true; do
    file="$RAW/${repo//\//_}-$page.json"
    echo "Fetching $repo, page $page"
    curl -sS -H "Accept: application/vnd.github+json" \
      "https://api.github.com/repos/$repo/releases?per_page=100&page=$page" \
      -o "$file"

    if [ "$(head -c 1 "$file")" = "{" ]; then
      echo "GitHub API error for $repo:" >&2
      cat "$file" >&2
      exit 1
    fi
    if [ "$(tr -d '[:space:]' < "$file")" = "[]" ]; then
      break
    fi

    sqlite-utils insert "$DB" releases "$file" --pk id --replace --convert '
parts = row["html_url"].split("/")
return {
    "project": parts[3] + "/" + parts[4],
    "tag_name": row["tag_name"],
    "name": row["name"],
    "published_at": row["published_at"],
    "prerelease": int(row["prerelease"]),
    "html_url": row["html_url"],
}'
    page=$((page + 1))
  done
done

sqlite-utils tables "$DB" --counts