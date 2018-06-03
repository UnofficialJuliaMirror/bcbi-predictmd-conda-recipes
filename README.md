# predictmd-conda-recipes

<table>
    <thead>
        <tr>
            <th>branch</th>
            <th>travis</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>master</td>
            <td><a href="https://travis-ci.com/DilumAluthge/predictmd-conda-recipes/branches"><img alt="Travis build status (master)" title="Travis build status (master)" src="https://travis-ci.com/DilumAluthge/predictmd-conda-recipes.svg?branch=master"></a></td>
        </tr>
    </tbody>
</table>



<table>
    <thead>
        <tr>
            <th>dependency</th>
            <th>recipe name</th>
            <th>version</th>
            <th>platforms</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>ImageMagick</td>
            <td>predictmd-imagemagick</td>
            <td><a href="https://anaconda.org/dilumaluthge/predictmd-imagemagick"><img src="https://anaconda.org/dilumaluthge/predictmd-imagemagick/badges/version.svg"></a></td>
            <td><a href="https://anaconda.org/dilumaluthge/predictmd-imagemagick"><img src="https://anaconda.org/dilumaluthge/predictmd-imagemagick/badges/platforms.svg"></a></td>
        </tr>
        <tr>
            <td>pdf2svg</td>
            <td>predictmd-pdf2svg</td>
            <td><a href="https://anaconda.org/dilumaluthge/predictmd-pdf2svg"><img src="https://anaconda.org/dilumaluthge/predictmd-pdf2svg/badges/version.svg"></a></td>
            <td><a href="https://anaconda.org/dilumaluthge/predictmd-pdf2svg"><img src="https://anaconda.org/dilumaluthge/predictmd-pdf2svg/badges/platforms.svg"></a></td>
        </tr>
        <tr>
            <td>TeX Live</td>
            <td>predictmd-texlive</td>
            <td><a href="https://anaconda.org/dilumaluthge/predictmd-texlive"><img src="https://anaconda.org/dilumaluthge/predictmd-texlive/badges/version.svg"></a></td>
            <td><a href="https://anaconda.org/dilumaluthge/predictmd-texlive"><img src="https://anaconda.org/dilumaluthge/predictmd-texlive/badges/platforms.svg"></a></td>
        </tr>
    </tbody>
</table>

This repository contains Conda recipes for building the binary dependencies of [PredictMD](https://www.predictmd.net).

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

**Step 4 (optional, but recommended):** You can tell conda-build to automatically upload successful builds to the Anaconda.org cloud by doing the following:

* First, make sure that you have created a free Anaconda.org account.

* Second, run the following command and enter your Anaconda.org username and password when prompted:
```bash
anaconda login
```

* Third, run the following command, which tells conda-build to automatically upload after a successful build:
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

**Step 7:** Download and install Julia. You want the **64-bit version** of the **Generic Linux Binaries for x86**, available here: [https://julialang.org/downloads/](https://julialang.org/downloads/)
```bash
cd ~
wget --output-document=julia.tar.gz https://julialang-s3.julialang.org/bin/linux/x64/0.6/julia-0.6.3-linux-x86_64.tar.gz
tar xzf julia.tar.gz
rm -rf julia.tar.gz
mv julia-* julia
```

**Step 8:** Install PredictMD.
```bash
cd ~
export CONDA_PREFIX=`conda info --base || conda info --root`
export MAGICK_HOME=$CONDA_PREFIX/lib
~/julia/bin/julia -e 'Pkg.init()'
~/julia/bin/julia -e 'Pkg.update()'
~/julia/bin/julia -e 'Pkg.clone("https://github.com/bcbi/PredictMD.jl")'
~/julia/bin/julia -e 'Pkg.update()'
```

**Step 9:** Make sure that you can `import` PredictMD without any errors.
```bash
~/julia/bin/julia -e 'import PredictMD'
```

**Step 10:** Run the PredictMD test suite.
```bash
~/julia/bin/julia -e 'Pkg.test("PredictMD")'
```

If you see the message "INFO: PredictMD tests passed", then everything is working correctly!

**Step 11:** You can exit the Docker container at any time by typing `exit` and pressing enter.

**Step 12:** To return to the container at a later time, run the following command in bash:
```bash
docker start -a -i BUILD_PREDICTMD_DEPS_CONDA
```

**Step 13:** When you are ready to delete the container, first make sure that you have exited the container. Then, run the following command in bash:
```bash
docker container rm BUILD_PREDICTMD_DEPS_CONDA
```
