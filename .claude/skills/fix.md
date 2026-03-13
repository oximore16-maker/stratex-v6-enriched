---
name: fix
description: Correction de toutes les erreurs — compilation, tests, lint, CI/CD. S'active automatiquement quand une commande échoue, quand les tests ne passent pas, quand la CI retourne une erreur, ou quand l'utilisateur signale que quelque chose ne fonctionne pas. Identifie la cause, corrige, vérifie que c'est résolu.
---

<objective>
Transformer une erreur en solution sans que l'utilisateur comprenne ce qui s'est passé.
Il signale que "ça marche plus". STRATEX corrige. Il reçoit "c'est réparé".
</objective>

<classification>
Avant de corriger, identifier la catégorie :

| Catégorie | Symptômes | Approche |
|---|---|---|
| Compilation TypeScript | "tsc error", "Type error", "Cannot find module" | Corriger les types, les imports manquants |
| Tests en échec | "FAILED", "X tests failed", assertion errors | Analyser le test, corriger le code ou le test |
| Lint | "ESLint", "Prettier", "Biome error" | Auto-fix si possible, correction manuelle sinon |
| Sécurité | "HIGH severity", "Critical", bandit findings | Escalader vers `review` avant de corriger |
| CI/CD | Pipeline GitHub Actions / GitLab échouée | Lire les logs complets, identifier la cause racine |
| Runtime | Crash en production, erreur 500 | Analyser les logs, reproduire localement d'abord |
</classification>

<workflow>
1. **Lire l'erreur complète** — jamais corriger sans avoir lu le message d'erreur entier
2. **Identifier la cause racine** — pas le symptôme, la cause
3. **Corriger** — fichier par fichier, une erreur à la fois
4. **Vérifier** — relancer la commande qui échouait
5. **Confirmer** — s'assurer qu'aucune autre erreur n'a été introduite
6. **Rendre compte** — expliquer en français ce qui s'est passé et ce qui a été corrigé

Pour les tests en boucle (échec → correction → nouvel échec) :
- Maximum 3 tentatives
- Si toujours en échec après 3 tentatives → escalader à @stratex-think
- **Exception** : si `fix` est activé depuis `ralph-loop` → ne pas escalader, signaler l'échec à `ralph-loop` qui gère le compteur global et décide de la suite
- **Cette exception ne s'applique pas aux findings de sécurité critiques** — un finding critique escalade toujours vers `review`, même depuis `ralph-loop`, sans exception
</workflow>

<constraints>
- NEVER corriger un symptôme sans comprendre la cause
- NEVER introduire une correction qui casse autre chose (vérifier après chaque fix)
- NEVER ignorer un finding de sécurité critique — toujours escalader à `review`
- Si l'erreur est dans un fichier non modifié récemment → chercher la vraie cause ailleurs
</constraints>

<o>
```
## fix — Rapport

### Erreur détectée
[Catégorie + description en français simple]

### Cause racine
[Pourquoi c'est arrivé]

### Correction appliquée
[Fichier(s) modifié(s) + ce qui a changé]

### Vérification
[Résultat après correction — succès ou nouvelle erreur]

### Pour CONSIDERATIONS.md
[Si cette erreur est susceptible de se répéter]
```
</o>
