#!/usr/bin/env bash
source "autoload.sh"
clear

echo "--- tester ---"
echo "$IS_DEPLOYMENT_PRODUCTION"
echo "--- tester ---"

# if "$IS_DEPLOYMENT_PRODUCTION" not exist or set to true, run production,
# ->

#  if [[ -v $IS_DEPLOYMENT_PRODUCTION ] && [ "$IS_DEPLOYMENT_PRODUCTION" = false ]] ; then
#
#      # development
#      echo 'Be careful not to fall off!'
#
#
#      else
#      # production
#     echo 'else'
#
#  fi

### New syntax:


b=false

if [[ $IS_DEPLOYMENT_PRODUCTION = false ]] ; then
#if [[ -v $IS_DEPLOYMENT_PRODUCTION ]] && [[ "$IS_DEPLOYMENT_PRODUCTION" = true ]]; then
  echo "normal route with: -> ${IS_DEPLOYMENT_PRODUCTION}- "
else
  echo "else route with: -> ${IS_DEPLOYMENT_PRODUCTION}-"
fi

#drawHeader

#breakProcess
#
#wrap_text "Hello World" green
#colorShowcase
