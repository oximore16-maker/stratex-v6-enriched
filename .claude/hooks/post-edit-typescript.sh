#!/bin/bash
# post-edit-typescript.sh — STRATEX v6
# Auto-format après édition d'un fichier TypeScript

FILE="$CLAUDE_TOOL_FILE"

# Prettier
if command -v prettier &> /dev/null; then
    prettier --write "$FILE" --log-level silent 2>/dev/null
fi

# Biome (priorité sur ESLint si présent)
if [ -f "biome.json" ] && command -v biome &> /dev/null; then
    biome check --apply "$FILE" 2>/dev/null
elif find . -maxdepth 1 -name ".eslintrc*" -o -name "eslint.config*" 2>/dev/null | grep -q .; then
    npx eslint --fix "$FILE" --quiet 2>/dev/null
fi

exit 0
