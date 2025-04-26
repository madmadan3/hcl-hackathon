aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 539935451710.dkr.ecr.us-east-1.amazonaws.com

docker build -t helloworld:latest .
docker tag helloworld:latest 539935451710.dkr.ecr.us-east-1.amazonaws.com/helloworld
docker push 539935451710.dkr.ecr.us-east-1.amazonaws.com/helloworld




539935451710.dkr.ecr.us-east-1.amazonaws.com/helloworld:latest