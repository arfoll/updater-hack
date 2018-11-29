
cd base/
g++ -fPIC -shared file.cpp logging.cpp parsenetaddress.cpp quick_exit.cpp stringprintf.cpp strings.cpp test_utils.cpp -Iinclude/ -o ../android-base.so
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
#g++ -shared -fPIC *.cpp -Iinclude/ -I../ -I../otautil/include -I../base/include ../android-base.so ../otautil.so -o ../edify.so
flex lexer.ll
yacc -d parser.yy
cp y.tab.h parser.h
g++ -shared -fPIC expr.cpp  lex.yy.c y.tab.c -Iinclude -I../base/include -I../otautil/include ../android-base.so ../otautil.so
cd ../

# miniutils
cd libutils/
g++ -shared -fPIC FileMap.cpp -Iinclude -o ../filemap.so
cd ../

cd libziparchive/
#g++ -shared -fPIC -o ../ziparchive.so *.cpp -Iinclude/ -I../base/include/ ../android-base.so
g++ -fpermissive -std=c++17  -shared -fPIC -o ../ziparchive.so zip_archive.cc zip_archive_stream_entry.cc zip_writer.cc -Iinclude/ -I../base/include/ ../android-base.so -I../libutils/include ../filemap.so
cd ../

cd libcutils/
g++ -fPIC -shared *.cpp -o ../libcutils.so -I../base/ -Iinclude
cd ../

cd ext4_utils/
g++ -fPIC -shared *.cpp -o ../ext4_utils.so -I../base/include/ -Iinclude/ -I../libcutils/include/
cd ../

cd fec/
gcc -fPIC -shared -o ../fecrs.so encode_rs_char.c decode_rs_char.c init_rs_char.c
cd ../

cd applypatch
g++ -shared -fPIC -o ../applypatch.so -fpermissive -std=c++17 applypatch.cpp freecache.cpp imgpatch.cpp bspatch.cpp -I../base/include -I../bsdiff/include -Iinclude -I../edify/include -I../otautil/include ../bsdiff.so ../android-base.so ../otautil.so ../edify.so -lbz2 -lssl -lcrypto ../libbrotlidec.so -lz
cd ../

cd updater/
g++ blockimg.cpp commands.cpp install.cpp updater.cpp -Iinclude -I../base/include -I../libziparchive/include -I../otautil/include -I../applypatch/include -I../brotli/c/include -I../ext4_utils/include/ -I../libfec/include -I../edify/include
cd ../

 g++ -Wl,--as-needed -std=c++17 updater.cpp blockimg.cpp commands.cpp install.cpp -Iinclude -I../base/include -I../libziparchive/include -I../otautil/include -I../applypatch/include -I../brotli/c/include -I../ext4_utils/include/ -I../edify/include -o updater -lbz2 -lzip -lssl -lcrypto -lpthread ../*.so
