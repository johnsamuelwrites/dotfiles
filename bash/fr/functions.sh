#
# SPDX-FileCopyrightText: 2020 John Samuel <johnsamuelwrites@gmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later
#

function actioncréer() {
  count=$#
  if [[ $1 == "fichier" ]]
  then
    shift
    touch $@
  elif [[ $1 == "répertoire" ]]
  then
    shift
    mkdir $@
  fi
}

function actionéditer() {
  count=$#
  if [[ $1 == "fichier" ]]
  then
    shift
    vim $@
  elif [[ $1 == "répertoire" ]]
  then
    shift
    cd $@
  fi
}

function actionvalider() {
  count=$#
  if [[ $1 == "xml" ]]
  then
    shift
    xmllint --noout $@
  elif [[ $1 == "json" ]]
  then
    shift
    jq . $@
  fi
}

function actionlire() {
  count=$#
  if [[ $1 == "fichier" ]]
  then
    shift
    cat $@
  elif [[ $1 == "répertoire" ]]
  then
    shift
    ls $@
  fi
}
function actionsupprimer() {
  count=$#
  if [[ $1 == "fichier" ]]
  then
    shift
    rm $@
  elif [[ $1 == "processusus" ]]
  then
    shift
    kill -9 $@
  elif [[ $1 == "répertoire" ]]
  then
    shift
    rmdir $@
  fi
}
function actionlister() {
  count=$#
  if [[ $1 == "fichier" ]]
  then
    shift
    ls -a $@
  elif [[ $1 == "répertoire" ]]
  then
    shift
    ls $@
  elif [[ $1 == "réseau" ]]
  then
    shift
    netstat -natp 
  elif [[ $1 == "cpu" ]]
  then
    shift
    lscpu 
  elif [[ $1 == "hardware" ]] || [ [$1 == "matériel" ]]
  then
    shift
    lshw
  elif [[ $1 == "mémoire" ]]
  then
    shift
    cat /proc/meminfo
  elif [[ $1 == "batterie" ]]
  then
    shift
    acpi -V
  elif [[ $1 == "processus" ]]
  then
    shift
    ps -aux
  fi
}

alias créer="actioncréer"
alias lire="actionlire"
alias supprimer="actionsupprimer"
alias lister="actionlister"
alias afficher="actionlister"
alias valider="actionvalider"
alias éditer="actionéditer"
alias changer="éditer"


#Ajouter un support pour l'autocomplétion
complete -W 'fichier répertoire' créer
complete -W 'fichier répertoire' lire
complete -W 'fichier processus répertoire' supprimer
complete -W 'fichier répertoire réseau cpu processus mémoire hardware' afficher
complete -W 'fichier répertoire réseau cpu processus mémoire hardware' lister
complete -W 'xml json' valider
