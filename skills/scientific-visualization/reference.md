## What it does

`scientific-visualization` creates and audits truthful, accessible, publication-ready scientific figures using Matplotlib, Seaborn, and Plotly.

Key capabilities include:
- **Truthful Data Encoding:** Enforces rigorous scientific representation rules, ensuring bars and areas ground at zero, dual-axis distortions are avoided, and transformations (such as logarithmic or normalized scales) are explicitly labeled.
- **Uncertainty and Missing Data Representation:** Mandates clear definitions for error bars (standard deviation, standard error, confidence intervals, or percentiles) alongside sample sizes (`n`), while displaying missing, censored, or excluded observations explicitly rather than silently interpolating across gaps.
- **Accessibility and Universal Design:** Adheres to WCAG 2.2 contrast requirements (4.5:1 for text, 3:1 for graphical boundaries) and enforces colorblind-safe palettes (Paul Tol, Bang Wong, ColorBrewer) with redundant cues (shapes, markers, line styles, direct annotations).
- **Publisher Specification Alignment:** Provides sizing and resolution guidelines for major scientific publishers (Nature Portfolio, Science/AAAS, Cell Press, Elsevier, IEEE, PLOS), covering single-column and multi-column dimensions, minimum DPI targets (300 to 1,000 DPI), and vector formats.
- **Deterministic Validation:** Bundles offline diagnostic tools in `scripts/` to inspect rendered image metadata, calculate non-text contrast ratios, and verify physical dimensions.

## When to reach for it

Reach for `scientific-visualization` when generating figures for peer-reviewed manuscripts, grant applications, academic presentations, or technical documentation.

| Your situation | Where to go |
| --- | --- |
| Generating publication-grade plots and multi-panel figures | `scientific-visualization` |
| Auditing existing charts for contrast, accessibility, and deceptive encodings | `scientific-visualization` |
| Writing or revising the manuscript text and figure captions | `scientific-writing` |
| Designing slide decks for conference presentations | `scientific-slides` |
| Reviewing figures within an incoming manuscript as a referee | `peer-review` |

## Common questions

**Which plotting frameworks are supported?**

The skill supports Matplotlib, Seaborn, and Plotly. For publication figures, vector export (PDF or EPS) via Matplotlib or high-resolution raster export (TIFF at 300 or 600 DPI) via Pillow is recommended. Plotly static export is supported through Kaleido v1 with a compatible Chromium runtime.

**How does the skill handle missing or censored observations?**

Missing observations must never be connected by unbroken lines, which falsely implies observed continuity. The skill guides the use of broken line segments, distinctive marker styles, or dedicated missing-data panels to represent gaps and right- or left-censored thresholds truthfully.

**Can a single palette guarantee accessibility across all media?**

No single color scheme guarantees accessibility in every context. The skill pairs color selection with redundant encoding: distinct line patterns (solid, dashed, dotted), varying marker shapes (circles, triangles, squares), and direct text labels. Figures should also remain fully interpretable when printed in grayscale.

**How are multi-panel figures sized for journal submission?**

Publishers enforce strict column widths: typically 85 to 90 mm for single-column figures and 170 to 180 mm for full-page width. Creating figures at target physical dimensions prevents unreadable downscaling of text and lines during publisher typesetting.

## It's working if

- Bar charts and area charts maintain zero-value baselines.
- Every uncertainty display specifies the metric (SD, SE, 95% CI) and replication unit (`n`).
- Color palettes pass colorblind accessibility checks with redundant geometric cues.
- Figures intended for print match target column dimensions (for example, 89 mm or 180 mm) at 300+ DPI.
- Multi-panel figures use uniform typography, aligned axes, and consistent categorical keys across panels.
