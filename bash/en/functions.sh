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
  elif [[ $1 == "directory" ]]
  then
    shift
    rmdir $@
  fi
}

alias create="createaction"
alias read="readaction"
alias delete="deleteaction"
