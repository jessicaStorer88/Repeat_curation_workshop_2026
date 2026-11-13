## **TE Curation Workshop: Container Setup**

We use the Dfam TETools container (`RepeatMasker`, `RepeatModeler2`, `FamDB`, `RMBlast`, UCSC tools). Do these steps before the workshop. The image is a public download of about 1.2 GB, so allow a few GB of free disk space. Image name: **dfam/tetools:2.01**

## Mac laptop

1. Install [Homebrew](https://brew.sh/) (`./brew.sh`), then: `brew install colima docker`

2. Start the Docker engine (Apple Silicon Macs, M1 to M4, use the second line):


```
 colima start --cpu 4 --memory 8
 colima start --vm-type vz --vz-rosetta --cpu 4 --memory 8
```

3. Go to your data folder, then start the container:

```
docker run -it --rm --platform linux/amd64 -v "$PWD":/work -w /work dfam/tetools:2.01
```

_After a restart, run colima start again before step 3. Run colima stop when you are done._

## Linux laptop

1. Option A, Docker: install [Docker Engine](docs.docker.com/engine/install), then from your data folder:

```
docker run -it --rm --user "$(id -u):$(id -g)" -v "$PWD":/work -w /work dfam/tetools:2.01
```

2. Option B, no Docker: install Apptainer (apptainer.org), then:

```
apptainer pull dfam-tetools.sif docker://dfam/tetools:2.01
apptainer shell --cleanenv -B "$PWD":/work --pwd /work dfam-tetools.sif
```

## Cluster (Linux/Unix, no root needed)

1. Find the tool: `module avail singularity apptainer`, then `module load singularity` (or apptainer). If neither exists, ask your admins.
<b>NOTE</b>: If you are using the mantis/UCONN cluster, this step is unnecessary.

2. Keep the cache out of your home directory (use `APPTAINER_CACHEDIR` if your cluster has Apptainer), then pull the image:

```
export SINGULARITY_CACHEDIR=/scratch/$USER/singularity_cache
singularity pull dfam-tetools.sif docker://dfam/tetools:2.01
```

3. If the pull fails with a mksquashfs error, build a folder instead:

```
singularity build --sandbox /scratch/$USER/dfam-tetools docker://dfam/tetools:2.01
```

4. Start it (use the folder path in place of the `.sif` if you built a sandbox):

```
singularity shell --cleanenv -B "$PWD":/work --pwd /work dfam-tetools.sif
```

**Check that it works (all systems, inside the container)**

```
 RepeatMasker -v ; RepeatModeler -version ; which faToTwoBit twoBitInfo
```

**Bring:** your genome `FASTA` and your pre-run `RepeatModeler2` and `RepeatMasker` results in one folder. Start the container from that folder; it appears as `/work` inside. Save everything under `/work`, or it disappears when you exit.

**Stuck?** `Cannot connect to the Docker daemon` or `docker.sock` means the engine is not running (Mac: run `colima start`). For file transfer, `pip install --user magic-wormhole` works on any system.
