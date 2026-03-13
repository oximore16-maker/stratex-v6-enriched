#!/bin/bash
# session-end.sh — STRATEX v6
# Écrit un signal de fin de session que Claude lira au démarrage suivant.
# Note : ce hook ne peut pas appeler un skill Claude Code directement.
# C'est Claude lui-même qui active le skill memory en fin de session (voir CLAUDE.md).

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Créer .stratex/ si absent
mkdir -p ".stratex" 2>/dev/null

# Écrire le signal — sera lu au prochain démarrage
echo "[$TIMESTAMP] Session terminée — memory non encore exécuté" > ".stratex/session-ended"

# Log de session
LOG="$HOME/.claude/sessions.log"
echo "[$TIMESTAMP] Session terminée" >> "$LOG" 2>/dev/null

exit 0
