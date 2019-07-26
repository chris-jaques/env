#!/bin/sh

# apply environment

if ! grep -q "~/env/loadEnv" ~/.bashrc; then
    echo "source ~/env/loadEnv" >> ~/.bashrc
fi
