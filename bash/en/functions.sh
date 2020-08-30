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
alias delete="deleteaction"
alias list="listaction"
alias show="list"
alias validate="validateaction"
