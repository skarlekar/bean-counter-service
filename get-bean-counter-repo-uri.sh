aws ecr describe-repositories | jq '.repositories[] | if .repositoryName == "bean-counter" then .repositoryUri else null end' | grep -v null | sed "s/\"//g"
