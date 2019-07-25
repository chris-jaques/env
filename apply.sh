#!/bin/sh

# apply environment

if ! grep -q "~/env/aliases" ~/.bashrc; then
    echo "source ~/env/aliases" >> ~/.bashrc
fi
