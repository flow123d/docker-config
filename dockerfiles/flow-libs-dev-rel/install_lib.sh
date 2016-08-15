#!/bin/bash
# script will install library given by library name ($1), version ($2) and 
# build type ($3)
#


# check acceptable BUILD_TYPE argument
if [ "${3^^}" == "DEBUG" ]; then
    FILE=${1^^}_${2}.deb
    URL=http://ciflow.nti.tul.cz/packages/${1^^}_${2}_Debug/${FILE}
elif [[ "${3^^}" == "RELEASE" ]]; then
    FILE=${1^^}_${2}.deb
    URL=http://ciflow.nti.tul.cz/packages/${1^^}_${2}_Release/${FILE}
else
    echo "Invalid BUILD_TYPE argument '${3}'"
    exit 1
fi


# work in temp file
# firts we download debian package and then install it
# after installation we remove deb package
cd /tmp
echo "Downloading ${FILE} from ${URL}"
wget ${URL}
dpkg -i ${FILE}
ls -la
rm -f ${FILE}