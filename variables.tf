# Variables
variable "front_end_instance_count" {
  default = 5
}

variable "microservices_instance_count" {
  default = 7
}

variable "db_instance_count" {
  default = 2
}

# Subnet IDs
variable "subnet_ids" {
  default = ["subnet-xxxxxxxx", "subnet-yyyyyyyy"]  # Replace with your subnet IDs
}

