#!/bin/bash

#global list
r=""
programname=$0

usage() {
	echo ""
    echo "Usage: $programname [branchType] [branchExclusionList]"
    echo "	branchType		all, local, remote"
    echo "		all			deletes all local and remote branches except what is provided in branchExclusionList"
    echo "		local			deletes all local branches except what is provided in branchExclusionList"
    echo "		remote			deletes all remote branches except what is provided in branchExclusionList"
    echo ""
    echo "	branchExclusionList	list of branches to exclude"
    echo ""
    echo "  	ex: ./$programname all master develop #deletes all local and remote branches except master and develop"
    echo ""
    exit 1
}

delete_remote_branches() {
	#checks and prunes origin then deletes any remote branch not in list
	git branch -r | awk -F/ '{print $2}' | grep -v ${1} | xargs -I {} git push origin :{}
}

delete_local_branches() {
	echo $1
	#deletes any local branch not in list
	git branch | grep -v ${1} | xargs git branch -d 
}

build_restricted_branch_list() {
	exclusionList=""
	for var in ${@:2}
	do
		exclusionList+=$var"\|"
	done
	size=${#exclusionList} 
	echo ${exclusionList:0:(${size}-2)}
}

#Script entry point

#check for no params and show usage
[ -z $1 ] && { usage; }

#check for help command and show usage
if [ $1 == "-h" ] 
then 
	usage;
fi

#execute branch deletions
if [ $1 == "all" ]
then
	exclusionList=$(build_restricted_branch_list $@)
	delete_remote_branches ${exclusionList}
	delete_local_branches ${exclusionList}
elif [ $1 == "local" ] 
then
	exclusionList=$(build_restricted_branch_list $@)
	delete_local_branches ${exclusionList}
elif [ $1 == "remote" ]
then
	exclusionList=$(build_restricted_branch_list $@)
	delete_remote_branches ${exclusionList}
else
	echo "Incorrect syntax. See -h for more details."
fi