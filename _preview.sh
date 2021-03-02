#!/bin/sh

#cd _liquidluck
#liquidluck server
#cd ..

cd doc 
python -m http.server --bind 127.0.0.1 8000
cd ..
