#!/usr/bin/env bash

declare -n mainTint='tint_cian'
tint_reset='\e[0m'

tint_black='\e[30m'
tint_red='\e[31m'
tint_green='\e[32m'
tint_yellow='\e[33m'
tint_blue='\e[34m'
tint_magenta='\e[35m'
tint_cian='\e[36m'
tint_grey='\e[90m'
tint_white='\e[97m'

tint_green_light='\e[1;32m'
tint_purple_light='\e[1;35m'
tint_blue_light='\e[1;34m'
tint_cian_light='\e[1;36m'

tint_grey_light='\e[37m'

function wrap_text() {

  if [[ -z $1 ]] || [[ -z $2 ]]; then
    echo "usage: wrap text color"
    exit
  fi

  # Magic -> creating a reference variable:
  declare -n text_color="tint_$2"

  echo -e "$text_color"$1"$tint_reset"

}

function colorShowcase() {

  wrap_text "black: ########## ############ #############" black
  wrap_text "white: ########## ############ #############" white
  wrap_text "red: ########## ############ #############" red
  wrap_text "green: ########## ############ #############" green
  wrap_text "blue: ########## ############ #############" blue
  wrap_text "magenta: ########## ############ #############" magenta
  wrap_text "yellow: ########## ############ #############" yellow
  wrap_text "cian: ########## ############ #############" cian
  wrap_text "grey: ########## ############ #############" grey

}
