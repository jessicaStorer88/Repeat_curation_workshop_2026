# Repeat curation workshop 2026

This GitHub repository is dedicated to materials related to the workshop: 

[Curating transposable element libraries for non-model organisms and assembling through the hard stuff](https://cba.anu.edu.au/news-events/events/curating-transposable-element-libraries-non-model-organisms-and-assembling)

- Occurring: 
  - 17 Nov 2026 9:30 AM - 4:00 PM
  - 18 Nov 2026 9:30 AM - 4:00 PM
- In person
- Location:
  - Jan Anderson Seminar Room (ground floor).
  - Research School of Biology, Australian National University, Canberra.

## How is this respository organized

This repository is set up for easy access to the content that will be discussed throughout the workshop. In the following folders you'll find:
- [`main/`](main/) folder: general content of the workshop, schematics, pipeline descriptions.
- [`programs/`](programs/): there is a description of the tools we will be using and some common utilities that will come in handy as we begin to curate.
- [`scripts/`](scripts/): scripts to run the TE curation pipeline. It may be helpful to read through the programs section first, then edit your own scripts as this will provide a more comprehensive overview.
- [`papers/`](papers/): compilation of papers related to repeat curation. Highly encouraged to check them out!!
- [`resources/`](resources/img): figures/schematics used in the repository. Also, helpful for ease of downloading or viewing.
- [`test/`](test/): instructions and files for testing the container installation 

## Before we start

- All participants will get a temporary UCONN HPC account to follow along with the live demos of the workshop. 
  - Log-ins will be provided to each participant and details will be shared over email.
- We are running all the curation pipelie with the [TE Tools container](https://github.com/Dfam-consortium/TETools). You can find in the [TE tools container folder](TE_tools_container) the instructions on how to download the TE tools container, which hosts all the necessary tools we will be using. 
  - This will be set up for you in the UCONN HPC, however, we are also giving you information to have it working on your own.


## Agenda

- The [workshop agenda](./main/agenda.md) is a general outline for the two day workshop, with the breakdown of sections and what will be covered
- Two days, 9:30 am to 4:00 pm. Day 1 opens with two 30-minute guest talks on genome assemblies. About 3 hours are talks and demos, and 5.5 hours are hands-on work, including about 2.5 hours for participants to curate their own datasets.

> :warning: Please note, this may be subject to minor changes :warning: 

### Day 1: Foundations and getting to the edges

At a glance, talks on genome assemblies, big picture and goals, discussion of [programs, utilities, extending models](programs/README.md), first pass on your own data.

| **Time**                 | **Duration** | **Details** |
|--------------------------|:-------------|:----------|
| **9:30 PM to 9:50 PM**   | 20 min | Welcome and setup check | 
| **9:50 PM to 10:20 PM**  | 25 min talk + 5 min questions | Genome assemblies: Rachel O'Neill | 
| **10:20 PM to 10:50 PM** | 25 min talk + 5 min questions | Genome assembly approaches: Merly Escalona  | 
| **10:50 PM to 11:05 PM** | 15 min | Break |  
| **11:05 PM to 11:40 PM** | 35 min | The Big Picture  | 
| **11:40 PM to 12:00 PM** | 20 min | The Programs: `RepeatModeler2` and `RepeatMasker`  | 
| **12:00 PM to 1:00 PM**  | 60 min | Lunch  | 
| **1:00 PM to 1:10 PM**   | 10 min | Warm-up survey  | 
| **1:10 PM to 1:30 PM**   | 20 min | Understanding `RepeatModeler2` and `RepeatMasker` output  | 
| **1:30 PM to 2:30 PM**   | 60 min | The curation toolkit and getting to the edges (DEMO) | 
| **2:30 PM to 2:45 PM**   | 15 min | Break  | 
| **2:45 PM to 3:30 PM**   | 45 min | Guided practice on practice families | 
| **3:30 PM to 3:50 PM**   | 20 min | Your data: curation kickoff | 
| **3:50 PM to 4:00 PM**   | 10 min | Day 1 wrap-up | 

### Day 2: Quality control, classification, and your own data

At a glance we will be discussing: QC and visualization, classification and redundancy, `blastx` for autonomous TEs, automatic TE curation pipelines, curation studio.

| **Time**                 | **Duration** | **Details** | 
|--------------------------|:----------|:----------|
| **9:30 PM to 9:45 PM**   | 15 min | Recap and questions   |
| **9:45 PM to 10:40 PM**  | 55 min | Quality control and visualization   | 
| **10:40 AM to 10:55 AM** | 15 min | Break   |
| **10:55 AM to 12:00 M**  | 65 min | Classification and reducing redundancy   | 
| **12:00 PM to 1:00 PM**  | 60 min | Lunch   |
| **1:00 PM to 1:10 PM**   | 10 min | Warm-up poll   | 
| **1:10 PM to 1:30 PM**   | 20 min | Annotating autonomous TEs with NCBI blastx | 
| **1:30 PM to 2:00 PM**   | 30 min | Automatic TE curation pipelines   | 
| **2:00 PM to 2:50 PM**   | 45 min | Curation studio, part 1   | 
| **2:50 PM to 3:05 PM**   | 15 min | Break   |
| **3:05 PM to 3:35 PM**   | 30 min | Curation studio, part 2   | 
| **3:35 PM to 4:00 PM**   | 25 min | Wrap-up   | 

## Funding

This workshop is funded by Australia National University's Centre for Biodiversity Analysis (CBA) grant for visiting scientists. 

## Organizers

- University of Connecticut: 
  - Rachel O'Neill (rachel(dot)oneill(at)uconn(dot)edu) *Director of Institute for Systems Genomics, Professor Genetics and Genomics and the Dept. of Molecular and Cell Biology*
  - Jessica M. Storer. *Associate Research Scientist* (jessica(dot)storer(at)uconn(dot)edu)
    - Institute for Systems Genomics. University of Connecticut, Storrs, CT, USA.
  - Merly Escalona/ *Research Associate* (merly(dot)escalona(at)uconn(dot)com)
    - Institute for Systems Genomics. University of Connecticut, Storrs, CT, USA.
  - Magda Kmiecik. *Graduate Student* (magda(dot)kmiecik(at)uconn(dot)edu)
    - Institute for Systems Genomics. University of Connecticut, Storrs, CT, USA.
- The Australian National University
  - Claire Stephens. *Centre Coordinator* ()
    - Centre for Biodiversity Analysis. Research School of Biology, Division of Ecology & Evolution. ANU College of Science and Medicine. The Australian National University Canberra ACT 2600 Australia.
  - Peter Minogue. *Research Information Technology and Computational Specialist* ()
    - Research School of Biology. ANU College of Science and Medicine. The Australian National University. Canberra ACT 2600 Australia.

 
