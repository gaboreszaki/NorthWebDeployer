#!/usr/bin/env bash

cd "$(dirname "$0")" || exit

if [ ! $1 ]; then
  echo "please provide the domain name for the config file"
  exit
else
  source "autoload.sh"
fi

generateList "$1"
listDeployments "$1"
draw_line

#colorShowcase

printf "${tint_grey}To cancel the operation press enter or input any non integer values${tint_reset}\n"
read -p 'Please type in the ID of the rollback (Int):' choice
draw_line

if [[ $choice ]] && [ $choice -eq $choice ] 2>/dev/null; then

  printf "${tint_green}Rollback started${tint_reset}\n"
  printf "${tint_grey}Selected deployment point:${tint_reset} %s\n" "${listForExport[$choice]}"

  draw_line
  ln -vfns "${GIT_target_folder}/${listForExport[$choice]}" "$ACTIVE_folder"
  draw_line
  printf "${tint_green}Rollback Done!${tint_reset}\n"
  printf "${tint_red}Warning! THIS Rollback HAS NOT Rolled back any DATABASE changes!${tint_reset}\n"
  printf "${tint_red}Please dont forget to migrate${tint_reset}\n"

else

  printf "${tint_red}Rollback skipped!${tint_reset}\n"
  draw_line
  printf "${tint_grey}Input only accept \'Integers\' ${tint_reset}\n"

  exit
fi

### Selected:
#ln -vfns "${GIT_target_folder}/${listForExport[$choice]}" "$ACTIVE_folder"

#listDeployments
