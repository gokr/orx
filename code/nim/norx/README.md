# Norx - a Nim Wrapper of ORX

This directory contains a Nim wrapper of the ORX library. The wrapper consists of one Nim module per ORX C header, 77 of them.

The only things you need to compile a Nim ORX game are these Nim files and the ORX dynamic library (`liborx.so|dll`).

However, for debugging etc it's more practical to also have the full ORX clone with ORX C sources etc.

# How it was made

This wrapper was created through the following steps:

1. Run `convert.nim` in this directory that uses `common.c2nim`.
2. Modifications to the original header files using `ifdefs`.
3. Eventually "abandon all hope" and start editing the generated Nim files manually.

Unfortunately this means that at this moment (due to step 3 above), updates to ORX header files does not mean we can just regenerate this wrapper automagically.

See `samples` directory for some sample code.