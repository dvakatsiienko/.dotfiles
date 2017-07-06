a=git cherry -v dev | wc -l | xargs;
echo "commits $a"
git rebase -i HEAD~"$a"

