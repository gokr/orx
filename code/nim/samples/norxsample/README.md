# A trivial sample using Norx
This is just a trivial port of the original ORX sample with a spinning logo.

# Build and install ORX
First install ORX dlls. At the moment best is to build them using this clone of ORX since it is in sync with the wrapper.

This works on my Ubuntu 64 bit (after installing tools needed):

1. Run `setup.sh` in top level first.
2. Build with `cd code/build/linux/gmake && make config=release64` (build also debug64 and profile64 to get those extra libraries)
3. Copy libraries to a library path with for example `cp -a ../../../bin/liborx*.so /usr/lib/` 

For other platforms etc, follow [official ORX instructions](https://wiki.orx-project.org/en/guides/beginners/downloading_orx).

# Install Nim
Easiest to use Choosenim `curl https://nim-lang.org/choosenim/init.sh -sSf | sh` or see [Official download](https://nim-lang.org/install.html).

# Install Norx
Install Norx by running `nimble install` in `../norx`.

# Install norxsample
Then run `nimble install` in this directory. After that you can run `norxsample`. ESC quits. Pressing the key below ESC (may be different depending on your keyboard, on mine it's "§" but evidently "`" on others I guess) opens the ORX console.

# Compiling
A Nim debug build will use `liborxd.so`, a release build will use `liborx.so` and if you build with `nim c -d:profile` it will use `liborxp.so`.