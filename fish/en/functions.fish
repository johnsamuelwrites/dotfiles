function create --description 'create file or directory'
  set argcount (count $argv)
  if test $argv[1] = "file"
    touch $argv[2..$argcount]
  else if test $argv[1] = "directory" 
    mkdir -p $argv[2..$argcount]
  end
end

function validate --description 'validate xml or json file'
  set argcount (count $argv)
  if test $argv[1] = "xml"
    xmllint $argv[2..$argcount]
  else if test $argv[1] = "json" 
    jq . $argv[2..$argcount]
  end
end

function edit --description 'edit or update file'
  set argcount (count $argv)
  if test $argv[1] = "file"
    vim $argv[2..$argcount]
  else if test $argv[1] = "directory" 
    cd $argv[2..$argcount]
  end
end

function update --description 'edit or update file'
  edit $argv
end

function change --description 'change, edit or update file'
  edit $argv
end

function show --description 'read or show file or directory'
  set argcount (count $argv)
  if test $argv[1] = "file"
    cat $argv[2..$argcount]
  else if test $argv[1] = "directory" 
    ls -p $argv[2..$argcount]
  end
end

function delete --description 'delete file, process or directory'
  set argcount (count $argv)
  if test $argv[1] = "file"
    rm $argv[2..$argcount]
  else if test $argv[1] = "process" 
    kill -9 $argv[2..$argcount]
  else if test $argv[1] = "directory" 
    rmdir $argv[2..$argcount]
  end
end

function list --description 'list file, process or directory'
  set argcount (count $argv)
  if test $argv[1] = "file"
    ls $argv[2..$argcount]
  else if test $argv[1] = "process" 
    ps -aux
  else if test $argv[1] = "directory" 
    ls
  else if test $argv[1] = "network" 
    netstat -natp
  else if test $argv[1] = "cpu" 
    lscpu
  else if test $argv[1] = "hardware" 
    lshw
  else if test $argv[1] = "memory" 
    cat /proc/meminfo
  end
end

# Add support for autocompletion of options
# https://stackoverflow.com/questions/16657803/creating-autocomplete-script-with-sub-commands
function functions_with_options
  set cmd (commandline -opc)
  set commands "show" "create" "delete" "list"
  if [ (count $cmd) -eq 1 ]
    if contains $cmd[1] $commands
      return 0
    end
  end
  return 1
end

funcsave create show delete list edit change update validate
funcsave functions_with_options
complete -f -c create -n 'functions_with_options' -a 'file directory'
complete -f -c validate -n 'functions_with_options' -a 'xml json'
complete -f -c edit -n 'functions_with_options' -a 'file directory'
complete -f -c change -n 'functions_with_options' -a 'file directory'
complete -f -c update -n 'functions_with_options' -a 'file directory'
complete -f -c show -n 'functions_with_options' -a 'file directory'
complete -f -c delete -n 'functions_with_options' -a 'file directory process'
complete -f -c list -n 'functions_with_options' -a 'file directory process network cpu hardware'
