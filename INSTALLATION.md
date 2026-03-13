# Guide d'installation — STRATEX v6-enriched

## Prérequis

- **Claude Code** installé sur ta machine
- **Git** installé ([télécharger ici](https://git-scm.com/downloads) si besoin)

---

## Installation en une commande

Ouvre le terminal dans le dossier de ton projet et colle cette commande :

```bash
git clone https://github.com/oximore16-maker/stratex-v6-enriched .claude
```

C'est tout. STRATEX est installé.

---

## Ce qui se passe après l'installation

Ton projet contient maintenant un dossier `.claude/` avec :

```
ton-projet/
└── .claude/
    ├── CLAUDE.md
    ├── SECURITY-COMPLIANCE.md
    ├── CONVENTIONS.md
    ├── CONSIDERATIONS.md
    ├── settings.json
    ├── agents/
    ├── skills/
    └── hooks/
```

---

## Configuration initiale

Ouvre le fichier `.claude/CLAUDE.md` et remplis la section **"Projet courant"** :

```markdown
## Projet courant

**WHAT :** Ton application en une phrase
**WHY :** L'objectif métier
**HOW :** Ton approche technique
**STACK :** Langage, framework, outils
**TESTS :** Comment tu testes
```

---

## Lancer STRATEX

Ouvre Claude Code dans le dossier de ton projet et parle en français naturel.

Exemples :
- *"Je veux créer une app pour..."* → STRATEX active `explore`
- *"Ajoute une page de connexion"* → STRATEX active `build`
- *"Corrige cette erreur"* → STRATEX active `fix`
- *"Fais passer tous les tests"* → STRATEX active `ralph-loop`

---

## Mise à jour

Pour récupérer la dernière version de STRATEX :

```bash
cd .claude
git pull
```

---

## Problème ou retour

Ouvre une issue sur le repo :
[https://github.com/oximore16-maker/stratex-v6-enriched/issues](https://github.com/oximore16-maker/stratex-v6-enriched/issues)

---

*STRATEX v6-enriched — créé par Oximore*  
*Licence CC BY-NC 4.0*
