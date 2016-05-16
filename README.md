GitTools ReadMe

This repo serves to hold my personal git related tools that are free to use and modify.

git_prune_script.sh

  Git script allows you to delete all remote and/or local branches except any provided branches.

Recommend way to add this is to alias it in your .bash_profile like such:

runPruneScript() {
SCRIPT_PATH=~/git/GitTools
chmod +x $SCRIPT_PATH/git_prune_script.sh
sh $SCRIPT_PATH/git_prune_script.sh "$@"
}
alias gitprune=runPruneScript "$@"

  See ./git_prune_script -h for usage

  ToDo: Add merged deleting already merged branches option.
  
prepare-commit-msg

  Global git hook that prepends "branchName - " to all commits, allowing automatic linking to tickets

Other useful tools

  https://github.com/m1foley/fit-commit - Validates each commit against community/team standards before allowing you to commit