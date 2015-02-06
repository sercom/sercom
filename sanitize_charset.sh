#!/bin/bash
#
# Conversor UTF-8 a ISO-8859-1
# Lele

if [ "$UID" -eq "0" ];
then
  echo "ERROR: No ejecutar como root."
  exit 1
fi

file=$1

iconv -futf8 -tlatin1 "$file" > "$file.conv"
if [ $? == 0 ]; then
    echo "Converting File: $file. SUCCESS"
    mv "$file.conv" "$file"
    exit 0
else
    echo "Converting File: $file. FAIL"
    rm "$file.conv"
    exit 1
fi

