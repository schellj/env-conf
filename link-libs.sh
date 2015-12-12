#!/bin/bash

if [ $# -ne 1 ];
then
    echo "Usage: $0 <path_to_gt_source_dir>"
    echo ''
    echo "Links Perl package lib directories to current directory to facilitate loading local libraries with PERRLIB.  It is recommended to execute this script in a new empty directory."
    exit 1
fi

pwd=$(pwd)
src_dir=$1
for a in $(ls $src_dir | egrep "^(gt-|rop-|ares-|Business-Magento)"); 
do 
    for b in $(find $src_dir/$a | egrep $a"(/perl)?/lib/[A-Z][^/]+(\.pm)?$");
    do
        p=`expr $b : '.*/'`
        c=${b:$p}
	if [ ! -L $c ];
	then
	    ln -s $b $c
	    echo $c+
	else
	    echo $c
	fi
    done
done

echo ''
echo '*** Add the following to your ~/.bashrc: export PERLLIB='$pwd
echo '*** Then execute the following: . ~/.bashrc'

