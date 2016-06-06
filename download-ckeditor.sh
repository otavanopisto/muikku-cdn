#!/bin/sh

addons="autogrow filetools image2 lineutils mathjax notification notificationaggregator uploadimage uploadwidget widget"
version=$1

if [ -z "$version" ]; then
  echo "Usage: download-ckeditor.sh [VERSION]"
  exit 1
fi;

set -e;

editor_folder="libs/ckeditor/${version}"
if [ ! -d $editor_folder ]; then
  zip_temp_file=tmp/ckeditor-${version}.zip
  zip_url="http://download.cksource.com/CKEditor/CKEditor/CKEditor%20${version}/ckeditor_${version}_full.zip"
  extract_temp_dir=tmp/ckeditor-${version}
  
  mkdir tmp
  wget $zip_url -O $zip_temp_file
  unzip $zip_temp_file -d ${extract_temp_dir}
  mv ${extract_temp_dir}/ckeditor libs/ckeditor/${version}
  rm -fR tmp
else
  echo "CKEditor $version already exists";
fi;

for addon in $addons 
do 
  addon_base_folder=libs/ckeditor-plugins/${addon}
  addon_folder=${addon_base_folder}/${version}
  
  if [ ! -d $addon_folder ]; then
  
    if [ ! -d $addon_base_folder ]; then
      mkdir $addon_base_folder
    fi;
    
    echo "Download $addon-$version"
    zip_url="http://download.ckeditor.com/${addon}/releases/${addon}_${version}.zip"
    zip_temp_file=tmp/${addon}-${version}.zip
    extract_temp_dir=tmp/${addon}-${version}
    
    mkdir tmp
    mkdir ${extract_temp_dir}
    wget $zip_url -O $zip_temp_file
    unzip $zip_temp_file -d ${extract_temp_dir}
    
    mv ${extract_temp_dir}/${addon} libs/ckeditor-plugins/${addon}/${version}
    rm -fR tmp
  else
    echo "Addon $addon $version already exists";
  fi;
done

set +e;
