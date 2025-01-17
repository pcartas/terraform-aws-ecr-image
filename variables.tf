variable "dockerfile_dir" {
  type        = string
  description = "The directory that contains the Dockerfile"
}

variable "ecr_repository_url" {
  type        = string
  description = "Full url for the ECR repository"
}

variable "docker_image_tag" {
  type        = string
  description = "This is the tag which will be used for the image that you created"
  default     = "latest"
}

variable "docker_build_args" {
  description = "Optional build arguments for Docker"
  type        = map(string)
  default     = {}
}

variable "docker_user" {
  type        = string
  description = "Username for docker login"
  sensitive   = true
}

variable "docker_password" {
  type        = string
  description = "Password for docker login"
  sensitive   = true
}

variable "region" {
  type        = string
  description = "AWS region"
}

variable "account_id" {
  type        = string
  description = "AWS account id"
  sensitive   = true
}