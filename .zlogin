#
# startup file read in interactive login shells
#
# Re-create cached files if needed
(compileAllTheThings) &!

if [[ ${+WINDOWID} = 0 ]]
then
  # We are remote
else
  # We are local
  ~/bin/kittyMode.sh
fi
