#!/bin/bash

bash .scripts/participation.sh > .scripts/Participation.md 2>/dev/null
sed -i "" 's/^M//g' .scripts/Participation.md 
