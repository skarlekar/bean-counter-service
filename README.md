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

# Generate bean counter task definition from the template
./generate-bean-counter-task-definition.sh arn:aws:iam::219104658389:role/ecsTaskExecutionRole arn:aws:iam::219104658389:role/skarlekar-ecs-s3-full-access

Cheat: gen-bean-counter-task-def.sh 

# Register the bean counter task definition 
./register-bean-counter-task.sh

# Create VPC, Subnets and Security groups for running Fargate

# Create the ALB
source ./create-alb.sh

# Generate bean counter service definition from the template
./generate-bean-counter-service-definition.sh subnet-095dd4d5cf2031bd3 subnet-0dfcc0afce1bb56d9 sg-03fe67d43722133c2

# Create the service
./create-bean-counter-service.sh

# Set the scaling policy
./set-scaling-policy.sh

# Test scaling
./test-scaling.sh
