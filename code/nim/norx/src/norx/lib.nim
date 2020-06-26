when defined(windows):
  const
    libORX* = "liborxd.dll"
elif defined(macosx):
  const
    libORX* = "liborxd.dylib"
else:
  const
    libORX* = "liborxd.so"