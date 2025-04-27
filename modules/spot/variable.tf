variable "instance_name" {
  description = "The name of the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance (e.g., t2.micro, t2.medium, t3.large)"
  type        = string
}

variable "instance_ami" {
  description = "The AMI ID for the EC2 instance"
  type        = string

  validation {
    condition     = can(regex("^ami-[a-zA-Z0-9]{8,}$", var.instance_ami))
    error_message = "Must be a valid AMI ID starting with 'ami-'."
  }
}

variable "instance_storage" {
  description = "The storage size in GB for the EC2 instance"
  type        = number
}

variable "instance_key_pair" {
  description = "The name of the SSH key pair for the EC2 instance"
  type        = string

  validation {
    condition     = length(var.instance_key_pair) > 1
    error_message = "Please provide a valid key pair name."
  }
}

variable "instance_key_pair_location" {
  description = "The local path to the private key file for SSH access"
  type        = string
}

variable "env" {
  description = "The deployment environment (e.g., dev, staging, production)"
  type        = string
}

variable "subnet_id" {
  description = "This is for a subnet id"
  type        = string
}

variable "vpc_id" {
  description = "This is for a vpc id"
  type        = string
}

# this will we defualt we dnot take this in module code 
variable "instance_security_group_name" {
  description = "this is the worker security group"
  type        = string
}

variable "ingress_rules" {
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
    description = string
  }))
  description = "List of ingress rules for security group"
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address with the instance"
  type        = bool
  validation {
    condition     = var.associate_public_ip_address == true || var.associate_public_ip_address == false
    error_message = "associate_public_ip_address must be a boolean value."
  }
}

variable "instance_volume_type" {
  description = "The type of volume to create (e.g., gp2, gp3, io1, st1)"
  type        = string

  validation {
    condition     = contains(["gp2", "gp3", "io1", "st1"], var.instance_volume_type)
    error_message = "Volume type must be one of: gp2, gp3, io1, st1."
  }
}