#!/bin/bash

DEPENDENCIES="neovim
              fd
              ripgrep
              make
              cmake
              gcc"
if [[ "$OSTYPE" == "darwin"* ]]; then
    if ! command -v brew &> /dev/null
        then
            echo "Brew could not be found"
            echo "None of the dependencies are installed"
            exit
        else
            for DEP in $DEPENDENCIES
            do
            brew install "$DEP"
            done
        fi
# elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
#         # ...
# elif [[ "$OSTYPE" == "cygwin" ]]; then
#         # POSIX compatibility layer and Linux environment emulation for Windows
# elif [[ "$OSTYPE" == "msys" ]]; then
#         # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
# elif [[ "$OSTYPE" == "win32" ]]; then
#         # I'm not sure this can happen.
# elif [[ "$OSTYPE" == "freebsd"* ]]; then
#         # ...
# else
#         # Unknown.
fi

