#!/bin/bash

if [ $# -ne 2 ]
then
    echo "Usage: $0 <executionRoleArn> <taskRoleArn>"
    exit 1
fi

export EXEC_ROLE_ARN=$1
export TASK_ROLE_ARN=$2

export ECR_IMAGE_LATEST=$ECR_REPO_URI:latest
cat register-bean-counter-task-def-template.json | jq '.containerDefinitions[0].image = env.ECR_IMAGE_LATEST' | jq '.executionRoleArn = env.EXEC_ROLE_ARN'| jq '.taskRoleArn = env.TASK_ROLE_ARN' > register-bean-counter-task-definition.json

