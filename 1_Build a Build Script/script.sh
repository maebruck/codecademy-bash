#!/bin/bash

echo "Welcome!"

firstline=$(head -n 1 source/changelog.md)
read -a splitfirstline <<< $firstline
version=${splitfirstline[1]}
echo "Building version:" $version
echo "Would you like to build? Press 1 to continue, or 0 to exit"
read versioncontinue
if [ $versioncontinue == "1" ]
then
  echo "OK"
else
  echo "Please come back when you're ready."
fi
for file in source/*
do
  if [ $file == "source/secretinfo.md" ]
  then
    sed "s/42/XX/" $file >> build/secretinfo.md
    echo "replaced secret and copied" $file
  else
    echo "copying" $file
    cp $file build/
  fi
done
echo "Copied files:"
ls build/
firstlinepost=$(head -n 1 build/changelog.md)
read -a splitfirstlinepost <<< $firstlinepost
versionpost=${splitfirstlinepost[1]}
echo "Copied version:" $versionpost
echo "Preparing" $version ".zip"
zip -r $version.zip build/*
echo "Finished zipping."
