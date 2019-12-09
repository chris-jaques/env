#!/bin/sh
#
# Python
#
#

# Run Unit Tests { ...testFiles? }
pytest(){ 
    python -m unittest ${@:1}
}

# Run Integration Tests { ...testFiles? }
pyinttest(){ 
    python -m unittest discover -p *int_test.py ${@:1}
}

# Run End to End Tests { ...testFiles? }
pye2etest(){ 
    python -m unittest discover --failfast -p *e2e_test.py ${@:1}
}
