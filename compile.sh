
cd base/
g++ -shared -fPIC -o ../android-base.so *.cpp -Iinclude/
cd ../

mkdir -p brotli/build
cd brotli/build/
cmake ..
make
cp libbrotlidec.so ../../
cd ../../

# wow these include files are dumb here...
cd bsdiff/
g++ -shared -fPIC -o ../bsdiff.so -I../ -Iinclude/ brotli_decompressor.cc bspatch.cc bz2_decompressor.cc buffer_file.cc decompressor_interface.cc extents.cc extents_file.cc file.cc logging.cc memory_file.cc patch_reader.cc sink_file.cc utils.cc -L../brotli/build/libbrotlidec.so -I../brotli/c/include/
cd ../

cd otautil/
g++ -shared -fPIC -std=c++17 *.cpp -Iinclude/ -I../base/include ../android-base.so -o ../otautil.so
cd ../

cd edify/
g++ -shared -fPIC *.cpp -Iinclude/ -I../ -I../otautil/include -I../base/include ../android-base.so ../otautil.so -o ../edify.so
cd ../

cd libziparchive/
g++ -shared -fPIC -o ../ziparchive.so *.cpp -Iinclude/ -I../base/include/ ../android-base.so
cd ../

cd cutils/
g++ -fPIC -shared *.cpp -o ../libcutils.so -I../base/ -Iinclude
cd ../

cd ext4_utils/
g++ -fPIC -shared *.cpp -o ../ext4_utils.so -I../base/include/ -Iinclude/ -I../libcutils/include/
cd ../

cd fec/
gcc -fPIC -shared -o ../fecrs.so encode_rs_char.c decode_rs_char.c init_rs_char.c
cd ../

cd updater/
g++ blockimg.cpp commands.cpp install.cpp updater.cpp -Iinclude -I../base/include -I../libziparchive/include -I../otautil/include -I../applypatch/include -I../brotli/c/include -I../ext4_utils/include/ -I../libfec/include -I../edify/include
cd ../
