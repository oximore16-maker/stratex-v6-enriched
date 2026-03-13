# SECURITY-COMPLIANCE.md
## Règles de sécurité absolues — non négociables

Ces règles s'appliquent toujours, sans exception, avant toute autre considération.
Elles ne sont jamais modifiées par le skill memory.
Elles ne sont pas des préférences. Ce sont des règles.

---

## Règles absolues

### Secrets et credentials
- NEVER écrire de clés API, tokens, mots de passe dans le code
- NEVER committer de fichiers .env
- NEVER logger des données sensibles — mots de passe, tokens, données personnelles
- ALWAYS utiliser des variables d'environnement pour les secrets
- ALWAYS vérifier que .env est dans .gitignore avant tout commit

### Données utilisateurs
- NEVER stocker des mots de passe en clair — toujours hashés (bcrypt minimum)
- NEVER exposer des données d'un utilisateur à un autre sans vérification explicite
- ALWAYS valider les entrées utilisateur côté serveur — jamais faire confiance au client

### Dépendances
- NEVER installer une dépendance sans vérifier sa popularité et sa maintenance
- ALWAYS vérifier les vulnérabilités connues avant d'ajouter une dépendance critique

### Git
- NEVER push --force sur main ou master
- NEVER committer node_modules, fichiers de build, fichiers temporaires

### Exécution de code
- NEVER exécuter du code provenant d'une source non vérifiée
- NEVER eval() sur des données utilisateur

---

## En cas de finding critique

Si un finding de sécurité critique est détecté pendant review :
- Score sécurité = 0
- NOGO automatique
- Correction obligatoire avant toute livraison
- Signal immédiat à l'utilisateur en français simple
