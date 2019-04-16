# bean-counter-service


git clone https://github.com/skarlekar/bean-counter-service.git
cd bean-counter-service/pre-requisites/
./prereqs-ubuntu.sh
aws configure set default.region us-east-1
aws configure set default.output json

# Create the ECR Repository
source ./create-bean-counter-repository.sh

# Build Docker image and push to ECR repository
./push-to-ecr.sh

# Create the bean counter log group
./create-bean-counter-log-group.sh

# Create the bean counter cluster
./create-bean-counter-cluster.sh

# Create ecsTaskExecutionRole and taskRole in IAM and note down the ARNs
./create-roles.sh

# Generate bean counter task definition from the template
./generate-bean-counter-task-definition.sh $TASK_ROLE_ARN $TASK_ROLE_ARN

# Register the bean counter task definition 
./register-bean-counter-task.sh

# Create VPC, Subnets and Security groups for running Fargate
source ./create-vpc-subnets.sh

# Create the ALB
source ./create-alb.sh

# Generate bean counter service definition from the template
./generate-bean-counter-service-definition.sh $SUBNET1 $SUBNET2 $SECURITYGROUP

# Create the service
./create-bean-counter-service.sh

# Set the scaling policy
./set-scaling-policy.sh

# Test scaling
./test-scaling.sh
