cmake_minimum_required(VERSION 2.8.9)
project (flute-rl)

#DSFMT_MEXP=19937: Mersenne exponent and the period of RNG will be 2^SFMT_MEXP
#HAVE_SSE2: enables SSE2 support for the dSFMT RNG, 
#           this variable is used in the headers of dSFMT,
#           so we should pass it to the compilation of all files in the project
set(CMAKE_C_FLAGS "-Wall -pedantic -DDSFMT_MEXP=19937")
set(CMAKE_C_RELEASE_FLAGS "-DHAVE_SSE2 -msse2 -O3")
set(CMAKE_CXX_FLAGS "-Wall -pedantic -DDSFMT_MEXP=19937")
set(CMAKE_CXX_RELEASE_FLAGS "-DHAVE_SSE2 -msse2 -O3")

#configuration for the dSFMT random number generator
# Note: some of these properties are gcc specific
set_source_files_properties(src/sfmt/dSFMT.c PROPERTIES COMPILE_FLAGS "-std=c99 --param max-inline-insns-single=1800 -fno-strict-aliasing -Wmissing-prototypes -DNDEBUG")

add_executable(flute src/flute.cpp src/epimodel.cpp src/params.cpp src/epimodelparameters.cpp src/sfmt/dSFMT.c src/bnldev.c)
