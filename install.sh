#!/usr/bin/env bash

SCRIPTS=($(find scripts -name '*.sh' -type f))

# Run all scripts
printf "%s\n" "${SCRIPTS[@]}" | xargs -I {} echo {}
