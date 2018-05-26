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

**Step 5**: Finally, run some clean-up commands to recover disk space:
```bash
cd ..
rm -rf predictmd-conda-recipes-master
conda build purge
conda build purge-all
conda clean -y --all
```

## Docker example
