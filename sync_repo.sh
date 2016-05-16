remote=origin;

#Get all changes and track all branches for repo
git -C ~/path/to/repo/ pull --all

for brname in `git -C ~/path/to/repo/ branch -r | grep $remote | grep -v master | grep -v HEAD | awk '{gsub(/[^\/]+\//,"",$1); print $1}'`;
  do 
  #set local branch to track it's upstream
  `git -C ~/path/to/repo/ branch --set-upstream-to $remote/$brname $brname` || true; 
  # or if new branch in upstream, create it locally to be tracked
  `git -C ~/path/to/repo/ branch --track $brname $remote/$brname` || true; 
done