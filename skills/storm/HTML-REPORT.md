# STORM Research Visual HTML Report Format

The STORM research findings are rendered as a single, self-contained HTML file written to the OS temp directory. Tailwind CSS and Mermaid.js are loaded from CDNs. Mermaid handles relationship graphs, tension flowcharts, and architecture maps; styled Tailwind containers and inline badges handle editorial cards, perspective decks, and citation matrices.

## Scaffold

```html
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>STORM Research: {{Topic Title}}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script type="module">
      import mermaid from "https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs";
      mermaid.initialize({ startOnLoad: true, theme: "neutral", securityLevel: "loose" });
    </script>
    <style>
      .cite-anchor:target {
        background-color: #fef08a;
        transition: background-color 0.5s ease;
      }
    </style>
  </head>
  <body class="bg-stone-50 text-slate-900 font-sans antialiased">
    <main class="max-w-6xl mx-auto px-6 py-12 space-y-12">
      <!-- Section 1: Header -->
      <header>...</header>

      <!-- Section 2: Expert Perspectives Deck -->
      <section id="perspectives">...</section>

      <!-- Section 3: Consensus vs Disagreement Matrix -->
      <section id="matrix">...</section>

      <!-- Section 4: Comprehensive Cited Article -->
      <section id="article">...</section>

      <!-- Section 5: Verified Sources Ledger -->
      <section id="sources">...</section>
    </main>
  </body>
</html>
```

---

## Visual Sections

### 1. Header and Quick Metrics

Display the topic, execution timestamp, and high-level execution metrics in a clean hero container:

```html
<header class="border-b border-slate-200 pb-8 space-y-4">
  <div class="flex flex-wrap items-center justify-between gap-4">
    <div>
      <span class="inline-block px-2.5 py-0.5 text-xs font-semibold uppercase tracking-wider text-indigo-700 bg-indigo-50 rounded-full border border-indigo-200">
        Stanford STORM Research
      </span>
      <h1 class="text-3xl font-extrabold text-slate-950 mt-2 tracking-tight">
        {{Topic Title}}
      </h1>
      <p class="text-sm text-slate-500 mt-1">
        Generated on {{Date}} &bull; Multi-Perspective Synthesis
      </p>
    </div>
    <!-- Quick Nav -->
    <nav class="flex gap-2 text-sm font-medium">
      <a href="#perspectives" class="px-3 py-1.5 bg-white border border-slate-200 rounded-md shadow-sm hover:bg-slate-50 text-slate-700">Perspectives</a>
      <a href="#matrix" class="px-3 py-1.5 bg-white border border-slate-200 rounded-md shadow-sm hover:bg-slate-50 text-slate-700">Tension Matrix</a>
      <a href="#article" class="px-3 py-1.5 bg-white border border-slate-200 rounded-md shadow-sm hover:bg-slate-50 text-slate-700">Synthesis</a>
      <a href="#sources" class="px-3 py-1.5 bg-white border border-slate-200 rounded-md shadow-sm hover:bg-slate-50 text-slate-700">Sources</a>
    </nav>
  </div>

  <!-- Metric Badges -->
  <div class="grid grid-cols-2 md:grid-cols-4 gap-4 pt-4">
    <div class="p-3 bg-white rounded-lg border border-slate-200 shadow-sm">
      <div class="text-xs text-slate-500 uppercase tracking-wide">Personas Interviewed</div>
      <div class="text-2xl font-bold text-slate-900 mt-0.5">{{Persona Count}}</div>
    </div>
    <div class="p-3 bg-white rounded-lg border border-slate-200 shadow-sm">
      <div class="text-xs text-slate-500 uppercase tracking-wide">Primary Sources</div>
      <div class="text-2xl font-bold text-slate-900 mt-0.5">{{Source Count}}</div>
    </div>
    <div class="p-3 bg-white rounded-lg border border-slate-200 shadow-sm">
      <div class="text-xs text-slate-500 uppercase tracking-wide">Consensus Points</div>
      <div class="text-2xl font-bold text-emerald-600 mt-0.5">{{Consensus Count}}</div>
    </div>
    <div class="p-3 bg-white rounded-lg border border-slate-200 shadow-sm">
      <div class="text-xs text-slate-500 uppercase tracking-wide">Active Tensions</div>
      <div class="text-2xl font-bold text-amber-600 mt-0.5">{{Tension Count}}</div>
    </div>
  </div>
</header>
```

---

### 2. Expert Perspectives Deck

Render each persona as a structured card in a responsive 2 or 3 column grid:

```html
<section id="perspectives" class="space-y-6">
  <div class="border-b border-slate-200 pb-2">
    <h2 class="text-xl font-bold text-slate-900">Expert Perspectives Deck</h2>
    <p class="text-sm text-slate-500">Autonomous personas discovered and interviewed during research.</p>
  </div>

  <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
    <!-- Persona Card -->
    <article class="bg-white rounded-xl border border-slate-200 shadow-sm p-5 space-y-4 flex flex-col justify-between">
      <div class="space-y-3">
        <div class="flex items-center justify-between">
          <span class="px-2 py-0.5 text-xs font-semibold rounded bg-slate-100 text-slate-700 uppercase tracking-wide">
            Perspective 1
          </span>
          <span class="text-xs text-slate-400 font-mono">{{Turns Count}} turns</span>
        </div>
        <h3 class="text-lg font-bold text-slate-900 leading-snug">{{Persona Title}}</h3>
        <div class="text-xs text-slate-600 bg-slate-50 p-2.5 rounded border border-slate-100 italic">
          <strong>Worldview:</strong> {{Worldview Summary}}
        </div>
        <div>
          <div class="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1">Inquiry Angle</div>
          <p class="text-sm text-slate-700 leading-relaxed">{{Inquiry Description}}</p>
        </div>
      </div>
      <div class="border-t border-slate-100 pt-3">
        <div class="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1">Core Takeaway</div>
        <p class="text-xs text-slate-600 font-medium leading-relaxed">{{Key Finding Bullet}}</p>
      </div>
    </article>
  </div>
</section>
```

---

### 3. Consensus vs Disagreement Matrix

Highlight what the evidence proves versus where experts diverge. Combine visual callouts with a Mermaid diagram:

```html
<section id="matrix" class="space-y-6">
  <div class="border-b border-slate-200 pb-2">
    <h2 class="text-xl font-bold text-slate-900">Consensus and Disagreement Matrix</h2>
    <p class="text-sm text-slate-500">Separating established facts from active technical or philosophical debates.</p>
  </div>

  <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
    <!-- Consensus Card -->
    <div class="bg-emerald-50/60 rounded-xl border border-emerald-200 p-5 space-y-3">
      <div class="flex items-center gap-2">
        <span class="w-3 h-3 rounded-full bg-emerald-500"></span>
        <h3 class="text-base font-bold text-emerald-950">Points of Consensus</h3>
      </div>
      <p class="text-xs text-emerald-800">
        Empirical agreements shared across all expert perspectives.
      </p>
      <ul class="space-y-2 text-sm text-emerald-900">
        <li class="flex items-start gap-2">
          <span class="font-bold text-emerald-700 mt-0.5">&check;</span>
          <span>{{Consensus Point 1}}</span>
        </li>
        <li class="flex items-start gap-2">
          <span class="font-bold text-emerald-700 mt-0.5">&check;</span>
          <span>{{Consensus Point 2}}</span>
        </li>
      </ul>
    </div>

    <!-- Active Debates Card -->
    <div class="bg-amber-50/60 rounded-xl border border-amber-200 p-5 space-y-3">
      <div class="flex items-center gap-2">
        <span class="w-3 h-3 rounded-full bg-amber-500"></span>
        <h3 class="text-base font-bold text-amber-950">Active Tensions and Debates</h3>
      </div>
      <p class="text-xs text-amber-800">
        Unresolved trade-offs, philosophical splits, or conflicting benchmarks.
      </p>
      <ul class="space-y-2 text-sm text-amber-900">
        <li class="flex items-start gap-2">
          <span class="font-bold text-amber-700 mt-0.5">&ne;</span>
          <span><strong>{{Tension Title}}:</strong> {{Tension Description}}</span>
        </li>
      </ul>
    </div>
  </div>

  <!-- Mermaid Visual Diagram -->
  <div class="bg-white rounded-xl border border-slate-200 p-5 shadow-sm space-y-3">
    <div class="text-xs font-semibold text-slate-500 uppercase tracking-wider">
      Tension and Trade-Off Map
    </div>
    <div class="overflow-x-auto">
      <pre class="mermaid text-center">
        flowchart TD
          Core[{{Core Topic}}] --> C1[Consensus: Proven Guarantees]
          Core --> T1[Tension: Consistency vs Latency]
          T1 --> P1[Perspective A: Strict Serializability]
          T1 --> P2[Perspective B: Eventual Convergence]
          classDef consensus fill:#ecfdf5,stroke:#10b981,stroke-width:1px,color:#065f46;
          classDef tension fill:#fffbeb,stroke:#f59e0b,stroke-width:1px,color:#92400e;
          class C1 consensus;
          class T1,P1,P2 tension;
      </pre>
    </div>
  </div>
</section>
```

---

### 4. Comprehensive Cited Article

Present the narrative synthesis in prose with clear section headings, structured sub-points, and anchored inline citations:

```html
<section id="article" class="space-y-8 bg-white rounded-xl border border-slate-200 p-8 shadow-sm">
  <div class="border-b border-slate-200 pb-4">
    <h2 class="text-2xl font-extrabold text-slate-900 tracking-tight">Comprehensive Research Synthesis</h2>
    <p class="text-sm text-slate-500 mt-1">Synthesized evidence across all grounded expert interviews.</p>
  </div>

  <div class="prose prose-slate max-w-none space-y-6 text-slate-800 leading-relaxed">
    <section class="space-y-3">
      <h3 class="text-xl font-bold text-slate-900">{{Section 1 Title}}</h3>
      <p>
        Detailed narrative analysis grounded in primary documentation. Every factual statement or benchmark claim is cited directly
        <a href="#source-1" class="text-indigo-600 hover:text-indigo-800 font-mono text-xs font-semibold bg-indigo-50 px-1 py-0.5 rounded border border-indigo-200">[1]</a>.
      </p>
    </section>

    <!-- Callout Box for Key Finding -->
    <div class="p-4 rounded-lg bg-slate-50 border-l-4 border-indigo-500 space-y-1">
      <div class="text-xs font-bold text-indigo-900 uppercase tracking-wide">Key Finding</div>
      <p class="text-sm text-slate-700">{{Critical Insight Summary}}</p>
    </div>
  </div>
</section>
```

---

### 5. Verified Sources Ledger

Display all referenced sources in a clean, searchable, tabular ledger:

```html
<section id="sources" class="space-y-6">
  <div class="border-b border-slate-200 pb-2">
    <h2 class="text-xl font-bold text-slate-900">Verified Sources Ledger</h2>
    <p class="text-sm text-slate-500">Live web and document sources retrieved during research.</p>
  </div>

  <div class="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden">
    <table class="min-w-full divide-y divide-slate-200 text-sm text-left">
      <thead class="bg-slate-50 text-slate-600 text-xs uppercase font-semibold">
        <tr>
          <th class="px-4 py-3 w-16">Ref</th>
          <th class="px-4 py-3">Source Title and Context</th>
          <th class="px-4 py-3 w-40">Domain</th>
          <th class="px-4 py-3 w-32">Retrieved</th>
          <th class="px-4 py-3 w-28 text-right">Link</th>
        </tr>
      </thead>
      <tbody class="divide-y divide-slate-100">
        <tr id="source-1" class="cite-anchor hover:bg-slate-50/70 transition-colors">
          <td class="px-4 py-3 font-mono font-bold text-indigo-600">[1]</td>
          <td class="px-4 py-3 font-medium text-slate-900">
            {{Source Document Title}}
            <div class="text-xs text-slate-500 font-normal mt-0.5">{{Brief excerpt or finding}}</div>
          </td>
          <td class="px-4 py-3 text-slate-500 text-xs font-mono">{{example.org}}</td>
          <td class="px-4 py-3 text-slate-500 text-xs">{{Date}}</td>
          <td class="px-4 py-3 text-right">
            <a href="{{Full URL}}" target="_blank" rel="noopener noreferrer" class="text-indigo-600 hover:underline font-semibold text-xs">
              View Source &rarr;
            </a>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</section>
```

---

## Operating System Browser Launch Commands

After writing the file to the OS temp directory, launch the HTML report using the platform default utility:

- **macOS**:
  ```bash
  open "<path_to_html_file>"
  ```
- **Linux**:
  ```bash
  xdg-open "<path_to_html_file>"
  ```
- **Windows**:
  ```cmd
  start "" "<path_to_html_file>"
  ```

Always print the absolute path of the generated HTML file in chat so the user can easily reopen or copy it.
