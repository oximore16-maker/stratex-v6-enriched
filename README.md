# STRATEX v6-enriched

> Système d'exploitation multi-agents pour Claude Code.  
> Construis des produits — sans savoir coder.

**Auteur :** Oximore  
**Licence :** CC BY-NC 4.0  
**Attribution :** STRATEX — créé par Oximore — https://github.com/oximore16-maker/stratex

---

## Table des matières

1. [Qu'est-ce que STRATEX ?](#quest-ce-que-stratex-)
2. [Philosophie fondamentale](#philosophie-fondamentale)
3. [Architecture du système](#architecture-du-système)
4. [Les agents](#les-agents)
5. [Les skills](#les-skills)
6. [Les hooks](#les-hooks)
7. [Le moteur de routing](#le-moteur-de-routing)
8. [Le système de mémoire](#le-système-de-mémoire)
9. [Le système de qualité](#le-système-de-qualité)
10. [Le système de sécurité](#le-système-de-sécurité)
11. [Les chaînes d'activation](#les-chaînes-dactivation)
12. [Scénarios d'usage complets](#scénarios-dusage-complets)
13. [Règles qui ne changent jamais](#règles-qui-ne-changent-jamais)
14. [Structure des fichiers](#structure-des-fichiers)
15. [Installation](#installation)

---

## Qu'est-ce que STRATEX ?

STRATEX est un framework installé dans Claude Code qui transforme l'IA en système d'exploitation autonome pour construire des produits logiciels.

Tu parles en français naturel. STRATEX décide comment traiter ta demande, quel agent mobiliser, dans quel ordre, avec quelle profondeur de réflexion. Tu ne touches jamais à Git. Tu ne sais pas quels agents existent. Tu reçois un résultat.

**Ce que STRATEX n'est pas :**
- Un chatbot qui attend des instructions précises
- Un outil qui exécute des commandes à la lettre
- Un assistant qui demande confirmation à chaque micro-étape

**Ce que STRATEX est :**
- Un système qui comprend l'intention derrière les mots
- Un orchestrateur qui mobilise les bons outils au bon moment
- Un gardien de qualité qui ne livre que du code qui fonctionne

---

## Philosophie fondamentale

### L'utilisateur ne doit jamais toucher à la complexité technique

Quand tu dis "ajoute une page de connexion", STRATEX crée la spec, décompose en tâches, implémente, teste, valide la qualité, commit, et te dit "c'est prêt". Tu n'as jamais vu un message d'erreur TypeScript. Tu n'as jamais tapé `git commit`.

### Chaque erreur devient une règle

STRATEX apprend à chaque session. Chaque bug rencontré, chaque mauvaise décision d'architecture corrigée, chaque pattern qui a bien fonctionné — tout est mémorisé dans `CONSIDERATIONS.md`. La prochaine session commence plus intelligente que la précédente.

### La qualité est un seuil, pas un spectre

Le code part en production ou il ne part pas. Seuil à 90/100. En dessous, correction obligatoire avant de continuer. Un finding de sécurité critique = score 0 = blocage total, quelle que soit la qualité du reste.

### La sécurité prime sur tout

Les règles de `SECURITY-COMPLIANCE.md` s'appliquent avant toute autre considération. Elles ne sont jamais modifiées, jamais contournées, même par le système de mémoire.

---

## Architecture du système

```
projet/
└── .claude/
    ├── CLAUDE.md              ← Cerveau central — routing, mémoire, qualité, sécurité
    ├── SECURITY-COMPLIANCE.md ← Règles absolues — jamais modifiées
    ├── CONVENTIONS.md         ← Standards du projet — grandit automatiquement
    ├── CONSIDERATIONS.md      ← Mémoire permanente — leçons des sessions passées
    ├── settings.json          ← Permissions et hooks
    │
    ├── agents/
    │   ├── stratex-think.md   ← Opus — réflexion profonde, architecture, décisions
    │   ├── stratex-build.md   ← Sonnet — implémentation, construction, validation
    │   └── stratex-do.md      ← Haiku — Git, tâches mécaniques, boilerplate
    │
    ├── skills/
    │   ├── explore.md         ← Transformer une intuition floue en direction claire
    │   ├── prioritize.md      ← Classer plusieurs idées par valeur/effort/dépendances
    │   ├── build.md           ← Pipeline complet : spec → tâches → code → review → git
    │   ├── fix.md             ← Corriger toutes les erreurs — compilation, tests, lint
    │   ├── review.md          ← Scoring qualité 0-100 avec verdict GO/NOGO
    │   ├── git.md             ← Toutes les opérations Git orchestrées
    │   ├── memory.md          ← Mémoire de session — compression, leçons, conventions
    │   ├── ralph-loop.md      ← Boucle autonome jusqu'à l'objectif (max 5 tentatives)
    │   └── oneshot.md         ← Exécution complète sans interruption
    │
    └── hooks/
        ├── security-check.sh       ← Bloque les commandes dangereuses (PreToolUse)
        ├── post-edit-typescript.sh ← Auto-format TypeScript (PostToolUse)
        └── session-end.sh          ← Signal de fin de session (Stop)
```

**Le flux de lecture au démarrage :**

À chaque ouverture de session Claude Code, STRATEX lit dans cet ordre exact :

1. `SECURITY-COMPLIANCE.md` — les règles qui ne changent jamais, toujours en premier
2. `CONVENTIONS.md` — les standards du projet en cours
3. `CONSIDERATIONS.md` — les leçons des sessions passées
4. Crée `SESSION_STATE.md` si absent — journal de la session
5. Si `.stratex/session-ended` existe → active `memory` pour récupérer la dernière session, puis supprime le fichier
6. `SESSION_STATE.md` — l'état courant
7. `.stratex/brief.md` s'il existe — la spec du projet

---

## Les agents

STRATEX utilise trois agents spécialisés. L'utilisateur ne les voit jamais directement — c'est le système de routing qui les mobilise.

### `stratex-think` — Le cerveau (Opus)

**Rôle :** Réfléchit avant que quiconque écrive une ligne de code. Ne code jamais.

**S'active pour :** Architecture, choix technologique, refonte, décisions à long terme, tout ce qui aura un impact dans 3 mois ou plus.

**Deux modes de fonctionnement :**

**Mode standard (décision simple)** — un angle, une contrainte, réponse évidente :
1. Comprend la vraie question sous-jacente
2. Compare minimum 2 options avec avantages/inconvénients concrets
3. Décide et justifie
4. Documente dans `.stratex/adr-[sujet].md`

**Mode dialogue (décision complexe)** — plusieurs angles contradictoires, impact long terme :

Convoque 3 perspectives qui débattent visiblement :
- 🎯 **Vision produit** — défend la valeur perçue et l'impact marché
- ⚙️ **Contrainte technique** — défend la faisabilité et la maintenabilité
- 👤 **Perspective utilisateur** — défend la simplicité et l'adoption

Les trois perspectives peuvent se contredire — c'est voulu. Si elles sont toutes d'accord, la décision n'était pas complexe. Le dialogue dure maximum 3 échanges avant le verdict. Le verdict inclut toujours "ce qu'on sacrifie" — ce que les perspectives perdantes avaient raison de défendre.

**Ultrathink** — S'active automatiquement sur les décisions de niveau 3 (architecture, choix technologique, structure de base de données). Explore jusqu'à 5 angles, remet en question les premières conclusions, identifie les contradictions internes avant de trancher. Signal visible en début de réponse : `🧠 Ultrathink activé`.

**Limite :** Opus intervient au maximum 2 fois par session. Si la limite est atteinte et qu'une décision de niveau 3 survient → STRATEX signale à l'utilisateur et propose deux options : continuer avec Sonnet ou accepter une 3ème intervention Opus exceptionnelle. L'utilisateur décide.

---

### `stratex-build` — Le constructeur (Sonnet)

**Rôle :** Transforme les décisions en code fonctionnel. Travaille toujours avec une spec claire.

**Workflow en 4 phases :**

**Phase 1 — ANALYZE** : Lit `SECURITY-COMPLIANCE.md`, `CONVENTIONS.md`, `CONSIDERATIONS.md`, puis les fichiers concernés par la tâche. Comprend les patterns existants. Ne touche à rien avant d'avoir tout lu.

**Phase 2 — PLAN** : Liste les fichiers qui vont être modifiés, décrit l'approche technique, estime les tâches. Attend la validation de l'utilisateur avant de continuer. *(Annulée si `oneshot` orchestre — la confirmation initiale de oneshot fait office de validation.)*

**Phase 3 — EXECUTE** : Une tâche à la fois. Après chaque tâche, vérifie que rien n'est cassé. Si erreur → correction immédiate. Tient une todo-list dans `SESSION_STATE.md`.

**Phase 4 — VALIDATE** : TypeScript check, tests, build. Si quelque chose échoue → correction avant de passer à `review`.

**Signal stratégique** : Si `stratex-build` découvre en cours d'implémentation que la décision de `stratex-think` crée un problème concret (architecture incompatible, effort 3x supérieur à l'estimation, contradiction avec le codebase) → stoppe immédiatement et remonte avec deux options : réévaluer avec `stratex-think` ou adapter l'implémentation.

---

### `stratex-do` — L'exécutant rapide (Haiku)

**Rôle :** Tâches mécaniques sans réflexion inutile. Rapide et économique.

**Fait :** Commits Git, push, PR, résolution de conflits, renommages en masse, génération de boilerplate, mises à jour de fichiers de config, formatage de code.

**Règles Git :**
- `git status` avant tout commit — toujours
- Messages de commit en anglais, format conventionnel
- NEVER `git push --force` sur `main` ou `master` — interdit sans exception
- Sur branche feature → `push --force` autorisé avec annonce explicite uniquement

---

## Les skills

Les skills sont des procédures que STRATEX active selon la situation. L'utilisateur ne les appelle jamais directement.

### `explore` — De l'intuition à la direction

**S'active quand :** L'utilisateur arrive avec une idée floue, une intention vague.

**Ce qu'il fait en 8 étapes :**
1. Écoute sans filtrer — travaille avec le flou
2. Explore silencieusement le territoire (ce qui existe, ce qui manque, qui souffre du problème)
3. Génère 3 directions vraiment différentes : une **ambitieuse**, une **rapide**, une **inattendue**
4. Identifie le gap réel sur le marché — observation précise, pas de buzzwords
5. Pose **une seule question** — celle qui oriente vers l'une des trois directions
6. Affine selon la réponse
7. Définit le **Definition of Done** — critères objectivement vérifiables
8. Crée `.stratex/brief.md` et passe le relais à `build`

**Definition of Done** : Chaque critère doit être vérifiable objectivement — soit c'est vrai, soit c'est faux. "L'utilisateur peut se connecter avec son email sans erreur" ✅ — "l'interface est propre" ❌.

---

### `prioritize` — Du désordre à l'ordre

**S'active quand :** L'utilisateur a plusieurs idées et ne sait pas par où commencer.

**Scoring sur 3 critères :**

| Critère | Poids | Ce que ça mesure |
|---|---|---|
| Valeur utilisateur | 50% | Est-ce que ça résout un vrai problème ? |
| Effort technique | 30% | Combien de temps pour construire ? (inversé : 5 = facile) |
| Dépendances | 20% | Est-ce que ça bloque ou débloque d'autres features ? |

`Score = Valeur × 0.5 + Effort × 0.3 + Dépendances × 0.2`

Après le classement → transition vers `explore` si l'idée est floue, vers `build` si elle est claire.

---

### `build` — De l'intention au code

**S'active quand :** L'utilisateur veut construire quelque chose de concret.

**Pipeline en 5 étapes :**
1. Crée `.stratex/spec.md` — objectif, périmètre, fichiers cibles, critères d'acceptance vérifiables
2. Crée `.stratex/tasks.md` — maximum 20 tâches de 15-30 min chacune
3. Présente spec + tâches et attend confirmation
4. Active `@stratex-build` pour l'exécution
5. Active `review` automatiquement → si score ≥ 90, active `git`

**Safeguard boucle :** Si la même dimension score 0 sur deux reviews consécutives → stoppe et présente le blocage à l'utilisateur. Le système ne tourne pas indéfiniment.

**Lecture du brief :** Si `.stratex/brief.md` existe (créé par `explore`), `build` le lit avant de créer `spec.md`. La spec formalise le brief — elle ne le remplace pas.

---

### `fix` — De l'erreur à la solution

**S'active quand :** Une commande échoue, des tests ne passent pas, la CI retourne une erreur.

**Classification des erreurs :**

| Catégorie | Symptômes | Approche |
|---|---|---|
| Compilation TypeScript | "tsc error", "Cannot find module" | Corriger les types, les imports |
| Tests en échec | "FAILED", assertion errors | Analyser le test, corriger le code |
| Lint | ESLint, Prettier, Biome | Auto-fix si possible |
| Sécurité | "HIGH severity", "Critical" | Escalader vers `review` avant de corriger |
| CI/CD | Pipeline en échec | Lire les logs complets, trouver la cause racine |
| Runtime | Erreur 500, crash | Reproduire localement d'abord |

**Règle des 3 tentatives :** Maximum 3 essais. Si toujours en échec → escalade à `@stratex-think`.

**Exception ralph-loop :** Si `fix` est appelé depuis `ralph-loop` → signaler l'échec à `ralph-loop`, pas d'escalade à `stratex-think`. Cette exception ne s'applique PAS aux findings de sécurité critiques — un finding critique escalade toujours vers `review`, même depuis `ralph-loop`.

---

### `review` — Le gardien de qualité

**S'active :** Automatiquement avant tout merge ou livraison.

**Détection automatique de la maturité :**

| Mode | Condition | Tests | Sécurité | Docs | Perf |
|---|---|---|---|---|---|
| Projet mature | Suite de tests existante | /30 | /30 | /20 | /20 |
| Projet débutant | Aucun fichier de test | Tests /15 + Manuels /15 | /30 | /20 | /20 |

**Seuil GO : 90/100 dans les deux modes.**

**Règle absolue :** Un finding de sécurité critique = score sécurité = 0 = NOGO automatique.

**Vérification DoD :** Si `.stratex/brief.md` existe → vérifie chaque critère Definition of Done avant le scoring. Un critère non rempli = NOGO immédiat. Si `brief.md` n'existe pas → scoring direct.

**Si GO → active `git` automatiquement.**

---

### `git` — Git invisible

**S'active :** Après validation, après un push dont la CI échoue, quand des conflits apparaissent.

**Routing selon la situation :**
- Implémentation validée → commit + push via `@stratex-do`
- Feature complète → commit + push + PR avec description complète
- CI en échec → activer `fix` → re-commit
- Conflits → résolution → finalisation
- PR avec commentaires → appliquer → re-push

**Format commit :** `type(scope): description en anglais, présent, minuscules`
Types : `feat` / `fix` / `refactor` / `docs` / `chore` / `test`

---

### `memory` — La mémoire qui grandit

**S'active :** En fin de session, quand `SESSION_STATE.md` dépasse 150 lignes, ou au démarrage si `.stratex/session-ended` est présent.

**Mode fin de session :**
1. Analyse décisions, erreurs, patterns, conventions émergées
2. Met à jour `CONSIDERATIONS.md` avec les nouvelles leçons (format : contexte / ce qu'on a appris / règle pour la prochaine fois)
3. Met à jour `CLAUDE.md` section "Leçons apprises" (limite 400 lignes)
4. Compresse `SESSION_STATE.md` (-40% minimum)
5. Alimente `CONVENTIONS.md` avec les décisions de style et de structure

**Mode compression :** `SESSION_STATE.md` > 150 lignes → résume les étapes terminées, conserve intégralement erreurs non résolues et prochaine étape.

**Remontée critique :** Si une leçon de session contredit une règle existante dans `CLAUDE.md` → signal 🔴. L'usage réel remplace toujours la théorie.

**Limites :** Ne modifie jamais la section "Identité" de `CLAUDE.md`. Ne touche jamais à `SECURITY-COMPLIANCE.md`. La section "Routing" est modifiable uniquement sur remontée critique justifiée.

---

### `ralph-loop` — La boucle autonome

**S'active quand :** L'objectif est binaire — "fais passer tous les tests", "zéro erreur TypeScript".

**Workflow :**
1. Reformule l'objectif en critère vérifiable
2. Annonce le plan, attend confirmation
3. Boucle seul — maximum 5 tentatives
4. Ne répète jamais la même correction
5. Rollback si une correction empire les choses

**Conditions d'arrêt :** Succès / Échec après 5 tentatives (escalade utilisateur) / Blocage humain nécessaire.

---

### `oneshot` — Tout en une fois

**S'active quand :** "Fais-le directement", "sans m'interrompre", "livre-moi le résultat".

**Pré-flight check :**
- ✅ Éligible : tâche bien définie, résultat vérifiable, pas de décision d'architecture
- 🚫 Non éligible : tâche vague, impact irréversible sur la production

Annonce le plan, attend une seule confirmation, exécute sans interrompre. Si review GO → `git` s'active automatiquement.

---

## Les hooks

Les hooks s'exécutent automatiquement. L'utilisateur ne les voit jamais.

### `security-check.sh` — PreToolUse[Bash]

S'exécute avant chaque commande bash. Logge tout dans `~/.claude/security.log`.

| Commande | Action |
|---|---|
| `rm -rf /`, `rm -rf ~`, suppression système | 🚫 Bloqué |
| `sudo rm`, `sudo chmod 777` | 🚫 Bloqué |
| `curl ... \| sh`, `wget ... \| sh`, `eval $(curl ...)` | 🚫 Bloqué |
| `git push --force` sur `main`/`master` | 🚫 Bloqué |
| `git push --force` sur branche feature | ⚠️ Avertissement loggé |
| `git reset --hard` | ⚠️ Avertissement loggé |

### `post-edit-typescript.sh` — PostToolUse[Write/Edit sur .ts/.tsx]

Lance automatiquement dans l'ordre après chaque modification TypeScript :
1. **Prettier** si disponible
2. **Biome** si `biome.json` présent (priorité sur ESLint)
3. **ESLint** si `.eslintrc*` ou `eslint.config*` détecté

### `session-end.sh` — Stop

S'exécute quand Claude arrête de générer une réponse. Écrit `.stratex/session-ended`. Au prochain démarrage, si le fichier est présent → `memory` s'active automatiquement puis le fichier est supprimé. Garantit qu'aucune session ne termine sans que les leçons soient mémorisées.

---

## Le moteur de routing

STRATEX évalue silencieusement la complexité et décide seul. Présente le plan → attend le "oui" → exécute.

| Niveau | Signes | Action | Modèle |
|---|---|---|---|
| **Niveau 0 — Exploration** | Idée vague, intention floue | Skill `explore` | Sonnet |
| **Niveau 0 — Priorisation** | Plusieurs idées, hésitation | Skill `prioritize` | Sonnet |
| **Niveau 0 — Oneshot** | "Fais-le directement", tâche précise | Skill `oneshot` | Sonnet |
| **Niveau 0 — Boucle autonome** | Objectif binaire répétitif | Skill `ralph-loop` | Sonnet |
| **Niveau 1 — Simple** | Bug isolé, modification d'un fichier | Traitement direct | Sonnet |
| **Niveau 2 — Standard** | Feature, page, composant, intégration | `@stratex-build` | Sonnet (Opus si finding critique en review) |
| **Niveau 3 — Complexe** | Architecture, choix technologique, refonte | `@stratex-think` → `@stratex-build` | Opus → Sonnet → Haiku |

**Règle fondamentale :** STRATEX ne demande jamais "quelle commande veux-tu utiliser ?".

---

## Le système de mémoire

STRATEX a une mémoire qui grandit sur 4 couches distinctes :

**`CLAUDE.md`** — La configuration vivante. Routing, règles de session, seuils de qualité, règles Git, règles de communication. Section "Leçons apprises" auto-alimentée. Limite 400 lignes.

**`CONSIDERATIONS.md`** — Les leçons permanentes. Chaque erreur, chaque décision qui a mal tourné, chaque pattern qui a bien fonctionné. Lu par tous les agents avant d'agir.

**`CONVENTIONS.md`** — Les standards du projet. Nommage, structure, patterns. Grandit automatiquement. Lu par `stratex-build` avant chaque implémentation.

**`SESSION_STATE.md`** — Le journal de session. Décisions en cours, état courant, fichiers modifiés, prochaine étape. Compressé automatiquement à 150 lignes.

---

## Le système de qualité

Le seuil GO est 90/100.

### Grille projet mature

```
Tests (couverture ≥ 90%)        /30
Sécurité (zéro finding)         /30
Documentation                   /20
Performance (pas de N+1)        /20
─────────────────────────────────────
Seuil GO                    90/100
```

### Grille projet débutant

```
Au moins un test pour la feature    /15
Fonctionnalités testables manuellement /15
Sécurité (zéro finding)            /30
Documentation                      /20
Performance                        /20
─────────────────────────────────────────
Seuil GO                        90/100
```

Le mode débutant permet de commencer sans infrastructure de test complète — mais exige un minimum de couverture dès le premier jour.

**Chaîne DoD :** Si le projet a démarré par `explore` → `brief.md` contient un Definition of Done. Chaque critère est vérifié avant le scoring. Un critère non rempli = NOGO immédiat, score ignoré.

---

## Le système de sécurité

Trois couches indépendantes :

**Couche 1 — `settings.json`** : Liste blanche (`git *`, `npm *`, `find *`, etc.) et liste noire explicite (`rm -rf /`, `sudo rm *`, `curl * | sh`).

**Couche 2 — `security-check.sh`** : Hook bash qui analyse chaque commande avant exécution. Double log global et local.

**Couche 3 — `SECURITY-COMPLIANCE.md`** : Règles comportementales lues par tous les agents. Secrets, données utilisateurs, dépendances, Git, exécution de code. S'appliquent avant toute autre considération. Jamais modifiées par le système de mémoire.

---

## Les chaînes d'activation

### Chaîne projet complet (depuis une idée floue)

```
Utilisateur → STRATEX route → explore
  → brief.md + Definition of Done créés
  → build
    → spec.md + tasks.md créés et validés
    → @stratex-build implémente
    → review
      → DoD vérifié (si brief.md existe)
      → Scoring 0-100
      → Si GO → git → @stratex-do commit + push
      → Si NOGO → @stratex-build corrige → review à nouveau
        → Safeguard : même dimension à 0 deux fois → stoppe, escalade utilisateur
```

### Chaîne décision complexe

```
Utilisateur → STRATEX route → @stratex-think
  → Ultrathink activé (niveau 3)
  → Mode dialogue si décision complexe (3 perspectives, verdict + sacrifices)
  → ADR créé dans .stratex/adr-[sujet].md
  → Validation utilisateur
  → @stratex-build exécute
```

### Chaîne boucle autonome

```
Utilisateur → ralph-loop
  → Objectif reformulé en critère vérifiable
  → Boucle (max 5 tentatives) :
      → Vérification état
      → Succès → rapport final
      → Échec → @stratex-build ou fix
      → Finding sécurité critique → escalade review (même depuis ralph-loop)
      → 5 tentatives épuisées → escalade utilisateur
```

### Chaîne mémoire de session

```
Fin de session → session-end.sh → .stratex/session-ended créé
  ↓
Prochain démarrage → CLAUDE.md lit session-ended
  → skill memory activé
  → CONSIDERATIONS.md mis à jour
  → CONVENTIONS.md alimenté
  → SESSION_STATE.md compressé
  → session-ended supprimé
```

---

## Scénarios d'usage complets

### Scénario A — Projet vierge, idée floue

> "Je veux créer un outil pour aider les freelances à suivre leurs clients"

1. STRATEX détecte intention vague → route vers `explore`
2. Explore génère 3 directions : CRM minimaliste (ambitieux), tableau de bord de suivi (rapide), outil de relance automatique (inattendu)
3. Pose une question : "Tu veux surtout éviter d'oublier des clients ou optimiser tes relances ?"
4. Utilisateur répond → direction choisie affinée
5. Definition of Done défini : "L'utilisateur peut voir qui n'a pas été contacté depuis 30 jours"
6. `brief.md` créé → transition vers `build`
7. `spec.md` + `tasks.md` présentés → validation
8. `@stratex-build` implémente
9. `review` vérifie DoD + scoring 0-100
10. Si GO → `git` commit automatique

### Scénario B — Feature précise sur projet existant

> "Ajoute une authentification Google OAuth"

1. STRATEX détecte niveau 2 standard → `build`
2. `@stratex-build` lit `SECURITY-COMPLIANCE.md`, `CONVENTIONS.md`, `CONSIDERATIONS.md`
3. Crée `spec.md` + `tasks.md` → présente → validation
4. Implémente, valide TypeScript, lance les tests
5. `review` score → si ≥ 90 → `git` commit `feat(auth): add Google OAuth login`

### Scénario C — Choix architectural difficile

> "Je sais pas si je dois utiliser Prisma ou Drizzle"

1. STRATEX détecte niveau 3 → `@stratex-think`
2. Ultrathink activé
3. Mode dialogue : 3 perspectives débattent visiblement
4. Verdict avec "ce qu'on sacrifie"
5. ADR créé dans `.stratex/adr-orm.md`
6. Validation utilisateur → `@stratex-build` implémente

### Scénario D — Boucle de correction

> "Fais passer tous les tests"

1. STRATEX détecte objectif binaire → `ralph-loop`
2. Reformule : "`npm test` retourne 0 erreur"
3. Boucle autonome — max 5 tentatives
4. Rend compte uniquement quand c'est terminé

---

## Règles qui ne changent jamais

**Git :**
- `git push --force` sur `main` ou `master` — interdit sans exception
- Types de commit : `feat` / `fix` / `refactor` / `docs` / `chore` / `test`

**Sécurité :**
- Clés API, tokens, mots de passe → jamais dans le code
- Fichiers `.env` → jamais committés
- Mots de passe → toujours hashés (bcrypt minimum)
- Entrées utilisateur → toujours validées côté serveur

**Qualité :**
- Seuil GO : 90/100 — sans exception
- Finding sécurité critique → score sécurité = 0 → NOGO automatique

**Mémoire :**
- Section "Identité" de `CLAUDE.md` → jamais modifiée
- `SECURITY-COMPLIANCE.md` → jamais modifié par `memory`
- Section "Routing" → modifiable uniquement sur remontée critique justifiée

**Communication :**
- Toujours répondre en français
- Les erreurs techniques → absorbées, solution présentée, jamais le problème brut
- Jamais de jargon technique sans explication immédiate

---

## Structure des fichiers

### Fichiers créés automatiquement par STRATEX

| Fichier | Créé par | Contenu |
|---|---|---|
| `SESSION_STATE.md` | CLAUDE.md au démarrage | Journal de session — décisions, état courant |
| `.stratex/brief.md` | skill `explore` | Intention, solution choisie, DoD |
| `.stratex/spec.md` | skill `build` | Objectif, périmètre, critères d'acceptance |
| `.stratex/tasks.md` | skill `build` | Tâches décomposées (max 20) |
| `.stratex/adr-[sujet].md` | `@stratex-think` | Decision Records — décisions d'architecture |
| `.stratex/session-ended` | hook `session-end.sh` | Signal de fin de session |
| `CONSIDERATIONS.md` | skill `memory` | Leçons permanentes |
| `CONVENTIONS.md` | skill `memory` | Standards du projet |

### Fichiers à remplir par l'utilisateur

| Fichier | Section | Ce qu'il faut mettre |
|---|---|---|
| `CLAUDE.md` | Projet courant | WHAT, WHY, HOW, STACK, TESTS |

---

## Installation

1. Copie le contenu du repo dans ton projet :

```
ton-projet/
└── .claude/    ← colle ici le contenu du zip
```

2. Remplis la section "Projet courant" dans `CLAUDE.md` :

```markdown
## Projet courant

**WHAT :** Ton application en une phrase
**WHY :** L'objectif métier
**HOW :** Ton approche technique
**STACK :** Next.js, TypeScript, PostgreSQL, Prisma
**TESTS :** Vitest + Testing Library
```

3. Ouvre Claude Code dans le dossier de ton projet.

4. Parle naturellement.

---

## Licence

CC BY-NC 4.0 — Utilisation commerciale interdite.  
Attribution obligatoire : **STRATEX — créé par Oximore — https://github.com/oximore16-maker/stratex**

---

*STRATEX v6-enriched — 21 passes de vérification — 0 contradiction détectable par analyse statique*
