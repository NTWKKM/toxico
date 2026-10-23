#!/usr/bin/env bash
set -euo pipefail

# scripts/check-links.sh
# Verifies all internal relative files exist and HEAD-checks external URLs.

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
INDEX_FILE="$BASE_DIR/index.html"

echo "=== Toxico Index: Link Health Check ==="
echo "Scanning: $INDEX_FILE"

PASS_COUNT=0
WARN_COUNT=0
FAIL_COUNT=0

# Extract URLs from SECTIONS_DATA href fields
while IFS= read -r href; do
  [[ -z "$href" ]] && continue

  if [[ "$href" =~ ^https?:// ]]; then
    # YouTube video availability check via oEmbed API (returns 404 for deleted/private/non-existent videos)
    if [[ "$href" =~ ^https://www\.youtube\.com/watch\?v= ]]; then
      STATUS=$(curl -s -o /dev/null -w "%{http_code}" --get --max-time 8 \
        --data-urlencode "url=$href" --data-urlencode "format=json" \
        "https://www.youtube.com/oembed" || echo "000")
      case "$STATUS" in
        200)     echo "[PASS] [$STATUS] $href"; ((PASS_COUNT++)) || true ;;
        401|403) echo "[WARN] (embed disabled/private [$STATUS]) $href"; ((WARN_COUNT++)) || true ;;
        *)       echo "[FAIL] [$STATUS] $href"; ((FAIL_COUNT++)) || true ;;
      esac
      continue
    fi

    # Bot-protected domains: check without hard failure
    if [[ "$href" =~ researchgate\.net|sciencedirect\.com|britannica\.com ]]; then
      # If status is 403 or blocked, mark as warning
      STATUS=$(curl -s -o /dev/null -w "%{http_code}" -I -L --connect-timeout 5 --max-time 8 \
        -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" \
        "$href" || echo "000")
      if [[ "$STATUS" =~ ^(2[0-9]{2}|3[0-9]{2})$ ]]; then
        echo "[PASS] [$STATUS] $href"
        ((PASS_COUNT++)) || true
      else
        echo "[WARN] (Bot-protected [$STATUS]) $href"
        ((WARN_COUNT++)) || true
      fi
      continue
    fi

    # Perform quick HEAD check (follow redirects, max 6s)
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" -I -L --connect-timeout 5 --max-time 8 \
      -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" \
      "$href" || echo "000")

    if [[ "$STATUS" =~ ^(2[0-9]{2}|3[0-9]{2})$ ]]; then
      echo "[PASS] [$STATUS] $href"
      ((PASS_COUNT++)) || true
    else
      # Try GET with range 0-100 in case HEAD is disallowed (e.g. 405)
      GET_STATUS=$(curl -s -o /dev/null -w "%{http_code}" -r 0-100 -L --connect-timeout 5 --max-time 8 \
        -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" \
        "$href" || echo "000")
      if [[ "$GET_STATUS" =~ ^(2[0-9]{2}|3[0-9]{2})$ ]]; then
        echo "[PASS] [$GET_STATUS] $href"
        ((PASS_COUNT++)) || true
      else
        echo "[FAIL] [$STATUS / $GET_STATUS] $href"
        ((FAIL_COUNT++)) || true
      fi
    fi
  else
    # Local relative link (URL-decoded)
    # Decode %20 if present
    LOCAL_PATH="$BASE_DIR/$href"
    if [[ -f "$LOCAL_PATH" ]]; then
      echo "[PASS] [FILE EXISTS] $href"
      ((PASS_COUNT++)) || true
    else
      # Try url-decoded path
      DECODED=$(python3 -c "import urllib.parse, sys; print(urllib.parse.unquote(sys.argv[1]))" "$href" 2>/dev/null || echo "$href")
      if [[ -f "$BASE_DIR/$DECODED" ]]; then
        echo "[PASS] [FILE EXISTS] $DECODED"
        ((PASS_COUNT++)) || true
      else
        echo "[FAIL] [FILE NOT FOUND] $href"
        ((FAIL_COUNT++)) || true
      fi
    fi
  fi
done < <(grep -oE "href: '[^']+'" "$INDEX_FILE" | sed -E "s/href: '([^']+)'/\1/")

echo ""
echo "=== Summary ==="
echo "Passed: $PASS_COUNT"
echo "Warnings: $WARN_COUNT"
echo "Failed: $FAIL_COUNT"

if [[ "$FAIL_COUNT" -gt 0 ]]; then
  echo "Link check completed with failures."
  exit 1
else
  echo "All link checks passed successfully!"
  exit 0
fi
