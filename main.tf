terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.33.0"
    }
  }
}

# Define AWS provider
provider "aws" {
  region = "us-west-2"  # Change this to your desired region
}

# EC2 Instances
resource "aws_instance" "front_end" {
  count         = var.front_end_instance_count
  ami           = "ami-xxxxxxxxxxxxxxxx"  # Specify the AMI ID
  instance_type = "t2.micro"
  # Other instance configuration options go here
}

resource "aws_instance" "microservices" {
  count         = var.microservices_instance_count
  ami           = "ami-yyyyyyyyyyyyyyyy"  # Specify the AMI ID
  instance_type = "t2.micro"
  # Other instance configuration options go here
}

resource "aws_instance" "db" {
  count         = var.db_instance_count
  ami           = "ami-zzzzzzzzzzzzzzzz"  # Specify the AMI ID
  instance_type = "t3.large"
  # Other instance configuration options go here
}

# Auto Scaling for microservices instances
resource "aws_autoscaling_group" "microservices_asg" {
  desired_capacity     = var.microservices_instance_count
  max_size             = var.microservices_instance_count + 1  # Adjust as needed
  min_size             = var.microservices_instance_count - 1  # Adjust as needed
  vpc_zone_identifier = var.subnet_ids  # Use the subnet IDs variable
  launch_configuration = aws_launch_configuration.microservices_lc.id
}

resource "aws_launch_configuration" "microservices_lc" {
  image_id        = "ami-yyyyyyyyyyyyyyyy"  # Specify the AMI ID
  instance_type   = "t2.micro"
  # Other launch configuration options go here
}

