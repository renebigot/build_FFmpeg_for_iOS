FFmpeg - build script for iOS
=============================

This script will build FFmpeg for iOS 6.1 with iOS 7.0 SDK

### Build instructions:

First, you need to download this script. Simply clone this repo :

	git clone https://github.com/renebigot/build_FFmpeg_for_iOS.git

Download [FFmpeg](http://ffmpeg.org/index.html) sources.
	
	cd build_FFmpeg_for_iOS
	git clone https://github.com/FFmpeg/FFmpeg.git

Then, build FFmpeg with this script. FFmpeg must be a subdir named FFmpeg inside your build_FFmpeg_for_iOS directory.

	sh build_FFmpeg_for_iOS.sh

Have a coffee… get your newly generated libraries in 

	./FFmpeg/universal/lib/

and headers files 

	./FFmpeg/universal/include/


### Requirements

1. Xcode command line utilities. [Help](http://stackoverflow.com/questions/9329243/xcode-4-4-command-line-tools)
2. GNU assembler preprocessor. [Help](http://stackoverflow.com/questions/5056600/how-to-install-gas-preprocessor)


### Feedback

Tweet me — [@renebigot](https://twitter.com/renebigot).