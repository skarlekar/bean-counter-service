aws elbv2 create-target-group --name bean-counter-targets --protocol HTTP --port 80 --target-type ip --vpc-id $VPC
