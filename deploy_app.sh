#!/bin/bash

set -eu
set -x
set -o pipefail

source_dir="$1"
app_name="$2"
app_name_hyp=$(echo "${app_name}" | tr _ -)
app_name_und=$(echo "${app_name}" | tr - _)

target_dir="assets/$app_name_und"
rm -rvf "$target_dir"
#cp -rv "$source_dir/build" "$target_dir"
cp -rv "$source_dir/dist" "$target_dir"

path_manifest_json=$(find $target_dir -name "manifest.json")
path_main_js=$(find $target_dir -name 'main.*.js')
path_main_css=$(find $target_dir -name 'main.*.css')

>"_layouts/${app_name_und}.html" cat<<EOF
<!DOCTYPE html>
<html lang="pl-PL">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<meta name="theme-color" content="#000000">
<meta name="description" content="">
<link rel="apple-touch-icon" href="/logo192.png">
<link rel="manifest" href="/${path_manifest_json}">
<script defer src="/${path_main_js}"></script><link href="/${path_main_css}" rel="stylesheet">
</head>
<body>
<noscript>You need to enable JavaScript to run this app.</noscript>
<div id="root"></div>
</body>
</html>
EOF



_date=$(tscalc -f %Y-%m-%d)
post_path="_posts/${_date}-${app_name_hyp}.markdown"

>"${post_path}" cat<<EOF
---
layout: ${app_name_und}
title:  The Foo app
date:   ${_date} 00:00:00 -0000
permalink: ${app_name_hyp}

---
EOF

echo "Ensure path_main_js=${path_main_js} points to correct js and path_main_css=${path_main_css} points to CSS file".
