#
# SPDX-FileCopyrightText: 2020 John Samuel <johnsamuelwrites@gmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later
#

function createaction() {
  count=$#
  if [[ $1 == "file" ]]
  then
    shift
    touch $@
  elif [[ $1 == "directory" ]]
  then
    shift
    mkdir $@
  fi
}

function editaction() {
  count=$#
  if [[ $1 == "file" ]]
  then
    shift
    vim $@
  elif [[ $1 == "directory" ]]
  then
    shift
    cd $@
  fi
}

function validateaction() {
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

function readaction() {
  count=$#
  if [[ $1 == "file" ]]
  then
    shift
    cat $@
  elif [[ $1 == "directory" ]]
  then
    shift
    ls $@
  fi
}
function deleteaction() {
  count=$#
  if [[ $1 == "file" ]]
  then
    shift
    rm $@
  elif [[ $1 == "process" ]]
  then
    shift
    kill -9 $@
  elif [[ $1 == "directory" ]]
  then
    shift
    rmdir $@
  fi
}
function listaction() {
  count=$#
  if [[ $1 == "file" ]]
  then
    shift
    ls -a $@
  elif [[ $1 == "directory" ]]
  then
    shift
    ls $@
  elif [[ $1 == "network" ]]
  then
    shift
    netstat -natp 
  elif [[ $1 == "cpu" ]]
  then
    shift
    lscpu 
  elif [[ $1 == "hardware" ]]
  then
    shift
    lshw
  elif [[ $1 == "memory" ]]
  then
    shift
    cat /proc/meminfo
  elif [[ $1 == "process" ]]
  then
    shift
    ps -aux
  fi
}

alias create="createaction"
alias read="readaction"
alias edit="editaction"
alias delete="deleteaction"
alias list="listaction"
alias show="list"
alias update="edit"
alias change="edit"
alias validate="validateaction"


#Add support for autocompletion
complete -W 'file directory' create
complete -W 'file directory' read
complete -W 'file directory' edit
complete -W 'file directory' update
complete -W 'file directory' change
complete -W 'file process directory' delete
complete -W 'file directory network cpu process memory hardware' show
complete -W 'file directory network cpu process memory hardware' list
complete -W 'xml json' validate
