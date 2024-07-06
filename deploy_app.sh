#!/bin/bash

set -eu
set -x
set -o pipefail

source_dir="$1"
app_name="$2"
target_dir="assets/$app_name"
rm -rvf "$target_dir"
cp -rv "$source_dir/build" "$target_dir"

path_manifest_json=$(find $target_dir -name "manifest.json")
path_main_js=$(find $target_dir -name 'main.*.js')
path_main_css=$(find $target_dir -name 'main.*.css')

>"_layouts/${app_name}.html" cat<<EOF
<!DOCTYPE html>
<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<meta name="theme-color" content="#000000">
<meta name="description" content="">
<link rel="apple-touch-icon" href="/logo192.png">
<link rel="manifest" href="/${path_manifest_json}">
<title>React App</title>
<script defer src="/${path_main_js}"></script><link href="/${path_main_css}" rel="stylesheet">
</head>
<body>
<noscript>You need to enable JavaScript to run this app.</noscript>
<div id="root"></div>
</body>
</html>
EOF
