# flute

To build FluTE, use CMake: 
```sh
mkdir build
cd build
cmake ../
make
```

Config files to run FluTE simulations can be found in the configs directory.
Scripts to start the FluTE simulator and interpret its output can be found in the scripts directory.

The original FluTE source code is hosted at: https://github.com/dlchao/FluTE 

An example to run FluTE (in the context of pre-vaccination):
```sh
export flute_dir=/Users/plibin/tmp/ecml/flute/
${flute_dir}/scripts/bandits/pre-vaccination.sh /tmp/ ${flute_dir} ${flute_dir}/build/flute ${flute_dir}/configs/bandits/pre-vaccination.config.mako 123 2.0 180 one 25000 1,1,0,0,1
```
