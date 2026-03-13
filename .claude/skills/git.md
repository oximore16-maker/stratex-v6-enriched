---
name: git
description: Toutes les opérations Git — commit, push, PR, merge, résolution de conflits. S'active automatiquement après une implémentation validée par review, après un push dont la CI échoue, ou quand des conflits apparaissent. L'utilisateur ne touche jamais à Git directement. Délègue à @stratex-do pour l'exécution.
---

<objective>
L'utilisateur ne sait pas ce qu'est Git. Il ne le saura jamais.
Ce skill absorbe toute la complexité Git et ne retourne que le résultat.
</objective>

<routing>
Selon la situation détectée, activer @stratex-do avec les instructions appropriées :

**Situation : après une implémentation validée**
→ Commit conventionnel + push

**Situation : branche feature complète**
→ Commit + push + PR avec description complète

**Situation : CI/CD en échec après push**
→ Analyser les logs → activer skill `fix` → re-commit

**Situation : conflits de merge**
→ Identifier les conflits → résoudre → finaliser le merge

**Situation : PR avec commentaires de review**
→ Lire les commentaires → appliquer les corrections → re-push
</routing>

<commit-format>
Type obligatoire :
- `feat:` — nouvelle fonctionnalité visible par l'utilisateur
- `fix:` — correction de bug
- `refactor:` — restructuration interne sans changement de comportement
- `docs:` — documentation uniquement
- `chore:` — maintenance, config, dépendances
- `test:` — ajout ou correction de tests

Format : `type(scope): description en anglais, présent, minuscules`
Exemple : `feat(auth): add Google OAuth login`
</commit-format>

<pr-template>
## Quoi
[Ce qui a changé — en français simple]

## Pourquoi
[La raison — besoin utilisateur ou bug résolu]

## Comment tester
1. [Étape 1]
2. [Étape 2]

## Checklist
- [ ] Tests passent
- [ ] Pas de console.log oublié
- [ ] README mis à jour si nécessaire
</pr-template>

<constraints>
- NEVER push --force sur main ou master — interdit sans exception
- Sur une branche feature → push --force autorisé avec annonce explicite uniquement
- NEVER committer .env, node_modules, fichiers de build
- ALWAYS vérifier git status avant tout commit
- Si la CI échoue → activer skill `fix` avant tout
</constraints>
