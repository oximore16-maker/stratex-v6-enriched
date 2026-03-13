---
name: review
description: Analyse qualité du code avec scoring 0-100 et verdict GO/NOGO. S'active automatiquement avant tout merge, après toute implémentation, ou quand l'utilisateur veut valider son code. En dessous de 90, le code ne part pas en production. Point final.
---

<objective>
Garantir que rien de médiocre ne part en production.
Un score chiffré. Un verdict binaire. Des corrections actionnables.
</objective>

<scoring>
## Scoring selon la maturité du projet

### Projet mature — suite de tests existante
| Dimension | Points | Critère de succès |
|---|---|---|
| Tests | 30 pts | Couverture ≥ 90%, happy path + edge cases |
| Sécurité | 30 pts | Zéro finding critique ou HIGH |
| Documentation | 20 pts | Fonctions documentées, README à jour |
| Performance | 20 pts | Pas de N+1, pas de boucle inutile |
| **Seuil GO** | **90/100** | En dessous → NOGO, corrections requises |

### Projet débutant — pas encore de suite de tests
| Dimension | Points | Critère de succès |
|---|---|---|
| Tests | 15 pts | Au moins un test existe pour la feature livrée |
| Tests manuels | 15 pts | Les fonctionnalités critiques sont testables manuellement et documentées |
| Sécurité | 30 pts | Zéro finding critique ou HIGH |
| Documentation | 20 pts | Fonctions documentées, README à jour |
| Performance | 20 pts | Pas de N+1, pas de boucle inutile |
| **Seuil GO** | **90/100** | En dessous → NOGO, corrections requises |

**Comment détecter la maturité :** Si aucun fichier de test n'existe dans le projet → mode débutant activé automatiquement. Si une suite de tests existe → mode mature.

Règle absolue : un finding de sécurité critique = score sécurité = 0 = NOGO automatique, quelle que soit la maturité du projet.
</scoring>

<workflow>
1. Lire le git diff ou les fichiers modifiés
2. Lancer les vérifications disponibles (tsc, tests, lint)
3. Scorer chaque dimension avec justification
4. Verdict final GO ou NOGO
5. Si NOGO → liste exacte des corrections pour atteindre 90
6. Si GO → activer skill `git` automatiquement
</workflow>

<o>
### Template — projet mature (suite de tests existante)
<review>
## Score — [feature]

| Dimension | Score | /Max | Détail |
|---|---|---|---|
| Tests | [X] | /30 | [observation] |
| Sécurité | [X] | /30 | [observation] |
| Documentation | [X] | /20 | [observation] |
| Performance | [X] | /20 | [observation] |
| **TOTAL** | **[X]** | **/100** | |

## Verdict
[✅ GO — Prêt pour merge]
[🚫 NOGO — Corrections requises]

## Pour atteindre 90
[Liste des corrections si NOGO — vide si GO]

## Findings
### 🔴 Bloquants
[fichier:ligne — problème — fix]

### 🟠 Importants
[description + fix]

### 🟡 Mineurs
[liste courte]
</review>

### Template — projet débutant (pas encore de suite de tests)
<review>
## Score — [feature] (mode débutant)

| Dimension | Score | /Max | Détail |
|---|---|---|---|
| Tests | [X] | /15 | Au moins un test pour la feature |
| Tests manuels | [X] | /15 | Fonctionnalités critiques testables et documentées |
| Sécurité | [X] | /30 | [observation] |
| Documentation | [X] | /20 | [observation] |
| Performance | [X] | /20 | [observation] |
| **TOTAL** | **[X]** | **/100** | |

## Verdict
[✅ GO — Prêt pour merge]
[🚫 NOGO — Corrections requises]

## Pour atteindre 90
[Liste des corrections si NOGO — vide si GO]

## Findings
### 🔴 Bloquants
[fichier:ligne — problème — fix]

### 🟠 Importants
[description + fix]

### 🟡 Mineurs
[liste courte]
</review>
</o>

---

## Vérification du Definition of Done

Avant le scoring 0-100, vérifier si `.stratex/brief.md` existe.

**Si `brief.md` n'existe pas** → passer directement au scoring. La vérification DoD ne s'applique pas — le projet a démarré sans passer par `explore`.

**Si `brief.md` existe**, vérifier chaque critère DoD :

### Protocole

1. Lire `.stratex/brief.md` — section "Definition of Done"
2. Vérifier chaque critère objectivement — tester si possible
3. Cocher ✅ ou croix ❌ avec justification
4. Si un critère est ❌ → NOGO automatique, indépendamment du score

### Règle absolue

Un critère DoD non rempli = feature non terminée.
Peu importe le score. Peu importe la qualité du code.
On ne livre pas quelque chose qui ne fait pas ce qu'on avait dit qu'il ferait.

### Ajout à l'output

```
## Definition of Done
- [✅/❌] [critère 1] — [observation]
- [✅/❌] [critère 2] — [observation]
- [✅/❌] [critère 3] — [observation]

DoD complet : [OUI → passer au scoring] [NON → NOGO immédiat]
```
