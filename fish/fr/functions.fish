#
# SPDX-FileCopyrightText: 2020 John Samuel <johnsamuelwrites@gmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later
#


function créer --description 'créer un fichier ou un répertoire'
  set argcompteur (count $argv)
  if test $argv[1] = "fichier"
    touch $argv[2..$argcompteur]
  else if test $argv[1] = "répertoire" 
    mkdir -p $argv[2..$argcompteur]
  end
end

function valider --description 'valider le fichier xml ou json'
  set argcompteur (count $argv)
  if test $argv[1] = "xml"
    xmllint $argv[2..$argcompteur]
  else if test $argv[1] = "json" 
    jq . $argv[2..$argcompteur]
  end
end

function changer --description 'modifier ou changer de fichier ou de répertoire'
  set argcompteur (count $argv)
  if test $argv[1] = "fichier"
    vim $argv[2..$argcompteur]
  else if test $argv[1] = "répertoire" 
    cd $argv[2..$argcompteur]
  end
end

function modifier --description 'modifier fichier ou de répertoire'
  changer $argv
end

function afficher --description 'lire ou afficher un fichier ou un répertoire'
  set argcompteur (count $argv)
  if test $argv[1] = "fichier"
    cat $argv[2..$argcompteur]
  else if test $argv[1] = "répertoire" 
    ls -p $argv[2..$argcompteur]
  end
end

function supprimer --description 'supprimer un fichier, un processusus ou un répertoire'
  set argcompteur (count $argv)
  if test $argv[1] = "fichier"
    rm $argv[2..$argcompteur]
  else if test $argv[1] = "processus" 
    kill -9 $argv[2..$argcompteur]
  else if test $argv[1] = "répertoire" 
    rmdir $argv[2..$argcompteur]
  end
end

function lister --description 'lister des fichiers, des processusus, des répertoires...'
  set argcompteur (count $argv)
  if test $argv[1] = "fichier"
    ls $argv[2..$argcompteur]
  else if test $argv[1] = "processus" 
    ps -aux
  else if test $argv[1] = "répertoire" 
    ls
  else if test $argv[1] = "réseau" 
    netstat -natp
  else if test $argv[1] = "cpu" 
    lscpu
  else if test $argv[1] = "matériel" 
    lshw
  else if test $argv[1] = "mémoire" 
    cat /proc/meminfo
  end
end

# Ajouter le support pour l'autocomplétion des options 
# https://stackoverflow.com/questions/16657803/creating-autocomplete-script-avec_des-sub-commands
function functions_avec_des_options
  set cmd (commandline -opc)
  set commands "afficher" "créer" "supprimer" "lister" "changer" "modifier" "valider"
  if [ (count $cmd) -eq 1 ]
    if contains $cmd[1] $commands
      return 0
    end
  end
  return 1
end

funcsave créer afficher supprimer lister changer modifier valider
funcsave functions_avec_des_options
complete -f -c créer -n 'functions_avec_des_options' -a 'fichier répertoire'
complete -f -c valider -n 'functions_avec_des_options' -a 'xml json'
complete -f -c changer -n 'functions_avec_des_options' -a 'fichier répertoire'
complete -f -c modifier -n 'functions_avec_des_options' -a 'fichier répertoire'
complete -f -c afficher -n 'functions_avec_des_options' -a 'fichier répertoire'
complete -f -c supprimer -n 'functions_avec_des_options' -a 'fichier répertoire processus'
complete -f -c lister -n 'functions_avec_des_options' -a 'fichier répertoire processus réseau cpu matériel mémoire'
