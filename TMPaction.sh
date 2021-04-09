
export GITHUB_REPOSITORY="lorenzo-cavazzi/ActionsRepo"

## pr_contains_string=$(curl -s https://api.github.com/repos/${GITHUB_REPOSITORY}/pulls/${{ inputs.pr_ref }} | jq ".body | test(\"${{ inputs.string }}\")")

curl -s https://api.github.com/repos/${GITHUB_REPOSITORY}/pulls/1 | jq '.body | split("/deploy ") | last | split("\r\n") | first'

curl -s https://api.github.com/repos/${GITHUB_REPOSITORY}/pulls/1 | jq '.body | split("/deploy ") | last | split("\r\n") | first'


components=$(curl -s https://api.github.com/repos/${GITHUB_REPOSITORY}/pulls/1 | jq '.body | split("/deploy ") | last | split("\r\n") | first') 
echo $components



GITHUB_REPOSITORY=lorenzo-cavazzi/ActionsRepo
curl -s https://api.github.com/repos/${GITHUB_REPOSITORY}/pulls/1 | jq '.body | split("/deploy") | last | split("\r\n") | first | ltrimstr(" ")'


GITHUB_REPOSITORY=lorenzo-cavazzi/ActionsRepo
curl -s https://api.github.com/repos/${GITHUB_REPOSITORY}/pulls/2 | jq '.body | split("/deploy") | last | split("\r\n") | first | ltrimstr(" ")'


# STEP 1 -- DONE
GITHUB_REPOSITORY=lorenzo-cavazzi/ActionsRepo
pr_text=$(curl -s https://api.github.com/repos/${GITHUB_REPOSITORY}/pulls/2 | jq ".body")
echo $pr_text
pr_contains_string=$(echo $pr_text | jq 'test("/deploy")')
echo $pr_contains_string


# STEP 2 -- DONE
GITHUB_REPOSITORY=lorenzo-cavazzi/ActionsRepo
pr_text=$(curl -s https://api.github.com/repos/${GITHUB_REPOSITORY}/pulls/1 | jq ".body")
echo $pr_text
pr_contains_string=$(echo $pr_text | jq 'test("/deploy")')
echo "String found: $pr_contains_string"
if [ "$pr_contains_string" = true ] ; then
    echo "I found the string, great!"
    command=$(echo $pr_text | jq 'split("/deploy ") | last | split("\r\n") | first')
    if [[ $command != *"/deploy"* ]]; then
        echo "Found command: $command"
    fi
fi


# STEP 3 -- done
GITHUB_REPOSITORY=lorenzo-cavazzi/ActionsRepo
pr_text=$(curl -s https://api.github.com/repos/${GITHUB_REPOSITORY}/pulls/1 | jq ".body")
echo $pr_text
pr_contains_string=$(echo $pr_text | jq 'test("/deploy")')
echo "String found: $pr_contains_string"
if [ "$pr_contains_string" = true ] ; then
    command=$(echo $pr_text | jq -r 'split("/deploy ") | last | split("\r\n") | first')
    if [[ $command != *"/deploy"* ]]; then
        echo "Command found: $command"
        match="renku=(\S*)"
        if [[ $command =~ $match ]]; then
            echo "renku reference: ${BASH_REMATCH[1]}"
        fi
        match="renku-core=(\S*)"
        if [[ $command =~ $match ]]; then
            echo "renku-core reference: ${BASH_REMATCH[1]}"
        fi
        match="renku-gateway=(\S*)"
        if [[ $command =~ $match ]]; then
            echo "renku-gateway reference: ${BASH_REMATCH[1]}"
        fi
        match="renku-graph=(\S*)"
        if [[ $command =~ $match ]]; then
            echo "renku-graph reference: ${BASH_REMATCH[1]}"
        fi
        match="renku-notebooks=(\S*)"
        if [[ $command =~ $match ]]; then
            echo "renku-notebooks reference: ${BASH_REMATCH[1]}"
        fi
        match="renku-ui=(\S*)"
        if [[ $command =~ $match ]]; then
            echo "renku-ui reference: ${BASH_REMATCH[1]}"
        fi
        match="renku-ui-server=(\S*)"
        if [[ $command =~ $match ]]; then
            echo "renku-ui-server reference: ${BASH_REMATCH[1]}"
        fi
    else
        echo "No command found"
    fi
fi


# STEP 4 - almost done
GITHUB_REPOSITORY=lorenzo-cavazzi/ActionsRepo
pr_text=$(curl -s https://api.github.com/repos/${GITHUB_REPOSITORY}/pulls/1 | jq ".body")
echo $pr_text
pr_contains_string=$(echo $pr_text | jq 'test("/deploy")')
echo "String found: $pr_contains_string"
test_enabled=true
if [ "$pr_contains_string" = true ] ; then
    command=$(echo $pr_text | jq -r 'split("/deploy ") | last | split("\r\n") | first')
    if [[ $command != *"/deploy"* ]]; then
        echo "Command found: $command"
        match="renku=(\S*)"
        if [[ $command =~ $match ]]; then
            echo "renku reference: @${BASH_REMATCH[1]}"
        fi
        match="renku-core=(\S*)"
        if [[ $command =~ $match ]]; then
            echo "renku-core reference: @${BASH_REMATCH[1]}"
        fi
        match="renku-gateway=(\S*)"
        if [[ $command =~ $match ]]; then
            echo "renku-gateway reference: @${BASH_REMATCH[1]}"
        fi
        match="renku-graph=(\S*)"
        if [[ $command =~ $match ]]; then
            echo "renku-graph reference: @${BASH_REMATCH[1]}"
        fi
        match="renku-notebooks=(\S*)"
        if [[ $command =~ $match ]]; then
            echo "renku-notebooks reference: @${BASH_REMATCH[1]}"
        fi
        match="renku-ui=(\S*)"
        if [[ $command =~ $match ]]; then
            echo "renku-ui reference: @${BASH_REMATCH[1]}"
        fi
        match="renku-ui-server=(\S*)"
        if [[ $command =~ $match ]]; then
            echo "renku-ui-server reference: @${BASH_REMATCH[1]}"
        fi
        match="#notest"
        if [[ $command =~ $match ]]; then
            test_enabled=false
        fi
    else
        echo "No command found"
    fi
fi
echo "Test enabled: $test_enabled"
