#!/bin/bash

if [ $# -ne 3 ]
then
    echo "Usage: $0 <subnet1> <subnet2> <security-group>"
    exit 1
fi

export SUBNET1=$1
export SUBNET2=$2
export SECURITY_GROUP=$3

cat create-bean-counter-service-def-template.json| jq '.loadBalancers[0].targetGroupArn = env.TG_ARN' | jq '.networkConfiguration.awsvpcConfiguration.subnets = [env.SUBNET1, env.SUBNET2]'| jq '.networkConfiguration.awsvpcConfiguration.securityGroups = [env.SECURITY_GROUP]' > create-bean-counter-service-definition.json

