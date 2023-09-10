#!/usr/bin/env bash
up=$(git ls-remote https://github.com/cpina/github-action-push-to-another-repository |  head -1 | cut -f 1 )
cat .github/version.txt | while read line      
do
   lc=$line          
done

if [[ ${up} == ${lc} ]]
then
    echo 'there is nothing to do'
else
    git config user.name GitHub
    git config user.email noreply@github.com
    git clone https://github.com/cpina/github-action-push-to-another-repository.git tmp
    mv tmp/Dockerfile tmp/action.yml tmp/entrypoint.sh .
    echo "${up}" > .github/version.txt
    rm -rf tmp
    git add .
    git commit --author "github-actions[bot] <41898282+github-actions[bot]@users.noreply.github.com>" --allow-empty -m "$(git log -1 --pretty=%s)"
    git push 
fi
