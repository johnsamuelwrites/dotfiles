#
# SPDX-FileCopyrightText: 2020 John Samuel <johnsamuelwrites@gmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later
#

# Resource names
file="file"
directory="directory"
network="network"
cpu="cpu"
process="process"
memory="memory"
hardware="hardware"
battery="battery"
power="power"

xml="xml"
json="json"

# Action verbs
create="create"
readactionverb="read" #read is a keyword
edit="edit"
update="update"
change="change"
delete="delete"
remove="remove"
copy="copy"
move="move"
list="list"
show="show"
rename="rename"
validate="validate"

# Functions to handle different actions
function createaction() {
  if [[ $1 == $file ]]
  then
    shift
    touch $@
  elif [[ $1 == $directory ]]
  then
    shift
    mkdir $@
  fi
}

function editaction() {
  if [[ $1 == $file ]]
  then
    shift
    gedit $@
  elif [[ $1 == $directory ]]
  then
    shift
    cd $@
  fi
}

function copyaction() {
  if [[ $1 == $file ]]
  then
    shift
    cp $@
  elif [[ $1 == $directory ]]
  then
    shift
    cp -r $@
  fi
}

function moveaction() {
  if [[ $1 == $file ]]
  then
    shift
    cp $@
  elif [[ $1 == $directory ]]
  then
    shift
    cp -r $@
  fi
}

function validateaction() {
  if [[ $1 == $xml ]]
  then
    shift
    xmllint --noout $@
  elif [[ $1 == $json ]]
  then
    shift
    jq . $@
  fi
}

function readaction() {
  if [[ $1 == $file ]]
  then
    shift
    cat $@
  elif [[ $1 == $directory ]]
  then
    shift
    ls $@
  fi
}
function deleteaction() {
  if [[ $1 == $file ]]
  then
    shift
    rm $@
  elif [[ $1 == $process ]]
  then
    shift
    kill -9 $@
  elif [[ $1 == $directory ]]
  then
    shift
    rmdir $@
  fi
}
function listaction() {
  if [[ $1 == $file ]]
  then
    shift
    ls -a $@
  elif [[ $1 == $directory ]]
  then
    shift
    ls $@
  elif [[ $1 == $network ]]
  then
    netstat -natp 
  elif [[ $1 == $cpu ]]
  then
    lscpu 
  elif [[ $1 == $hardware ]]
  then
    lshw
  elif [[ $1 == $memory ]]
  then
    cat /proc/meminfo
  elif [[ $1 == $battery ]]  || [ [$1 == $power ]]
  then
    acpi -V
  elif [[ $1 == $process ]]
  then
    ps -aux
  fi
}


function batteryaction() {
  if [[ $1 == $list || $1 == $show ]]
  then
    acpi -V
  fi
}

function poweraction() {
  if [[ $1 == $list || $1 == $show ]]
  then
    acpi -V
  fi
}

function fileaction() {
  if [[ $1 == $create ]]
  then
    shift
    touch $@
  elif [[ $1 == $edit ]]
  then
    shift
    gedit $@
  elif [[ $1 == $copy ]]
  then
    shift
    cp $@
  elif [[ $1 == $move || $1 == $rename ]]
  then
    shift
    mv $@
  elif [[ $1 == $delete || $1 == $remove ]]
  then
    shift
    rm $@
  elif [[ $1 == $list || $1 == $show ]]
  then
    shift
    ls -a $@
  fi

}

function directoryaction() {
  if [[ $1 == $create ]]
  then
    shift
    mkdir $@
  elif [[ $1 == $edit || $1 == $change || $1 == $update ]]
  then
    shift
    cd $@
  elif [[ $1 == $copy ]]
  then
    shift
    cp $@
  elif [[ $1 == $move  || $1 == $rename ]]
  then
    shift
    mv $@
  elif [[ $1 == $delete  || $1 == $remove ]]
  then
    shift
    rmdir $@
  elif [[ $1 == $list  || $1 == $show ]]
  then
    shift
    ls $@
  fi


}

function processaction() {
  if [[ $1 == $list  || $1 == $show ]]
  then
    ps -aux
  elif [[ $1 == $delete  || $1 == $remove ]]
  then
    shift
    kill -9 $@
  fi

}

function networkaction() {
  if [[ $1 == $list  || $1 == $show ]]
  then
    netstat -natp 
  fi

}

function cpuaction() {
  if [[ $1 == $list  || $1 == $show ]]
  then
    lscpu 
  fi

}

function memoryaction() {
  if [[ $1 == $list  || $1 == $show ]]
  then
    cat /proc/meminfo
  fi

}

function hardwareaction() {
  if [[ $1 == $list  || $1 == $show ]]
  then
    lshw
  fi

}

alias $create="createaction"
alias $readactionverb="readaction"
alias $edit="editaction"
alias $delete="deleteaction"
alias $remove="deleteaction"
alias $list="listaction"
alias $show="list"
alias $update="edit"
alias $change="edit"
alias $copy="copyaction"
alias $move="moveaction"
alias $rename="moveaction"
alias $validate="validateaction"

alias $network="networkaction"
alias $cpu="cpuaction"
alias $process="processaction"
alias $memory="memoryaction"
alias $hardware="hardwareaction"
alias $battery="batteryaction"
alias $power="poweraction"
alias $file="fileaction"
alias $directory="directoryaction"

#Add support for autocompletion
#Action verb and object combination
complete -o default -W "$file $directory" $create
complete -o default -W "$file $directory" $readactionverb
complete -o default -W "$file $directory" $edit
complete -o default -W "$file $directory" $update
complete -o default -W "$file $directory" $change
complete -o default -W "$file $directory" $copy
complete -o default -W "$file $directory" $move
complete -o default -W "$file $directory" $rename
complete -o default -W "$file $process $directory" $delete
complete -o default -W "$file $process $directory" $remove
complete -o default -W "$file $directory $network $cpu $process $memory $hardware $battery $power" $show
complete -o default -W "$file $directory $network $cpu $process $memory $hardware $battery $power" $list
complete -o default -W "$xml $json" $validate


#Add support for autocompletion
#object and action verb combination
complete -o default -W "$list $show" $network
complete -o default -W "$list $show" $cpu
complete -o default -W "$list $show" $process
complete -o default -W "$list $show" $memory
complete -o default -W "$list $show" $hardware 
complete -o default -W "$list $show" $battery
complete -o default -W "$list $show" $power
complete -o default -W "$create $read $edit $update $change $delete $remove $copy $move $rename" file
complete -o default -W "$create $read $edit $update $change $delete $remove $copy $move $rename" directory

