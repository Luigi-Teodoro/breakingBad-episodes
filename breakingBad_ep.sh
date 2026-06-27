#!/bin/bash

#Colores

greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

#Variables Globales
main_url="https://api.mridul.tech/api/breaking-bad/episodes"


function ctrl_c(){
  echo -e "\n\n${redColour}Saliendo...${endColour}\n"
  exit 1
}


function helpPanel(){
  echo -e "\n${yellowColour}[+] Uso:${endColour}\n"
  echo -e "\t${greenColour}e) Buscar por nombre de episodio.${endColour}"
  echo -e "\t${greenColour}s) Mostrar todos los capitulos de una temporada.${endColour}\n"
}

function buscarEpisodio(){
  episodeName="$1"
  echo -e "\n${yellowColour}[+]${endColour} ${greenColour}Mostrando informacion del episodio${endColour} ${yellowColour}$episodeName${endColour}${greenColour}.${endColour}\n"
  curl -s $main_url | js-beautify | grep -i -E "$episodeName" -A 4 | tr -d '"' | tr -d ',' | sed 's/^ *//'
 }

function buscarTemporada(){
  seasonNumber="$1"
  echo -e "\n${yellowColour}[+]${endColour} ${greenColour}Mostrando todos los capitulos de la temporada.${endColour} ${yellowColour}$seasonNumber${endColour}\n"
  curl -s $main_url | js-beautify | grep "\"season\": \"$seasonNumber\"" -B 1 | sed 's/^ *//' | tr -d '"' | tr -d ','
}


trap ctrl_c INT

#Indicadores
declare -i parameter_counter=0

while getopts "e:hs:" arg; do 
  case $arg in 
    e) episodeName=$OPTARG; let parameter_counter+=1;;
    s) seasonNumber=$OPTARG; let parameter_counter+=2;;
    h) ;;
  esac
done

if [ $parameter_counter -eq 1 ]; then
  buscarEpisodio $episodeName
elif [[ $parameter_counter -eq 2 ]]; then
  buscarTemporada $seasonNumber
else
  helpPanel
fi

