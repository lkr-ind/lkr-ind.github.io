#!/bin/bash

source /local/py3-mkdocs/bin/activate

mkdocs build

rsync -q -ar ./site/ login630.lamp.le.ac.uk:/local/www/htdocs/
