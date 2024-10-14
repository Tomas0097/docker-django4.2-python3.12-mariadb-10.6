#!/bin/bash

# change files ownership to folder's owner and group
# used to change user after a file has been created inside container with root owner

set -e

if [ -z "$1" ]; then
    echo fix-privileges.sh '<path>'
    exit 1
fi

if [ ! -d "$1" ]; then
    echo Not a directory: $1
    exit 1
fi

folder_owner_id=$(stat -c %u "$1")
folder_group_id=$(stat -c %g "$1")

echo chown -R $folder_owner_id:$folder_group_id $1
chown -R $folder_owner_id:$folder_group_id $1
