variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_blocks" {
  type        = list(string)
  description = "List of CIDR blocks for the subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "port" {
  type        = number
  description = "Port number for ingress rule"
  default     = 80
}

variable "task_definition_family" {
  type        = string
  description = "The family of the task definition"
  default     = "my-task-definition"
}

variable "task_definition_container_name" {
  type        = string
  description = "The name of the container in the task definition"
  default     = "my-container"
}

variable "image" {
  type        = string
  description = "The Docker image to use for the container"
  default     = "my-docker-image"
}

variable "desired_count" {
  type        = number
  description = "The number of tasks to run for the service"
  default     = 2
}

variable "container_port" {
  type        = number
  description = "The port number on which the container listens"
  default     = 80
}

variable "health_check_path" {
  type        = string
  description = "The path on which the container listens for the health check"
  default     = "/health"
}

