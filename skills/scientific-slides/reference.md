## What it does

`scientific-slides` guides the design, structure, and generation of effective slide decks for academic conferences, seminars, thesis defenses, journal clubs, and professional research presentations.

Key capabilities include:
- **Presentation Structure and Pacing:** Tailors slide counts and narrative flow to specific talk formats, from short conference presentations (5 to 15 minutes) to departmental seminars (45 to 60 minutes) and thesis defenses.
- **Visual-First Slide Design:** Promotes visual hierarchy, generous whitespace, and minimal text density, treating slides as visual anchors while the speaker provides narrative context.
- **Format Flexibility:** Supports editable PowerPoint presentations (via `python-pptx` or PptxGenJS), LaTeX Beamer decks, and image-based PDF slide compilations.
- **Schematic and Diagram Generation:** Offers prompt patterns and helper scripts for creating scientific schematics, flowcharts, and architecture overviews.
- **Presentation Validation:** Bundles validation utilities in `scripts/` to verify duration-to-slide ratios, inspect font legibility, and render slide previews for review.

## When to reach for it

Reach for `scientific-slides` whenever preparing oral scientific talks, lecture materials, or pitch decks.

| Your situation | Where to go |
| --- | --- |
| Creating conference slides, defense presentations, or seminar talks | `scientific-slides` |
| Plotting experimental data and statistical charts for slides | `scientific-visualization` |
| Writing the underlying manuscript, paper abstract, or report | `scientific-writing` |
| Structuring grant proposals or funding presentations | `research-grants` |
| Looking up citations to credit in slide footnotes | `research-lookup` |

## Common questions

**Which slide formats can this skill generate?**

The skill supports three primary workflows:
1. Editable PowerPoint decks using Python scripts (`python-pptx`) or Node.js (`PptxGenJS`) based on bundled templates.
2. LaTeX Beamer decks using modular `.tex` templates located in `assets/`.
3. Image-based presentation decks compiled into PDF files for conceptual overview slides.

**How does the skill prevent overly dense slides?**

The skill enforces the headline-and-visual design pattern: each slide features an assertive takeaway statement at the top, a prominent visual (chart, schematic, or photo) in the center, and minimal supporting bullet points. Detailed spoken explanations belong in speaker notes rather than crowded slide text.

**Is an API key required to create slides?**

No. All templates, design guidelines, pacing calculators, and presentation validators function offline without any external services or API keys. An OpenRouter API key is only required if choosing to run the optional AI image generation scripts in `scripts/`.

**How many slides should be included for a 15-minute conference talk?**

As a rule of thumb, plan for approximately one slide per minute of speaking time, or roughly 12 to 15 substantive slides for a 15-minute talk. Dense multi-slide animations should be avoided in favor of deliberate, focused slides.

## It's working if

- Slides feature strong visual elements rather than walls of text.
- Each slide communicates a single core takeaway message clearly stated in the title area.
- Slide counts align with time constraints (typically 1 to 1.5 minutes per slide).
- Important figures include source citations and readable axis labels.
- Deck transitions follow a logical narrative structure from problem motivation to experimental validation and conclusions.
