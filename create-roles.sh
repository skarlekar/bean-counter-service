# Create a new role to be used for ECS tasks
export TASK_ROLE=my-ecs-tasks-s3-access
aws iam create-role --role-name $TASK_ROLE --assume-role-policy-document file://ecs-tasks-assume-role.json --description "Allows ECS tasks to call S3 on your behalf"
# Attach S3 access managed policy to the role created above
aws iam attach-role-policy --role-name $TASK_ROLE --policy-arn arn:aws:iam::aws:policy/AmazonS3FullAccess
aws iam attach-role-policy --role-name $TASK_ROLE --policy-arn arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy

# Retrieve the role ARN for future processing
export TASK_ROLE_ARN=$(aws iam get-role --role-name $TASK_ROLE | jq '.Role.Arn' | sed "s/\"//g")
echo Execution Role: $TASK_ROLE_ARN captured

