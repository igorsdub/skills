## What it does

`phylogenetics` guides the reconstruction, statistical testing, and biological interpretation of phylogenetic trees from homologous nucleotide and amino acid sequences.

Key capabilities include:
- **Multiple Sequence Alignment:** Configures MAFFT strategies (such as FFT-NS-2 for speed or L-INS-i for accurate local homology) and alignment trimming using trimAl.
- **Maximum-Likelihood Tree Inference:** Runs IQ-TREE with automated substitution model selection via ModelFinder (`-m MFP`), ultrafast bootstrap support (`-B 1000`), and SH-aLRT branch tests (`-alrt 1000`).
- **Scalable Approximate Inference:** Deploys FastTree for large-scale phylogenomic datasets containing thousands of sequences where full maximum-likelihood optimization is computationally prohibitive.
- **Tree Parsing and Visualization:** Uses the ETE3 toolkit to manipulate tree topologies, root trees at designated outgroups, calculate Robinson-Foulds distances, and render tree figures.
- **Comprehensive Analysis Pipeline:** Bundles `scripts/phylogenetic_analysis.py` to automate end-to-end alignment, model selection, tree reconstruction, and summary generation.

## When to reach for it

Reach for `phylogenetics` when investigating evolutionary relationships, molecular epidemiology, gene family duplication, or microbial phylogenies from sequence data.

| Your situation | Where to go |
| --- | --- |
| Aligning sequences, building trees, and computing branch support | `phylogenetics` |
| Designing publication-quality tree figures and comparative panels | `scientific-visualization` |
| Writing methodology and results sections for evolutionary analyses | `scientific-writing` |
| Retrieving homologous sequences and reference genomes from databases | `paper-lookup` |
| Stress-testing hypotheses about ancestral lineages or transfer events | `what-if-oracle` |

## Common questions

**What external command-line tools are required?**

The workflow requires native binaries for MAFFT and IQ-TREE (version 3 recommended, version 2 supported) or FastTree. For Python tree manipulation, ETE3 (version 3.1.3) runs on Python 3.12. Rendering tree images via ETE3 additionally requires PyQt5.

**When should I use IQ-TREE versus FastTree?**

IQ-TREE is the preferred standard for published phylogenies because ModelFinder selects the statistically best-fit substitution model and calculates rigorous branch support. FastTree uses approximate maximum likelihood and is recommended for large datasets with thousands of taxa where IQ-TREE would take days to run.

**How should nucleotide versus protein sequences be specified?**

Always indicate sequence type using `--type nt` for nucleotides or `--type aa` for amino acids. For protein-coding nucleotide sequences, align in frame or translate to amino acids first to avoid insertion-deletion artifacts that disrupt the codon reading frame.

**Can a single gene tree establish the evolutionary history of a species?**

No. Single gene trees represent the genealogy of a single locus, which can diverge from the true species tree due to incomplete lineage sorting, horizontal gene transfer, unrecognized paralogy, or hybridization. Species-level conclusions generally require multi-locus concatenated or coalescent analyses.

## It's working if

- Input FASTA records use unique identifiers free of Newick punctuation (such as colons, commas, or parentheses).
- Appropriate sequence types (`nt` or `aa`) and substitution models are configured.
- Branch support metrics (such as UFBoot >= 95% and SH-aLRT >= 80%) are reported for key splits.
- Output files include standard Newick trees, alignment logs, and model selection tables.
- Biological conclusions distinguish gene-level topologies from species-level inferences.
