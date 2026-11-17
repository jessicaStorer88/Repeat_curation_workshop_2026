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
| | | Each pair selects 1-2 practice families. | 
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
| **9:30 AM to 10:00 AM** | **Recap and questions**  | (30 min) |
| | Refresh: workflow pipeline | Questions from the evening, plus any problems with Day 1 data. | 
| | HTML visualizations and choosing when to curate | Review alignment patterns for each model type; discussing format and how to generate; discuss stats per model | 
| **10:00 AM to 10:30 AM** | **Classification and reducing redundancy**  | (30 min) | 
| |  | Compare (`rmblastn.pl`) to a known library to help determine TE type and confirm the edges, cross-matching to the RepeatModeler2 library to find redundancy after extending, and how to decide which models to keep or discard. Comparison to curated libraries (for example, from a close relative). | 
| **10:30 AM to 10:45 AM** | **Break**  | (15 min) | 
| **10:45 AM to 11:45 AM** | **Curation demo**  | (60 min) |
| | Model 1 (30 min)| From selection to the end! HTML, dot plot, blastx, rmblast | 
| | Model 2 (30 min)| From selection to the end! HTML, dot plot, blastx, rmblast | 
| **11:45 AM to 12:00 PM** | **Applying the scripts to your data**  | (15 min) |
| |  | How do use the scripts to answer your biological questions |  
| **12:00 PM to 12:15 PM** | **Automation**  | (15 min) |
| | Overview (15 min) | What automatic TE curation pipelines do, where they save time, and which steps from this workshop (edges, classification, redundancy) they automate. Where would you trust automatic curation, and where would you still review by hand? | 
| **12:15 PM to 1:15 PM** | **Lunch**  | (60 min) |
| **1:15 PM to 2:15 PM** | **Curation studio**  | (60 min) | 
| |  | Let's work on your data! |  
| **2:15 PM to 2:30 PM** | **Break**  | (15 min) | 
| **2:30 PM to 3:30 PM** | **Curation studio, part 2**  | (60 min) | 
| | | Continue working on your data | 
| **3:30 PM to 4:00 PM** | **Wrap-up and discussion**  | (30 min) | 
| | Discussion (5 min) | Pipeline challenges and resolutions | 
| | Review the workflow figure and the QC checklist (15 min) | What to do when a model won't resolve | 
| | Next steps (10 min) | Resources, next steps, and how to continue after the workshop | 

