# Fail fast
set -e

# This is the order of arguments
build_folder=$1
aws_ecr_repository_url_with_tag=$2
build_args_json=$3
region=$4
docker_user=$5
docker_password=$6
account_id=$7

# Check that aws is installed
which aws > /dev/null || { echo 'ERROR: aws-cli is not installed' ; exit 1; }

# Connect into aws
aws ecr get-login-password --region $region | docker login --username AWS --password-stdin $account_id.dkr.ecr.$region.amazonaws.com

# Check that docker is installed and running
which docker > /dev/null && docker ps > /dev/null || { echo 'ERROR: docker is not running' ; exit 1; }

# Parse build args from JSON to Docker's format
build_args=$(echo "$build_args_json" | jq -r 'to_entries|map("--build-arg \(.key)=\(.value|tostring)")|.[]')

# Some Useful Debug
echo "Building $aws_ecr_repository_url_with_tag from $build_folder/Dockerfile with args $build_args"

# Login Docker
sudo docker login -u $docker_user -p $docker_password https://index.docker.io/v1

# Build image
sudo docker build $build_args -t $aws_ecr_repository_url_with_tag $build_folder

# Push image
sudo docker push $aws_ecr_repository_url_with_tag