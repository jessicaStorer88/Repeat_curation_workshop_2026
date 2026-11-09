# TE Curation Workshop

**Two-Day Agenda**

Two days, 9:30 am to 4:00 pm. Day 1 opens with two 30-minute guest talks on genome assemblies. About 3 hours are talks and demos, and 5.5 hours are hands-on work, including about 2.5 hours for participants to curate their own datasets.

#

## Day 1: Foundations and getting to the edges

**At a glance:**

- Talks on genome assemblies
- Big picture and goals
- Discussion of [programs, utilities, extending models](../programs)
- First pass on your own data

## **9:30 to 9:50 Welcome and setup check (20 min)**

- Introductions and a quick poll: experience with [RepeatModeler2](../programs/RepeatModeler2.md), [RepeatMasker](../programs/RepeatMasker.md), command line, and which species or datasets people brought.
- Goals for the two days and how the time is split.
- [Environment check](../TE_tools_container/installation.md): everyone logs in, runs a test command, and finds the practice data.

## **9:50 to 10:20 Genome assemblies: Rachel O'Neill (30 min)**

- 25 minutes plus 5 minutes of questions.

## **10:20 to 10:50 Genome assembly approaches: Merly Escalona (30 min)**

- 25 minutes plus 5 minutes of questions.

## **10:50 to 11:05 Coffee break (15 min)**

## **11:05 to 11:40 The Big Picture (35 min)**

- Why curate? What raw RepeatModeler2 output looks like: fragmented copies, truncated ends, internal deletions, old diverged copies (10 min).
- The three approaches [(whole-genome RepeatModeler2, curated related-species library, Progressive Cactus)](../main/README.md): requirements, strengths, limitations.
- Tie back to the assembly talks: all three depend on assembly quality (10 min).
- Activity (15 min): open discussion of the challenges each of the participants has faced with their datasets thus far.

## **11:40 to 12:00 The Programs: RepeatModeler2 and RepeatMasker (20 min)**

- Discuss what RepeatModeler2 does and what it samples, what RepeatMasker does, how the pieces connect, and the key outputs we will be working with: draft models, .out files, and alignments

## **12:00 to 1:00 Lunch (60 min)**

## **1:00 to 1:10 Warm-up survey (10 min)**

- Short survey (5 questions) on the morning's material.

## **1:10 to 1:30 Understanding RepeatModeler2 and RepeatMasker output (20 min)**

- Read a pre-run RepeatMasker .out file together: what do the columns mean, what does a fragmented hit look like, what does a high-divergence hit look like (10 min).
- In pairs, find one fragmented hit and one high-divergence hit in your own results (5 min).
- Questions and troubleshooting (5 min).

## **1:30 to 2:30 The curation toolkit and getting to the edges (60 min) DEMO**

- Toolkit tour (15 min): where utilities (rmblast.pl, AutoRunBlocker.pl, alignAndCallConsensus.pl, TSD.pl, and the UCSC tools) sit in the workflow, and the input and output of each.
- Why the edges matter (5 min): classification, truncated models, missed copies, redundancy, and what a complete model enables downstream.
- Live demo (20 min): one full round on a practice family: seed alignment (.stk), alignAndCallConsensus.pl, extend flanking sequence, repeat.
- Follow-along (20 min): participants repeat the round on the same family in pairs.

## **2:30 to 2:45 Break (15 min)**

## **2:45 to 3:30 Guided practice on practice families (45 min)**

- Each pair gets 2 practice families: a clean full-length family and a truncated family. A diverged family is an optional stretch for pairs who finish early.
- Work through align, call consensus, extend, and check that the edges are reached, including a first look at TSDs with TSD.pl.

## **3:30 to 3:50 Your data: curation kickoff (20 min)**

- Each participant selects 3 to 5 candidate families from their own RepeatModeler2 output, ideally with a mix of easy and hard ones.
- Collect copies and build the first seed alignment for one family. If it is hard, start with an easier one and come back later.
- The goal is a running start for Day 2, not finished models.

## **3:50 to 4:00 Day 1 wrap-up (10 min)**

## Discussion: one thing that worked, one thing that was confusing

## Preview Day 2. Optional homework: have any questions ready

#

# **Day 2: Quality control, classification, and your own data**

**At a glance:**

- QC and visualization
- Classification and redundancy
- blastx for autonomous TEs
- Automatic TE curation pipelines
- Curation studio

## **9:30 to 9:45 Recap and questions (15 min)**

- Walk the workflow figure top to bottom. Questions from the evening, plus any problems with Day 1 data.

## **9:45 to 10:40 Quality control and visualization (55 min)**

- Talk and demo (15 min): visualizing the multiple sequence alignment in HTML. What a good alignment looks like for the predicted TE, how to spot a pileup of short fragments, and what high divergence looks like. When and how to adjust the alignment score to exclude small fragments and false positives.
- Activity: 'Good, bad, ugly' (20 min). Show 4 to 5 alignments and have pairs vote: ready to add, extend more, or raise the alignment score? Discuss disagreements.
- Apply to your data (20 min): open your own alignments in HTML and decide what each one needs.

## **10:40 to 10:55 Coffee break (15 min)**

## **10:55 to 12:00 Classification and reducing redundancy (65 min)**

- Talk (20 min): compare (rmblastn.pl) to a known library to help determine TE type and confirm the edges, cross-matching to the RepeatModeler2 library to find redundancy after extending, and how to decide which models to keep, merge, or discard. Comparison to curated libraries (for example, from a close relative).
- Guided hands-on (25 min): run pairwise comparison scripts, both on practice models and decide classification and redundancy together.
- Apply to your data (20 min): [rmblastn.pl](http://rmblastn.pl) on your own models and note classification and redundancy calls.

## **12:00 to 1:00 Lunch (60 min)**

## **1:00 to 1:10 Warm-up poll (10 min)**

- Quick poll: which step has been hardest so far? Use the answers to decide where to spend time in the studio.

## **1:10 to 1:30 Annotating autonomous TEs with NCBI blastx (20 min)**

- Talk (10 min): why protein-level annotation helps for autonomous elements, what to look for in hits (domains, frame, coverage), and how it feeds back into classification.
- Guided, hands-on (10 min): run blastx on practice consensus sequences and interpret the hits.

## **1:30 to 2:00 Automatic TE curation pipelines (30 min)**

- Overview (15 min): what automatic TE curation pipelines do, where they save time, and which steps from this workshop (edges, classification, redundancy) they automate
- Group discussion (10 min): where would you trust automatic curation, and where would you still review by hand?
- Connect to your data (5 min): how the QC steps from Day 2 can be used to check automatic output

## **2:00 to 2:50 Curation studio, part 1 (45 min)**

- Open work time for your own families. Participants who finish early can pair up to review each other's models using the QC checklist
- At 2:35, five-minute stand-up check: what is blocking people? Put common issues on the board

## **2:50 to 3:05 Break (15 min)**

## **3:05 to 3:35 Curation studio, part 2 (30 min)**

- Final push: bring at least one model to the point where you would add it to your curated library, with a type, edges checked, and redundancy checked.

## **3:35 to 4:00 Wrap-up (25 min)**

- Share-outs (10 min): each person or pair shows one finished or nearly finished model and what they did
- Review the workflow figure and the QC checklist (5 min). What to do when a model won't resolve
- Resources, next steps, and how to continue after the workshop (5 min)

## Feedback form (5 min)

