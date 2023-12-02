#!/bin/bash

DEPENDENCIES="neovim
neovim-remote
fd
ripgrep
make
cmake
gcc"
if [[ "$OSTYPE" == "darwin"* ]]; then

	if type brew &>/dev/null; then
		for DEP in $DEPENDENCIES; do
			brew install "$DEP"
		done
	else
		echo "Brew not found, you can install it from https://brew.sh/"
		exit
	fi
fi
