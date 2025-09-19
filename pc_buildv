#!/bin/bash

echo "Pencil version info:"
echo -e "\tbranch: $(git -C $PENCIL_HOME branch --show-current)"
echo -e "\tcommit: $(git -C $PENCIL_HOME rev-parse HEAD)"
echo "-------"

pc_build "$@"
