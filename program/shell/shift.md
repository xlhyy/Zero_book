#!/bin/bash

<<COMMENT
⇒  ./07-shift移动变量.sh a b c d

The original parameters: a b c d
Here's the new first parameter: c
COMMENT

echo
echo "The original parameters: $*"
shift 2
echo "Here's the new first parameter: $1"

