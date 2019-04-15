export ECR_REPO_URI=$(aws ecr create-repository --repository-name bean-counter |  jq '.repository.repositoryUri' | sed "s/\"//g")
