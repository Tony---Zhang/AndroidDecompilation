#!/bin/bash
set -e
# remove file($1) suffix
name=${1%%.*}
mv $name.apk $name.zip
unzip $name.zip
rm -rf META-INF
rm -rf res
rm resources.arsc
rm AndroidManifest.xml
mv $name.zip $name.apk
echo "==============================="
echo "unzip $name completed"
dex_result="dex results: "
for file in `ls *.dex`
do
  dex_result=$dex_result$file'; '
  ./hello/dex2jar-2.0/d2j-dex2jar.sh $file
done
echo "==============================="
echo $dex_result
rm *.dex
echo "==============================="
echo "decode completed"
java -jar ./hello/jd-gui-1.4.0.jar *-dex2jar.jar
