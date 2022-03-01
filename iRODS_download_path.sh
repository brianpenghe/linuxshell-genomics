#!/bin/sh
while read link
    do
        name=$(echo $link | rev | cut -d/ -f1 | rev) &&
        mkdir "$name" &&
        cd $name &&
        iget -K -r $link &&
        mv */* ./ &&
        cd ../ &
    done<FolderPaths.txt
