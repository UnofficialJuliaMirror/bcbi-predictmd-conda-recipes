# conda-recipes

This repository contains [Conda](https://conda.io/docs/) recipes for building various binary dependencies.

## Usage

**Step 1:** Update ```conda``` and ```conda-build```:
```bash
conda update -y conda
conda update -y conda-build
```

**Step 2:** Download the recipes:
```bash
wget --output-document=conda-recipes-master.zip https://github.com/DilumAluthge/conda-recipes/archive/master.zip
unzip conda-recipes-master.zip
rm conda-recipes-master.zip
cd conda-recipes-master
```
**Step 3:** Build the recipes that you want to build. You can build multiple recipes at once. The syntax is:
```bash
conda build RECIPE-1 [RECIPE-2 RECIPE-3 ...]
```

(You should run this command from inside the ```conda-recipes-master``` directory.)

For example, to build ```predictmd-imagemagick```, you would run:
```bash
conda build predictmd-imagemagick
```

To build ```predictmd-imagemagick``` and ```predictmd-pdf2svg```, you would run:
```bash
conda build predictmd-imagemagick predictmd-pdf2svg
```

**Step 4:** Once you have built all of the recipes that you want, you can install them. The syntax is:
```
conda install -y --use-local RECIPE-1 [RECIPE-2 RECIPE-3 ...]
```

For example, to install ```predictmd-imagemagick```, you would run:
```bash
conda install -y --use-local predictmd-imagemagick
```

To install ```predictmd-imagemagick``` and ```predictmd-pdf2svg```, you would run:
```bash
conda install -y --use-local predictmd-imagemagick predictmd-pdf2svg
```

**Step 5**: Now that you have installed the recipes, run some clean-up commands to recover disk space:
```bash
cd ..
rm -rf conda-recipes-master
conda clean -y --all
```
