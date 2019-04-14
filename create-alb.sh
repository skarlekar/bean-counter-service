export SUBNET1=subnet-095dd4d5cf2031bd3
export SUBNET2=subnet-0dfcc0afce1bb56d9
export SECURITYGROUP=sg-03fe67d43722133c2
export VPC=vpc-0e7ce2d5fcb76194e

echo "Creating a application load balancer"
export ALB_ARN=$(./_create-load-balancer.sh | jq '.LoadBalancers[0].LoadBalancerArn' |  sed "s/\"//g")
echo ALB $ALB_ARN was created successfully!

echo "Creating a target group"
export TG_ARN=$(./_create-target-group.sh | jq '.TargetGroups[0].TargetGroupArn' |  sed "s/\"//g")
echo Target Group $TG_ARN was created successfully!

echo "Creating a listener"
export LISTENER_ARN=$(./_create-listener.sh | jq '.Listeners[0].ListenerArn' |  sed "s/\"//g")
echo Listener $LISTENER_ARN was created successfully!
