#!/usr/bin/env bash

EXECUTABLE="rexis"  # For reusability with other projects

if [ -z "$1" ]; then
    echo -e "\033[1;36m'R' for release (to just use it)\033[0m, 'b' for build, 'r' for run"
    echo "'h' for more commands"
    exit 1
fi

if [[ "$1" == *"h"* ]]; then
    echo -e "\033[1;36m'R' for release (to just use it)\033[0m, 'b' for build, 'r' for run"
    echo "'br' for build and run"
    echo "'h' for more commands"
    echo "'c' for clean"
    echo "'d' for debug"
    echo "'v' for valgrind"
    exit 0
fi

if [[ "$1" == *"c"* ]]; then
    rm -rf build
    echo "Cleaned"
    exit 0
fi

if [[ "$1" == *"d"* ]]; then
    mkdir -p build
    cd build || exit
    cmake -DCMAKE_BUILD_TYPE=Debug ..
    make -j$(nproc)
    echo "Built Debug"
    gdb ./$EXECUTABLE
    ../build.sh c
    exit 0
fi

if [[ "$1" == *"R"* ]]; then
    mkdir -p build
    cd build || exit
    cmake -DCMAKE_BUILD_TYPE=Release ..
    make -j$(nproc)
    echo "Built Release"
    exit 0
fi

if [[ "$1" == *"v"* ]]; then
    mkdir -p build
    cd build || exit
    cmake -DCMAKE_BUILD_TYPE=Debug ..
    make -j$(nproc)
    echo "Built Debug"
    valgrind --leak-check=full ./$EXECUTABLE
    ../build.sh c
    exit 0
fi

if [[ "$1" == *"b"* ]]; then
    mkdir -p build
    cd build || exit
    cmake ..
    make -j$(nproc)
    echo "Built"
    if [[ "$1" != *"r"* ]]; then    # A bit confiusing but basically just continues
        exit 0                      # down to the run part if 'r' is also specified
    fi
    cd ..
    echo -e "---\033[1;32m Running \033[0m---"
fi

if [[ "$1" == *"r"* ]]; then
    cd build || exit
    ./$EXECUTABLE
    C=$?
    [ "$C" -eq 0 ] && c=32 || c=31
    echo -e "\033[1;${c}mProcess exited with $C\033[0m"
    exit $C
fi

echo "Unknown command. Use 'h' for help."
exit 1