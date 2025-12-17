#!/bin/bash
DATA="$2  $1"
echo "$DATA" | sha256sum --check
