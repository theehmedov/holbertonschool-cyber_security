#!/bin/bash
if [ -z "$1" ]; then
    exit 1
fi
encoded_string=${1#"{xor}"}
python3 -c "import base64; print(''.join([chr(b ^ 95) for b in base64.b64decode('$encoded_string')]))"
