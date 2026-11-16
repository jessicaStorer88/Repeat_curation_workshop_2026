# TE Curation Workshop

**Two-Day Agenda**

Two days, 9:30 am to 4:00 pm. Day 1 opens with two 30-minute guest talks on genome assemblies. About 3 hours are talks and demos, and 5.5 hours are hands-on work, including about 2.5 hours for participants to curate their own datasets.

## Day 1: Foundations and getting to the edges

- **At a glance:**
  - Talks on genome assemblies
  - Big picture and goals
  - Discussion of [programs, utilities, extending models](../programs)
  - First pass on your own data

| **Time** | **Details** | |
|--------------|:----------|:----------|
| **9:30 PM to 9:50 PM** | **Welcome and setup check** |  (20 min) | 
| | Introductions and a quick poll |  Experience with [`RepeatModeler2`](../programs/RepeatModeler2.md), [`RepeatMasker`](../programs/RepeatMasker.md), command line, and which species or datasets people brought. | 
| | Goals |  Goals for the two days and how the time is split. | 
| | [Environment check](../TE_tools_container/TE_tools_install.md) | Everyone logs in, runs a test command, and finds the practice data. | 
| **9:50 PM to 10:20 PM** |  **Genome assemblies** |  Rachel O'Neill (30 min) | 
| | | 25 minutes plus 5 minutes of questions. | 
| **10:20 PM to 10:50 PM** | **Genome assembly approaches** |  Merly Escalona (30 min) | 
| | | 25 minutes plus 5 minutes of questions. | 
| **10:50 PM to 11:05 PM** | **Break** |  (15 min) | 
| **11:05 PM to 11:40 PM** | **The Big Picture**  | (35 min) | 
| | Curation and `RepeatModeler2` | Why curate? What raw `RepeatModeler2` output looks like: fragmented copies, truncated ends, internal deletions, old diverged copies (10 min).
| | Curation approaches | The three approaches [(whole-genome `RepeatModeler2`, curated related-species library, Progressive Cactus)](../main/README.md): requirements, strengths, limitations. | 
| | Assemblies | Tie back to the assembly talks: all three depend on assembly quality (10 min). |
| | Activity (15 min) | Open discussion of the challenges each of the participants has faced with their datasets thus far. | 
| **11:40 PM to 12:00 PM** |  **The Programs: `RepeatModeler2` and `RepeatMasker`** | (20 min) | 
| | | Discuss what `RepeatModeler2` does and what it samples, what `RepeatMasker` does, how the pieces connect, and the key outputs we will be working with: draft models, `.out` files, and alignments | 
| **12:00 PM to 1:00 PM** |  **Lunch** | (60 min) | 
| **1:00 PM to 1:10 PM** |  **Warm-up survey** | (10 min) | 
| | | Short survey (5 questions) on the morning's material. | 
| **1:10 PM to 1:30 PM** |  **Understanding `RepeatModeler2` and `RepeatMasker` output** | (20 min) | 
| | `RepeatMasker` output | Read a pre-run `RepeatMasker` `.out` file together. What do the columns mean, what does a fragmented hit look like, what does a high-divergence hit look like (10 min). | 
| | Activity | In pairs, find one fragmented hit and one high-divergence hit in your own results (5 min). | 
| | | Questions and troubleshooting (5 min). | 
| **1:30 PM to 2:30 PM** |  **The curation toolkit and getting to the edges** | (60 min) DEMO | 
| | Toolkit tour (15 min) | Where utilities (`rmblast.pl`, `AutoRunBlocker.pl`, `alignAndCallConsensus.pl`, `TSD.pl`, and the UCSC tools) sit in the workflow, and the input and output of each. |
| | Why the edges matter (5 min) | Classification, truncated models, missed copies, redundancy, and what a complete model enables downstream. |
| | Live demo (20 min) | One full round on a practice family: seed alignment (`.stk`), `alignAndCallConsensus.pl`, extend flanking sequence, repeat. |
| | Follow-along (20 min) | Participants repeat the round on the same family in pairs. |
| **2:30 PM to 2:45 PM** |  **Break** | (15 min) | 
| **2:45 PM to 3:30 PM** |  **Guided practice on practice families** | (45 min) | 
| | | How to choose which models to curate (Intro to visualization) | 
| | | Each pair selectes 1-2 practice families. | 
| | | Work through align, call consensus, extend, and check that the edges are reached| 
| **3:30 PM to 3:50 PM** |  **Your data: curation kickoff** | (20 min) | 
| | Curation kickoff | Each participant selects 3 to 5 candidate families from their own `RepeatModeler2` output, ideally with a mix of easy and hard ones.
| | Curation kickoff | Collect copies and build the first seed alignment for one family. If it is hard, start with an easier one and come back later.
| | Curation kickoff | The goal is a running start for Day 2, not finished models. | 
| **3:50 PM to 4:00 PM** |  **Day 1 wrap-up** | (10 min) | 
| | Discussion | One thing that worked, one thing that was confusing | 
| | Preview Day 2 | Optional homework: have any questions ready | 


### Day 2: Quality control, classification, and your own data

- **At a glance:**
  - QC and visualization
  - Classification and redundancy
  - blastx for autonomous TEs
  - Automatic TE curation pipelines
  - Curation studio

| **Time** | **Details** | |
|--------------|:----------|:----------|
| **9:30 PM to 9:45 PM** | **Recap and questions**  | (15 min) |
| | Refresh: worflow pipeline | Questions from the evening, plus any problems with Day 1 data. | 
| **9:45 PM to 10:40 PM** | **Quality control and visualization**  | (55 min) | 
| | Talk and demo (15 min) | Visualizing the multiple sequence alignment in HTML. What a good alignment looks like for the predicted TE, how to spot a pileup of short fragments, and what high divergence looks like. When and how to adjust the alignment score to exclude small fragments and false positives. | 
| | Activity: 'Good, bad, ugly' (20 min) | Show 4 to 5 alignments and have pairs vote: ready to add, extend more, or raise the alignment score? Discuss disagreements. | 
| | Apply to your data (20 min) | Open your own alignments in HTML and decide what each one needs. | 
| **10:40 AM to 10:55 AM** | **Break**  | (15 min) |
| **10:55 AM to 12:00 M** | **Classification and reducing redundancy**  | (65 min) | 
| | Talk (20 min) | Compare (`rmblastn.pl`) to a known library to help determine TE type and confirm the edges, cross-matching to the RepeatModeler2 library to find redundancy after extending, and how to decide which models to keep or discard. Comparison to curated libraries (for example, from a close relative). | 
| | Guided hands-on (25 min) | Run pairwise comparison scripts, both on practice models and decide classification and redundancy together.
| | Apply to your data (20 min) | [rmblastn.pl](http://rmblastn.pl) on your own models and note classification and redundancy calls. | 
| **12:00 PM to 1:00 PM** | **Lunch**  | (60 min) |
| **1:00 PM to 1:10 PM** | **Warm-up poll**  | (10 min) | 
| | Quick poll | Which step has been hardest so far? | 
| **1:10 PM to 1:30 PM** | **Annotating autonomous TEs with NCBI blastx** | (20 min)| 
| | Talk (10 min) | Why protein-level annotation helps for autonomous elements, what to look for in hits (domains, frame, coverage), and how it feeds back into classification.
| | Guided, hands-on (10 min) | Run blastx on practice consensus sequences and interpret the hits. | 
| **1:30 PM to 2:00 PM** | **Automatic TE curation pipelines**  | (30 min) | 
| | Overview (15 min) | What automatic TE curation pipelines do, where they save time, and which steps from this workshop (edges, classification, redundancy) they automate | 
| | Group discussion (10 min) | Where would you trust automatic curation, and where would you still review by hand? | 
| | Connect to your data (5 min) | How the QC steps from Day 2 can be used to check automatic output | 
| **2:00 PM to 2:50 PM** | **Curation studio, part 1**  | (45 min) | 
| | Open work time for your own families | Participants who finish early can pair up to review each other's models using the QC checklist | 
| | 2:35 PM | 5 min. stand-up check: What is blocking people? | 
| **2:50 PM to 3:05 PM** | **Break**  | (15 min) | 
| **3:05 PM to 3:35 PM** | **Curation studio, part 2**  | (30 min) | 
| | Final push | Bring at least one model to the point where you would add it to your curated library, with a type, edges checked, and redundancy checked. |
| **3:35 PM to 4:00 PM** | **Wrap-up**  | (25 min) | 
| | Share-outs (10 min) | Each person or pair shows one finished or nearly finished model and what they did. | 
| | Review the workflow figure and the QC checklist (5 min) | What to do when a model won't resolve | 
| | Next steps (5 min) | Resources, next steps, and how to continue after the workshop | 
| | Feedback form (5 min) | | 

