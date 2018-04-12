#estimate the "real" distribution of all arms
import random
import sys
import os 
import getopt
import itertools

from mako.template import Template

args = sys.argv[1:]

def get_arg(name):
    for arg in args:
        if arg.startswith("--" + name):
            (name, value) = tuple(arg[2:].split("="))
            return value 
    raise ValueError("Could not find argument named " + name)

path = get_arg("path")
template_fn = get_arg("template_fn") 
r0 = get_arg("r0")
days = get_arg("days")
datafile = get_arg("datafile")
doses = get_arg("doses")

samples = 1000

random.seed(123)
seeds = random.sample(range(1, 100000), samples)
        
arms = list(itertools.product('01', repeat=5))
for arm in arms:
    for seed in seeds:
        template_vars = {
                'label': str(seed) + "_" + "".join(arm),
                'seed': seed,
                'vaccine_priorities': ",".join(arm),
                'R0': r0,
                'run_length': days,
                'data_file': datafile,
                'doses': doses
                }
        flute_dir = path + "/" + "".join(arm) + "/" + str(seed) + "/"
        os.makedirs(flute_dir)
        t = Template(filename=template_fn, strict_undefined=True, \
                     default_filters=['decode.utf8'], \
                     input_encoding='utf-8', \
                     output_encoding='utf-8')
        r = t.render(**template_vars)
        f = open(flute_dir + 'flute.config', 'w')
        f.write(r)
