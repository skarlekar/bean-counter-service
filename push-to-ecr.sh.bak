$(aws ecr get-login --no-include-email --region us-east-1)
docker build -t bean-counter bean-counter
docker tag bean-counter:latest 219104658389.dkr.ecr.us-east-1.amazonaws.com/bean-counter:latest
docker push 219104658389.dkr.ecr.us-east-1.amazonaws.com/bean-counter:latest
