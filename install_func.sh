#!/bin/sh

install_by_npm () {
    if [ $# -eq 1 ]; then
        if !(type $1 > /dev/null 2>&1); then
            echo "$1 is not installed. Start installing..."
            npm install --global $1
            echo
        else
            echo "$1 is installed."
        fi
    else
        echo "[install_by_npm] Number of params error."
    fi
}
