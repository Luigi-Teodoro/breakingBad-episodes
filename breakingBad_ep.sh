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
  echo -e "\t${greenColour}e) Buscar por nombre de episodio.${endColour}\n"
}

function buscarEpisodio (){
  episodeName="$1"
  echo -e "\n${yellowColour}[+]${endColour} ${greenColour}Mostrando informacion del episodio${endColour} ${yellowColour}$episodeName${endColour}${greenColour}.${endColour}\n"
  curl -s $main_url | js-beautify | grep -i -E "$episodeName" -A 4 | tr -d '"' | tr -d ',' | sed 's/^ *//'
 }


trap ctrl_c INT

#Indicadores
declare -i parameter_counter=0

while getopts "e:h" arg; do 
  case $arg in 
    e) episodeName=$OPTARG; let parameter_counter+=1;;
    h) ;;
  esac
done

if [ $parameter_counter -eq 1 ]; then
  buscarEpisodio $episodeName
else
  helpPanel
fi 


  

