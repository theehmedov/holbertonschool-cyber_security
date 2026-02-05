#!/bin/bash
find "$1" -mtime 0 -perm /6000 -exec ls -l {} \;
