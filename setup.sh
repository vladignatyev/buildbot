#!/bin/bash

cd ../frontend/
python setup.py sdist

virtualenv env
env/bin/pip install -r requirements.txt
cd ../backend/
env/bin/pip install -U ../frontend/dist/mbscoresystem-0.1.tar.gz
rm -rf ../frontend/dist/
rm -rf ../frontend/mbscoresystem.egg-info/


env/bin/buildbot create-master master



#Copy scripts to buildbot master dir
cp scripts/master.py master/master.cfg

env/bin/buildbot start master
env/bin/buildslave create-slave slave localhost:9989 example-slave pass
env/bin/buildslave start slave

