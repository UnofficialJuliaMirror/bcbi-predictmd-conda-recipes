set -o verbose
set -o errexit

#wget --output-document=ImageMagick.tar.gz https://www.imagemagick.org/download/ImageMagick-6.9.9-47.tar.gz
cp $RECIPE_DIR/downloads/ImageMagick-6.9.9-47.tar.gz .
mv ImageMagick-6.9.9-47.tar.gz ImageMagick.tar.gz
tar -vzxf ImageMagick.tar.gz
rm -rf ImageMagick.tar.gz
mv ImageMagick-* ImageMagick
cd ImageMagick
./configure --prefix=$PREFIX LDFLAGS="-luuid"
make -j8
make -j8 install
cd ..
rm -rf ImageMagick
