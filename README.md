# predictmd-conda-recipes

This repository contains Conda recipes for building the binary dependencies of [PredictMD.jl](https://github.com/bcbi/PredictMD.jl).

These recipes are only intended for use inside the `mhowison/conda-build:v2` Docker image, and therefore they may not work in other environments.

## Usage

**Step 1:** Make sure that the Docker daemon is running.

**Step 2:** Open bash and run the following command.
```bash
docker run --name BUILD_PREDICTMD_DEPS_CONDA -it mhowison/conda-build:v2
```

**Step 3:** Now you are inside the Docker container. Run the following commands inside the container:
```bash
conda update -y conda
conda update -y conda-build
conda install -y anaconda-client
cd ~
wget --output-document=predictmd-conda-recipes-master.zip https://github.com/DilumAluthge/predictmd-conda-recipes/archive/master.zip
unzip predictmd-conda-recipes-master.zip
rm predictmd-conda-recipes-master.zip
cd predictmd-conda-recipes-master
```

**Step 4 (optional, but recommended):** You can tell conda-build to automatically upload successful builds to the Anaconda.org cloud. I recommend this. First, make sure that you have created a free Anaconda.org account. Second, run the following command and enter your Anaconda.org username and password when prompted:
```bash
anaconda login
```

Third, run the following command, which tells conda-build to automatically upload after a successful build.
```bash
conda config --set anaconda_upload yes
```

**Step 5:** Now you are ready to build the packages. This step will take the longest. Run the following command to build all of the recipes:
```bash
conda build predictmd-imagemagick predictmd-pdf2svg predictmd-texlive
```

**Step 6:** After the packages have successfully built, make sure that they install without any errors:
```bash
conda install -y --use-local predictmd-imagemagick predictmd-pdf2svg predictmd-texlive
```

**Step 7:** You can exit the Docker container at any time by running:
```bash
exit
```

**Step 8:** To return to the container at a later time, run the following command in bash:
```bash
docker start -a -i BUILD_PREDICTMD_DEPS_CONDA
```

**Step 9:** When you are ready to delete the container, run the following command in bash:
```bash
docker container rm BUILD_PREDICTMD_DEPS_CONDA
```
