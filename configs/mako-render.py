import sys
from mako.template import Template

template_fn = sys.argv[1]

args = {}
for arg in sys.argv[2:]:
    if arg.startswith("--") and "=" in arg:
        (name, value) = tuple(arg[2:].split("="))
        args[name] = value
    else:
        print 'Error: invalid argument \"%s\"' % arg 

mytemplate = Template(filename=template_fn, strict_undefined=True, \
                        default_filters=['decode.utf8'], \
                        input_encoding='utf-8', \
                        output_encoding='utf-8')
print(mytemplate.render(**args))
