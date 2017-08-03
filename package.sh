#!/bin/bash

mkdir -p cloudcontrol
cp init.lua depends.txt README.md LICENSE cloudcontrol/
zip -r cloudcontrol.zip cloudcontrol/
rm -r cloudcontrol
