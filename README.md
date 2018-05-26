# predictmd-conda-recipes

This repository contains Conda recipes for building the binary dependencies of [PredictMD.jl](https://github.com/bcbi/PredictMD.jl).

## Usage

**Step 1:** Update ```conda``` and ```conda-build```:
```bash
conda update -y conda
conda update -y conda-build
```

**Step 2:** Download the recipes:
```bash
cd ~
wget --output-document=predictmd-conda-recipes-master.zip https://github.com/DilumAluthge/predictmd-conda-recipes/archive/master.zip
unzip predictmd-conda-recipes-master.zip
rm predictmd-conda-recipes-master.zip
cd predictmd-conda-recipes-master
```
**Step 3:** Build all of the recipes:
```bash
conda build predictmd-imagemagick predictmd-pdf2svg predictmd-texlive
```

**Step 4:** Once you have built the recipes, install them:
```
conda install -y --use-local predictmd-imagemagick predictmd-pdf2svg predictmd-texlive
```

**Step 5:** Finally, run some clean-up commands to recover disk space:
```bash
cd ..
rm -rf predictmd-conda-recipes-master
conda build purge
conda build purge-all
conda clean -y --all
```

## Docker example

**Step 1:** Make sure that the Docker daemon is running.

**Step 2:** Open bash and run the following command.
```bash
docker run --name build_predictmd_dependencies_conda -it mhowison/conda-build:v2
```

**Step 3:** Now you are inside the Docker container. Run the following commands inside the container:
```bash
sudo ln -s /lib64/libuuid.so.1 /lib64/libuuid.so

conda update -y conda
conda update -y conda-build

cd ~
wget --output-document=predictmd-conda-recipes-master.zip https://github.com/DilumAluthge/predictmd-conda-recipes/archive/master.zip
unzip predictmd-conda-recipes-master.zip
rm predictmd-conda-recipes-master.zip
cd predictmd-conda-recipes-master

conda build predictmd-imagemagick predictmd-pdf2svg predictmd-texlive

conda install -y --use-local predictmd-imagemagick predictmd-pdf2svg predictmd-texlive
```

**Step 4:** To return to the container at a later time, run the following command in bash:
```bash
docker start -a -i build_predictmd_dependencies_conda
```

**Step 5:** When you are ready to delete the container, run the following command in bash:
```bash
docker container rm build_predictmd_dependencies_conda
```
