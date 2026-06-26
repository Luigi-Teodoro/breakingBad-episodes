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

function ctrl_c(){
  echo -e "\n\n${redColour}Saliendo...${endColour}\n"
  exit 1
}


function helpPanel(){
  echo -e "\n${yellowColour}[+] Uso:${endColour}\n"
  echo -e "\t${greenColour}u) Buscar capitulos de la temporada 1.${endColour}\n"
}

function buscarEpisodio (){
  episodeName="$1"
  echo -e "\n${yellowColour}[+] Mostrando detalles del capitulo :${endColour} ${greenColour}$episodeName${endColour}\n"
  curl -s https://www.formulatv.com/series/breaking-bad/capitulos/ | html2text | grep -i -E "Temporada 1" -A 21 | sed 's/_/ /g' | grep "$episodeName" -A 1 -B 1
}

trap ctrl_c INT

#Indicadores
declare -i parameter_counter=0

while getopts "u:h" arg; do 
  case $arg in 
    u) episodeName=$OPTARG; let parameter_counter+=1;;
    h) ;;
  esac
done

if [ $parameter_counter -eq 1 ]; then
  buscarEpisodio $episodeName
else
  helpPanel
fi 


  

