#!/usr/bin/env bash

if ! grep -q '/swapfile none swap sw 0 0' /etc/fstab; then
    sudo fallocate -l 4G /swapfile || exit 1
    sudo chmod 600 /swapfile || exit 1
    sudo mkswap /swapfile || exit 1
    sudo swapon /swapfile || exit 1
    if grep -q '' /etc/sysctl.conf; then
        echo 'vm.vfs_cache_pressure=50' | sudo tee -a /etc/sysctl.conf
    else
        echo 'Failed to set cache pressure.'
        exit 1
    fi
    echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab || exit 1
fi
