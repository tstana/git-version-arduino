#!/bin/bash

# Script to provide automatic git-base versioning to Arduino's sketches.
# Basically it runs "git describe" on source folder and creates 
# a file in the destination directory containg an elaborated output.
# If output is not found in source directory, the script ends immediatly
# without errors.
# (by default, output file is named git-version.h)
#
# Input parameters:
#  1. [Mandatory] source folder, where target files is located. It may be in subfolder of repository.
#  2. [Optional] (Default value: the same as first param) path of destination directory.

# Name of file to be created
filename=git-version.h

# Go to the source directory
if [ -n "$1" ]; then
    cd "$1"
else
    echo "Error: You MUST specify the source directory parameter. Exiting."
    exit 1
fi
echo "Changing "$filename" at source path "$1

if [ -f "$1/$filename" ]; then
    echo "$1/$filename exists"
    echo "Removing..."
    rm $1/$filename
fi

if [ -n "$2" ]; then
    filepath=$2/$filename
else
    filepath=./$filename
fi

# Build a version string with git
version=$(git rev-parse --short HEAD 2> /dev/null)

if [ -n "$version" ]; then 
    echo "git version:" $version
else
    echo "No git repo was found!"
    exit 1
fi

# If this is not a git repository, fallback to the compilation date
[ -n "$version" ] || version=$(date -I)
# If this is not a git repository, create an empty file
#[ -n "$version" ] || echo "" > $filename; exit 1

# Save this in git-version.h
echo -n "Creating file" $filepath"..."

echo "#ifndef __GIT_VERSION_H__" >> $filepath
echo "#define __GIT_VERSION_H__" >> $filepath
echo "" >> $filepath
echo "#define GIT_VERSION \"$version\"" >> $filepath
echo "" >> $filepath
echo "#endif // __GIT_VERSION_H__" >> $filepath
echo "" >> $filepath

echo " Done!"

#read -p "Press key to exit..." variable1
