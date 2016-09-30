#!/bin/bash

echo "${BASH_SOURCE[0]}"

this_script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

set -e

export BUNDLE_GEMFILE="${this_script_dir}/Gemfile"
pwd
ls -l  $BITRISE_APK_PATH
ls -l $this_script_dir/step.rb
#bundle install
bundle exec ruby "$this_script_dir/step.rb" "$BITRISE_APK_PATH"
