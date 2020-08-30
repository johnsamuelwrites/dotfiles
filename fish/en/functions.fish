function create --description 'create file or directory'
  set argcount (count $argv)
  if test $argv[1] = "file"
    touch $argv[2..$argcount]
  else if test $argv[1] = "directory" 
    mkdir -p $argv[2..$argcount]
  end
end

function show --description 'read or show file or directory'
  set argcount (count $argv)
  if test $argv[1] = "file"
    cat $argv[2..$argcount]
  else if test $argv[1] = "directory" 
    ls -p $argv[2..$argcount]
  end
end

# Add support for autocompletion of options
# https://stackoverflow.com/questions/16657803/creating-autocomplete-script-with-sub-commands
function functions_with_options
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 -a $cmd[1] = 'show' -o $cmd[1] = 'create' ]
    return 0
  end
  return 1
end

funcsave create show
funcsave functions_with_options
complete -f -c create -n 'functions_with_options' -a 'file directory'
complete -f -c show -n 'functions_with_options' -a 'file directory'
