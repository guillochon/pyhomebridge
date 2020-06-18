#!/usr/bin/env bash

set -e

# create venv-build
virtualenv -p python3 venv-build
source venv-build/bin/activate
pip3 install setuptools==47.3.1
pip3 install twine==3.1.1

# create packages
python3 setup.py sdist bdist_wheel
twine check dist/*

if [ "$1" == "--real" ]; then
    # upload to pypi
    twine upload --repository-url https://pypi.org/legacy/ dist/* --verbose
else
    # upload to test.pypi
    twine upload --repository-url https://test.pypi.org/legacy/ dist/* --verbose
fi