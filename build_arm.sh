cd luajit-2.1/src

# Android/ARM, armeabi-v7a (ARMv7 VFP), Android 4.0+ (ICS)
NDK=/Users/pjg/Android/android-ndk-r10e
NDKABI=19
NDKVER=$NDK/toolchains/arm-linux-androideabi-4.9
NDKP=$NDKVER/prebuilt/darwin-x86_64/bin/arm-linux-androideabi-
NDKF="--sysroot $NDK/platforms/android-$NDKABI/arch-arm" 
NDKARCH="-march=armv7-a -mfloat-abi=softfp -Wl,--fix-cortex-a8"

make clean
make HOST_CC="gcc -m32" MACOSX_DEPLOYMENT_TARGET=10.14.3 CROSS=$NDKP TARGET_SYS=Linux TARGET_FLAGS="$NDKF $NDKARCH"
# make CC="gcc -m32" MACOSX_DEPLOYMENT_TARGET=10.14.3
cp ./libluajit.a ../../android/jni/libluajit.a
make clean

cd ../../android
ndk-build clean APP_ABI="armeabi-v7a,x86"
ndk-build APP_ABI="armeabi-v7a"
mkdir -p ../Plugins/Android/libs/armeabi-v7a
cp libs/armeabi-v7a/libtolua.so ../Plugins/Android/libs/armeabi-v7a
ndk-build clean APP_ABI="armeabi-v7a,x86"

cd ../luajit-2.1/src
NDKABI=21
NDKTRIPLE=aarch64-linux-android
NDKVER=$NDK/toolchains/aarch64-linux-android-4.9
NDKP=$NDKVER/prebuilt/darwin-x86_64/bin/aarch64-linux-android-
NDKF="--sysroot $NDK/platforms/android-$NDKABI/arch-arm64" 
#NDKARCH="-march=armv8-a"
NDKARCH="-DLJ_ABI_SOFTFP=0 -DLJ_ARCH_HASFPU=1 -DLUAJIT_ENABLE_GC64=1"

make clean
# make XCFLAGS=-DLUAJIT_ENABLE_GC64 MACOSX_DEPLOYMENT_TARGET=10.14.3
#make HOST_CC="gcc" MACOSX_DEPLOYMENT_TARGET=10.14.3 CROSS=$NDKP TARGET_SYS=Linux TARGET_FLAGS="$NDKF $NDKARCH"
make HOST_CC="gcc -m64" CROSS=$NDKP TARGET_SYS=Linux TARGET_FLAGS="$NDKF $NDKARCH"
cp ./libluajit.a ../../android/jni/libluajit.a
make clean

cd ../../android
ndk-build clean APP_ABI="arm64-v8a"
ndk-build APP_ABI="arm64-v8a"
mkdir -p ../Plugins/Android/libs/arm64-v8a
cp libs/arm64-v8a/libtolua.so ../Plugins/Android/libs/arm64-v8a
ndk-build clean APP_ABI="arm64-v8a"
