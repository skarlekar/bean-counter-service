# Create VPC
export VPC=$(aws ec2 create-vpc --cidr-block 10.0.0.0/16 | jq '.Vpc.VpcId' |  sed "s/\"//g")
echo VPC: $VPC was created

# Tag the VPC with a name
aws ec2 create-tags --resources $VPC --tags Key=Name,Value=Bean-Counter-VPC

# Create Subnets
export SUBNET1=$(aws ec2 create-subnet --vpc-id $VPC --cidr-block 10.0.1.0/24 | jq '.Subnet.SubnetId' |  sed "s/\"//g")
echo SUBNET: $SUBNET1 was created
aws ec2 create-tags --resources $SUBNET1 --tags Key=Name,Value=Bean-Counter-Subnet1

export SUBNET2=$(aws ec2 create-subnet --vpc-id $VPC --cidr-block 10.0.0.0/24 | jq '.Subnet.SubnetId' |  sed "s/\"//g")
echo SUBNET: $SUBNET2 was created
aws ec2 create-tags --resources $SUBNET2 --tags Key=Name,Value=Bean-Counter-Subnet2

# Create Internet Gateway
export IGWY=$(aws ec2 create-internet-gateway | jq '.InternetGateway.InternetGatewayId' |  sed "s/\"//g")
echo Internet Gateway: $IGWY was created
aws ec2 create-tags --resources $IGWY --tags Key=Name,Value=Bean-Counter-IG

#Attach internet-gateway to VPC
aws ec2 attach-internet-gateway --vpc-id $VPC --internet-gateway-id $IGWY

# Create a route table for your VPC
export RTABLE=$(aws ec2  create-route-table --vpc-id $VPC | jq '.RouteTable.RouteTableId' |  sed "s/\"//g")
echo Route Table: $RTABLE was created
aws ec2 create-tags --resources $RTABLE --tags Key=Name,Value=Bean-Counter-RT

# Create a route in the route table that points all traffic (0.0.0.0/0) to the Internet gateway
aws ec2 create-route --route-table-id $RTABLE --destination-cidr-block 0.0.0.0/0 --gateway-id $IGWY

# Associate route table with the subnets created earlier
aws ec2 associate-route-table  --subnet-id $SUBNET1 --route-table-id $RTABLE
aws ec2 associate-route-table  --subnet-id $SUBNET2 --route-table-id $RTABLE

# Create a security group in your VPC
export SECURITYGROUP=$(aws ec2 create-security-group --group-name Bean-Counter-SG --description "Security group for Bean Counter Services" --vpc-id $VPC | jq '.GroupId' |  sed "s/\"//g")
echo Security Group: $SECURITYGROUP was created
aws ec2 create-tags --resources $SECURITYGROUP --tags Key=Name,Value=Bean-Counter-SG
aws ec2 authorize-security-group-ingress --group-id $SECURITYGROUP --protocol tcp --port 80 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id $SECURITYGROUP --protocol tcp --port 443 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id $SECURITYGROUP --protocol tcp --port 8080 --cidr 0.0.0.0/0

