export DEVELOPER_DIR="/Applications/Xcode.app/Contents/Developer/"

cd FFmpeg

#remove previous version
rm -Rf armv7
rm -Rf armv7s
rm -Rf i386
rm -Rf universal

###############################
#       build for armv7       #
###############################

mkdir armv7

./configure \
--prefix=armv7 \
--disable-ffmpeg \
--disable-ffplay \
--disable-ffprobe \
--disable-ffserver \
--enable-avresample \
--enable-cross-compile \
--sysroot="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS7.0.sdk" \
--target-os=darwin \
--cc="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang" \
--extra-cflags="-arch armv7 -mfpu=neon -miphoneos-version-min=6.1" \
--extra-ldflags="-arch armv7 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS7.0.sdk -miphoneos-version-min=6.1" \
--arch=arm \
--cpu=cortex-a9 \
--enable-pic \
--disable-bzlib

make clean && make && make install

###############################
#       build for armv7s      #
###############################

mkdir armv7s

./configure \
--prefix=armv7s \
--disable-ffmpeg \
--disable-ffplay \
--disable-ffprobe \
--disable-ffserver \
--enable-avresample \
--enable-cross-compile \
--sysroot="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS7.0.sdk" \
--target-os=darwin \
--cc="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang" \
--extra-cflags="-arch armv7s -mfpu=neon -miphoneos-version-min=6.1" \
--extra-ldflags="-arch armv7s -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS7.0.sdk -miphoneos-version-min=6.1" \
--arch=arm \
--cpu=cortex-a9 \
--enable-pic \
--disable-bzlib

make clean && make && make install

###############################
#       build for i386        #
###############################

mkdir i386

./configure \
--prefix=i386 \
--disable-ffmpeg \
--disable-ffplay \
--disable-ffprobe \
--disable-ffserver \
--enable-avresample \
--enable-cross-compile \
--sysroot="/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator7.0.sdk" \
--target-os=darwin \
--cc="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/clang" \
--extra-cflags="-arch i386 -miphoneos-version-min=6.1" \
--extra-ldflags="-arch i386 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator7.0.sdk -miphoneos-version-min=6.1" \
--arch=i386 \
--cpu=i386 \
--enable-pic \
--disable-asm \
--disable-bzlib

make clean && make && make install

###############################
#       build universal       #
###############################

mkdir -p universal/lib

cd armv7/lib
for file in *.a
do
	cd ../..
	xcrun -sdk iphoneos lipo -output universal/lib/$file  -create -arch armv7 armv7/lib/$file -arch armv7s armv7s/lib/$file -arch i386 i386/lib/$file
	echo "Universal $file created."
	cd -
done

cd ../..

#copy headers files
cp -Rf i386/include universal/include

#keep only universal libs
rm -Rf i386
rm -Rf armv7
rm -Rf armv7s