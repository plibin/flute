import sys
import re 

def parse_attack_rate(fn):
    ar = "Total symptomatic attack rate:"
    for line in open(fn, 'r'):
        if re.search(ar, line):
            return float(line.split(':')[1])
    return None

print parse_attack_rate(sys.argv[1])
