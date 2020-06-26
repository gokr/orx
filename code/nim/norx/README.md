# Norx - a Nim Wrapper of ORX
This directory contains a Nim wrapper of the ORX library. The wrapper consists of one Nim module per ORX C header, 77 of them.

The only things you need to compile a Nim ORX game is this Nimble module and the ORX dynamic library (`liborx[p|d].so|dll`).

However, for debugging etc it's more practical to also have the full ORX clone with ORX C sources etc.

# Install
Just run `nimble install` in this directory. Also **make sure you have `liborx[d|p].so` in a proper place, like /usr/lib/** (working dir doesn't work for me).

# How it was made
This wrapper was created through the following steps:

1. Run `convert.nim` in this directory that uses `common.c2nim`.
2. Modifications to the original header files using `ifdefs`.
3. Eventually "abandon all hope" and start editing the generated Nim files manually.

Unfortunately this means that at this moment (due to step 3 above), updates to ORX header files does not mean we can just regenerate this wrapper automagically.

See `samples` directory for some sample code.

# How to maintain
We track any changes to the `include` directory, for example if `orxObject.h` changes:

1. `cd headers`
2. `cp ../../../include/object/orxObject.h object/orxObject.h`
3. Using your IDE, reapply modifications that was overwritten :) - this should be handled better of course.
4. `c2nim common.c2nim object/orxObject.h` to reproduce `orxObject.nim`
5. Merge parts into `obj.nim` that should be there using `meld object/orxObject.nim ../src/norx/obj.nim`