#!/bin/bash
find "$1" -type f -mtime 0 -perm /6000 -exec ls -l {} \;
