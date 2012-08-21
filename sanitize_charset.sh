#!/bin/bash
#
# Conversor UTF-8 a ISO-8859-1
# Lele

if [ "$UID" -eq "0" ];
then
  echo "ERROR: No ejecutar como root."
  exit 1
fi

if [ "convert" != "$1" ]; then
  echo "ATENCIÓN: Este script cambiará la codificación de todos los archivos del directorio actual a ISO-8859-1."
  echo "Para que la conversión tenga lugar debe pasar 'convert' como primer argumento."
  exit 1
fi

for F in `ls`;
do
    iconv -futf8 -tlatin1 $F > $F'__utf8'
    if [ $? == 0 ]; then
        mv $F'__utf8' $F
    else
        rm $F'__utf8'
    fi
done
