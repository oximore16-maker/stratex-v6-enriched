#!/bin/bash
# security-check.sh — STRATEX v6
# Intercepte les commandes dangereuses avant exécution

COMMAND="$BASH_TOOL_COMMAND"
LOG_GLOBAL="$HOME/.claude/security.log"
LOG_LOCAL=".claude/security.log"
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

log() {
    echo "[$TIMESTAMP] $1" >> "$LOG_GLOBAL" 2>/dev/null
    echo "[$TIMESTAMP] $1" >> "$LOG_LOCAL" 2>/dev/null
}

block() {
    log "BLOCKED: $COMMAND — Raison: $1"
    echo "🚫 Commande bloquée : $1"
    echo "Commande : $COMMAND"
    exit 1
}

warn() {
    log "WARNING: $COMMAND — $1"
    echo "⚠️  Attention : $1"
}

# Commandes destructrices système
echo "$COMMAND" | grep -qE 'rm\s+-rf\s+(/|~|/home|/usr|/etc|/var)' && block "Suppression système détectée"
echo "$COMMAND" | grep -qE 'sudo\s+rm' && block "rm avec sudo"
echo "$COMMAND" | grep -qE 'sudo\s+chmod\s+777' && block "chmod 777 avec sudo"

# Exécution de scripts distants non vérifiés
echo "$COMMAND" | grep -qE 'curl.+\|\s*(bash|sh|zsh)' && block "Exécution de script distant"
echo "$COMMAND" | grep -qE 'wget.+\|\s*(bash|sh|zsh)' && block "Exécution de script distant"
echo "$COMMAND" | grep -qE 'eval\s*\$\(curl' && block "eval sur script distant"

# Git dangereux
echo "$COMMAND" | grep -qE 'git\s+push\s+--force.*(main|master)' && block "git push --force sur main/master — interdit"
echo "$COMMAND" | grep -qE 'git\s+push\s+--force' && warn "git push --force sur branche feature — action irréversible"
echo "$COMMAND" | grep -qE 'git\s+reset\s+--hard' && warn "git reset --hard — modifications perdues"

log "OK: $COMMAND"
exit 0
