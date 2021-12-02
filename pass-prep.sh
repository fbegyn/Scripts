#! /usr/bin/env bash

( cd $PASSWORD_STORE_DIR && find . \! -path \*.git\* -a -type d ) | sed -e 's#^./##' | while read d; do mkdir -p $d; done

( cd $PASSWORD_STORE_DIR && find . -type f -name \*.gpg ) | sed -e 's#^./##' -e 's#\.gpg$##' | sort | while read fname; do echo $fname; pass ${fname} > ${fname}; done
