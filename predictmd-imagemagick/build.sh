set -o verbose
set -o errexit

#wget --output-document=uuid.tar.gz https://www.mirrorservice.org/sites/ftp.ossp.org/pkg/lib/uuid/uuid-1.0.4.tar.gz
cp $RECIPE_DIR/downloads/uuid-1.0.4.tar.gz .
mv uuid-1.0.4.tar.gz uuid.tar.gz
tar -vzxf uuid.tar.gz
rm -rf uuid.tar.gz
mv uuid-* uuid
cd uuid
export PREFIXLIB=$PREFIX/lib
./configure --prefix=$PREFIX
make -j8
make install
cd ..
rm -rf uuid

#wget --output-document=ImageMagick.tar.gz https://www.imagemagick.org/download/ImageMagick-6.9.9-47.tar.gz
cp $RECIPE_DIR/downloads/ImageMagick-6.9.9-47.tar.gz .
mv ImageMagick-6.9.9-47.tar.gz ImageMagick.tar.gz
tar -vzxf ImageMagick.tar.gz
rm -rf ImageMagick.tar.gz
mv ImageMagick-* ImageMagick
cd ImageMagick
./configure LDFLAGS="-L$PREFIXLIB -Wl,-rpath=$PREFIXLIB" --prefix=$PREFIX
make -j8
make install
cd ..
rm -rf ImageMagick
