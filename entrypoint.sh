#!/usr/bin/env sh

# mount point: -v "/home/runner/work/<repo_name>/<repo_name>":"/github/workspace" 
# if INPUT_APP_PATH = hoge
# current dir /github/workspace in docker
# ADDON_NAME=$(ls $INPUT_APP_PATH)
# -> ls hoge
# hoge.tar.gz
# --> ADDON_NAME=hoge.tar.gz

# ADDON_FULL_PATH="$INPUT_APP_PATH/$ADDON_NAME"
# -> ADDON_FULL_PATH=hoge/hoge.tgz

# Expected condition is to exist the following path in host if INPUT_APP_PATH=hoge.
# /home/runner/work/<repo_name>/<repo_name>/hoge/hoge.tgz

# current dir in host 
# /home/runner/work/<repo_name>/<repo_name>
# slim package ../<repo_name> 
# output: /home/runner/work/<repo_name>/<repo_name>/<repo_name>.tar.gz
# INPUT_APP_PATH have to be <repo_name> for ls command.
# finally these condition is required.
# INPUT_APP_PATH=<repo_name>
# file in host: /home/runner/work/<repo_name>/<repo_name>/<repo_name>/<repo_name>.tgz
# so need the following step 
# mkdir <repo_name>
# -> dir created: /home/runner/work/<repo_name>/<repo_name>/<repo_name>
# mv <repo_name>.tgz <repo_name>
# -> file moved: /home/runner/work/<repo_name>/<repo_name>/<repo_name>/<repo_name>.tgz

# if create <repo_name> dir first, slim command will include <repo_name> directory. 
# it's not good and this is really complex.

# just pass the tar.gz fie path which provided slim command
# INPUT_APP_PATH=<repo_name>.tar.gz
# /home/runner/work/<repo_name>/<repo_name>/<repo_name>.tar.gz
# -> /github/workspace/<repo_name>.tar.gz
ADDON_FULL_PATH=./$INPUT_APP_PATH

echo "$INPUT_USERNAME" "$INPUT_PASSWORD" "$ADDON_FULL_PATH" "$INPUT_INCLUDED_TAGS" "$INPUT_EXCLUDED_TAGS" "$INPUT_LOG_LEVEL"

python3 /main.py "$INPUT_USERNAME" "$INPUT_PASSWORD" "$ADDON_FULL_PATH" "$INPUT_INCLUDED_TAGS" "$INPUT_EXCLUDED_TAGS" "$INPUT_LOG_LEVEL"
