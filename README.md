# jstack

A curated set of 33 Claude Code skills I actually use day-to-day, packaged for easy install.

Built around three workflows:

1. **Personal knowledge management** — the [Karpathy LLM-Wiki pattern](https://github.com/karpathy/karpathy.github.io/blob/master/llm_wiki.md) on top of an Obsidian vault.
2. **Multi-agent / context engineering** — patterns, evaluation, memory systems for building agent platforms.
3. **Scientific research workflow** — paper lookup, literature reviews, biomed/pharma KG (currently testing).

If you're starting from zero with Claude Code skills, this is a sensible starting kit.

---

## Install

### Option 1 — Install a single skill (recommended)

Pick what you actually need. Browse the [skills directory](skills/), find one, copy just that.

```bash
# Clone the repo somewhere temporary
git clone https://github.com/jstudnic1/jstack.git /tmp/jstack

# Copy ONE skill into your skills dir
cp -r /tmp/jstack/skills/last30days ~/.claude/skills/

# Restart your Claude Code session
```

Replace `last30days` with any skill name from [What's inside](#whats-inside). Each skill is fully self-contained — copy as many or as few as you want. To install several at once, list them:

```bash
cp -r /tmp/jstack/skills/{last30days,defuddle,caveman} ~/.claude/skills/
```

Cleanup the clone afterwards if you don't want it hanging around:

```bash
rm -rf /tmp/jstack
```

### Option 2 — Install by category

Each section under [What's inside](#whats-inside) is a coherent group. Example: install just the Obsidian-related skills:

```bash
cd /tmp/jstack/skills
cp -r defuddle obsidian-markdown obsidian-cli obsidian-bases mcp2cli ~/.claude/skills/
```

### Option 3 — Install everything

Only if you're starting from a near-empty setup or specifically want this whole curation. Otherwise prefer Option 1.

```bash
git clone https://github.com/jstudnic1/jstack.git
cp -r jstack/skills/* ~/.claude/skills/
# restart your Claude Code session
```

---

## What's inside

### Top picks

| Skill | What it does |
|-------|--------------|
| [`last30days`](skills/last30days) | Researches what people actually say about a topic in the last 30 days across Reddit, X, YouTube, TikTok, Hacker News, Polymarket, GitHub, and the web. |
| [`planning-with-files`](skills/planning-with-files) | Manus-style persistent file-based planning (`task_plan.md` + `findings.md` + `progress.md`) with tamper-attestation hooks. Survives `/clear`. |
| [`caveman`](skills/caveman) | Caveman-mode communication — drops filler to cut ~75% tokens while keeping technical accuracy. |
| [`multi-agent-patterns`](skills/multi-agent-patterns) | Supervisor / swarm / handoff patterns, context isolation for multi-agent systems. |
| [`karpathy-guidelines`](skills/karpathy-guidelines) | Behavioral guidelines that reduce common LLM coding mistakes — anti-overcomplication, surgical changes, verifiable success criteria. |

### Wiki & web ingestion

| Skill | What it does |
|-------|--------------|
| [`defuddle`](skills/defuddle) | URL → clean markdown (drops navigation/clutter). Use instead of WebFetch for token savings. |
| [`obsidian-markdown`](skills/obsidian-markdown) | Obsidian-flavored markdown — wikilinks, callouts, frontmatter, embeds. |
| [`obsidian-cli`](skills/obsidian-cli) | CLI operations on Obsidian vaults — read, create, search, manage notes from the shell. |
| [`obsidian-bases`](skills/obsidian-bases) | `.base` file editing — views, filters, formulas. |
| [`mcp2cli`](skills/mcp2cli) | Turns any MCP server, OpenAPI spec, or GraphQL endpoint into a CLI at runtime — no codegen. Saves 96–99% of tokens otherwise wasted on tool schemas. |

### Multi-agent & context engineering

| Skill | What it does |
|-------|--------------|
| [`memory-systems`](skills/memory-systems) | Compares Mem0 / Zep / Letta / LangMem / Cognee. Helps choose persistence architecture for cross-session knowledge. |
| [`context-compression`](skills/context-compression) | KV-cache, structured summarization, compaction patterns for long-running agent sessions. |
| [`context-optimization`](skills/context-optimization) | Observation masking, context budgeting, token-efficiency patterns. |
| [`evaluation`](skills/evaluation) | Multi-dimensional evaluation, LLM-as-judge, quality gates for agent pipelines. |
| [`advanced-evaluation`](skills/advanced-evaluation) | Position bias mitigation, pairwise comparison, automated quality assessment. |
| [`tool-design`](skills/tool-design) | Tool consolidation, MCP design, naming conventions. |

### Process & engineering discipline

| Skill | What it does |
|-------|--------------|
| [`iterative-retrieval`](skills/iterative-retrieval) | Progressive context refinement — addresses the subagent context problem. |
| [`cost-aware-llm-pipeline`](skills/cost-aware-llm-pipeline) | Model routing by complexity (Haiku/Sonnet/Opus), prompt caching, budget tracking. |
| [`eval-harness`](skills/eval-harness) | Eval-driven development framework for Claude Code sessions. |
| [`grill-me`](skills/grill-me) | Interviews you about a plan/design until every branch is resolved. |
| [`diagnose`](skills/diagnose) | Disciplined debug loop: reproduce → minimise → hypothesise → instrument → fix → regression-test. |

### Scientific research & papers (currently testing)

> These skills are part of a research workflow I'm actively evaluating. They work, but my own opinions on them are still forming.

| Skill | What it does |
|-------|--------------|
| [`paper-lookup`](skills/paper-lookup) | Search 10 academic databases via REST APIs — PubMed, PMC, bioRxiv, medRxiv, arXiv, OpenAlex, Crossref, Semantic Scholar, CORE, Unpaywall. |
| [`literature-review`](skills/literature-review) | Systematic literature reviews with verified citations, supports APA/Nature/Vancouver. |
| [`citation-management`](skills/citation-management) | BibTeX, DOI lookups, citation validation. |
| [`scientific-writing`](skills/scientific-writing) | IMRAD structure, reporting guidelines (CONSORT/STROBE/PRISMA). |
| [`peer-review`](skills/peer-review) | Structured manuscript reviews with checklist-based evaluation. |
| [`scholar-evaluation`](skills/scholar-evaluation) | ScholarEval framework for systematic scholarly assessment. |

### Pharma / biomedical (currently testing)

> Aimed at biomedical platform work. Skip if you don't work in this domain.

| Skill | What it does |
|-------|--------------|
| [`primekg`](skills/primekg) | Precision Medicine Knowledge Graph — genes, drugs, diseases, phenotypes. |
| [`medchem`](skills/medchem) | Drug-likeness filters (Lipinski, Veber, PAINS), structural alerts. |
| [`rdkit`](skills/rdkit) | Cheminformatics toolkit — SMILES, descriptors, fingerprints, similarity. |
| [`pyhealth`](skills/pyhealth) | Clinical ML pipelines (MIMIC, eICU, OMOP, EHR modeling). |
| [`pytdc`](skills/pytdc) | Therapeutics Data Commons — ADME, toxicity, DTI datasets. |
| [`benchling-integration`](skills/benchling-integration) | Benchling registry / inventory / ELN via API. |

---

## What's NOT in this repo (and worth knowing about)

[**superpowers**](https://github.com/obra/superpowers) (180k ⭐) — the agentic skills framework I'd recommend above any single skill in this repo. It overrides Claude Code's default behavior and enforces discipline across the full development flow: brainstorming → writing-plans → test-driven-development → verification-before-completion → systematic-debugging → requesting-code-review.

It installs as a Claude Code plugin, not a file copy:

```
/plugin marketplace add obra/superpowers
/plugin install superpowers@obra-superpowers
```

If you take only one thing from this whole stack, take superpowers.

---

## Attribution & licenses

Most skills in this repo come from upstream open-source projects. Their original LICENSE files are preserved under [`licenses/`](licenses/).

| Skills | Upstream | License |
|--------|----------|---------|
| `defuddle`, `obsidian-markdown`, `obsidian-cli`, `obsidian-bases` | [kepano/obsidian-skills](https://github.com/kepano/obsidian-skills) | MIT |
| `planning-with-files` | [OthmanAdi/planning-with-files](https://github.com/OthmanAdi/planning-with-files) | See [licenses/](licenses/) |
| `last30days` | [mvanhorn/last30days-skill](https://github.com/mvanhorn/last30days-skill) | MIT |
| `multi-agent-patterns`, `memory-systems`, `context-*`, `evaluation`, `advanced-evaluation`, `tool-design` | [muratcankoylan/Agent-Skills-for-Context-Engineering](https://github.com/muratcankoylan/Agent-Skills-for-Context-Engineering) | See [licenses/](licenses/) |
| `paper-lookup`, `literature-review`, `citation-management`, `scientific-writing`, `peer-review`, `scholar-evaluation`, `primekg`, `medchem`, `rdkit`, `pyhealth`, `pytdc`, `benchling-integration` | [K-Dense-AI/scientific-agent-skills](https://github.com/K-Dense-AI/scientific-agent-skills) | See [licenses/](licenses/) |
| `caveman` | [JuliusBrussee/caveman](https://github.com/JuliusBrussee/caveman) | See [licenses/](licenses/) |
| `mcp2cli` | [knowsuchagency/mcp2cli](https://github.com/knowsuchagency/mcp2cli) | MIT |

The remaining six skills — `karpathy-guidelines`, `iterative-retrieval`, `cost-aware-llm-pipeline`, `eval-harness`, `grill-me`, `diagnose` — come from my own setup, redistributed under MIT (see [`LICENSE`](LICENSE)).

If you're an upstream author and want changes to attribution, please open an issue or PR.

---

## License

The wrapper repo and the 6 originally-authored skills are MIT (see [`LICENSE`](LICENSE)). Bundled upstream skills retain their original licenses, preserved verbatim in [`licenses/`](licenses/).
