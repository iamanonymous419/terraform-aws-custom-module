Here's a professional `README.md` for a Terraform module that provisions multiple EC2 instances (e.g., `master` and `master_2`):


# Terraform AWS EC2 Multiple Instances Module

## Overview

This Terraform module provisions multiple AWS EC2 instances, each with customizable parameters such as instance type, AMI, key pair, and security group rules. It allows you to launch and manage multiple EC2 instances (e.g., `master` and `master_2`), with outputs providing essential instance details such as public DNS, IP addresses, and state.

## Features

- Launches multiple EC2 instances with configurable parameters for each.
- Automatically sets up security group rules (SSH and HTTP) for each instance.
- Outputs important details for each instance:
  - Public DNS
  - Public IP
  - Private IP
  - Instance state
  - Availability zone
  - Tags and security groups

## Prerequisites

To use this module, you will need:

- **Terraform** installed. Instructions are available [here](https://www.terraform.io/downloads).
- **AWS credentials** configured using AWS CLI (`aws configure`) or environment variables.

## Module Usage

### Step 1: Install Terraform

Ensure that Terraform is installed and accessible in your terminal.

```bash
terraform -v
```

### Step 2: Configure AWS Credentials

Make sure your AWS credentials are properly configured. You can do this by either:

- Running `aws configure` to set up access keys or
- Setting `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables.

### Step 3: Define the Module in Your Terraform Configuration

Below is an example of how to define and use the module for launching multiple EC2 instances (`master` and `master_2`).

#### Example `main.tf`

```hcl
provider "aws" {
  region = "ap-south-1"
}

module "master" {
  source  = "iamanonymous419/ec2-module/aws"
  version = "3.0.0"
  instance_name                = "master"
  env                          = "test"
  instance_key_pair_location   = "./test.pub"
  instance_key_pair            = "test"
  associate_public_ip_address  = true
  instance_volume_type         = "gp2"
  instance_type                = "t3.large"
  instance_ami                 = "ami-12345678"  # Replace with your AMI ID
  instance_storage             = 29
  instance_security_group_name = "master"
  ingress_rules                = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow SSH"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTP"
    }
  ]
  subnet_id                    = "subnet-12345678"
  vpc_id                       = "vpc-12345678"
}

module "master_2" {
  source  = "iamanonymous419/ec2-module/aws"
  version = "3.0.0"
  instance_name                = "master_2"
  env                          = "test"
  instance_key_pair_location   = "./test.pub"
  instance_key_pair            = "test"
  associate_public_ip_address  = true
  instance_volume_type         = "gp2"
  instance_type                = "t2.large"
  instance_ami                 = "ami-12345678"  # Replace with your AMI ID
  instance_storage             = 10
  instance_security_group_name = "master_2"
  ingress_rules                = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow SSH"
    },
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "Allow HTTP"
    }
  ]
  subnet_id                    = "subnet-12345678"
  vpc_id                       = "vpc-12345678"
}

output "master_instance_dns" {
  description = "The public DNS of the master EC2 instance"
  value       = module.master.instance_dns
}

output "master_instance_id" {
  description = "The ID of the master EC2 instance"
  value       = module.master.instance_id
}

output "master_instance_public_ip" {
  description = "The public IP address of the master EC2 instance"
  value       = module.master.instance_public_ip
}

output "master_instance_private_ip" {
  description = "The private IP address of the master EC2 instance"
  value       = module.master.instance_private_ip
}

output "master_instance_availability_zone" {
  description = "The Availability Zone of the master EC2 instance"
  value       = module.master.instance_availability_zone
}

output "master_instance_tags" {
  description = "Tags associated with the master EC2 instance"
  value       = module.master.instance_tags
}

output "master_instance_security_groups" {
  description = "The security groups associated with the master EC2 instance"
  value       = module.master.instance_security_groups
}

# Outputs for master_2 instance

output "master_2_instance_dns" {
  description = "The public DNS of the master_2 EC2 instance"
  value       = module.master_2.instance_dns
}

output "master_2_instance_id" {
  description = "The ID of the master_2 EC2 instance"
  value       = module.master_2.instance_id
}

output "master_2_instance_public_ip" {
  description = "The public IP address of the master_2 EC2 instance"
  value       = module.master_2.instance_public_ip
}

output "master_2_instance_private_ip" {
  description = "The private IP address of the master_2 EC2 instance"
  value       = module.master_2.instance_private_ip
}

output "master_2_instance_availability_zone" {
  description = "The Availability Zone of the master_2 EC2 instance"
  value       = module.master_2.instance_availability_zone
}

output "master_2_instance_tags" {
  description = "Tags associated with the master_2 EC2 instance"
  value       = module.master_2.instance_tags
}

output "master_2_instance_security_groups" {
  description = "The security groups associated with the master_2 EC2 instance"
  value       = module.master_2.instance_security_groups
}
```

### Step 4: Initialize Terraform

Run the following command to initialize your Terraform working directory:

```bash
terraform init
```

### Step 5: Apply the Configuration

Run the following command to apply the configuration and create the EC2 instances:

```bash
terraform apply
```

Review the plan and type `yes` to confirm the creation of resources.

### Step 6: Access Outputs

After the successful creation of the resources, Terraform will output information about each EC2 instance (`master` and `master_2`), including:

- **master_instance_dns**: The public DNS address of the `master` EC2 instance.
- **master_instance_id**: The instance ID of the `master` EC2 instance.
- **master_instance_public_ip**: The public IP address of the `master` EC2 instance.
- **master_instance_private_ip**: The private IP address of the `master` EC2 instance.
- **master_instance_availability_zone**: The Availability Zone of the `master` EC2 instance.
- **master_instance_tags**: Tags associated with the `master` EC2 instance.
- **master_instance_security_groups**: The security groups associated with the `master` EC2 instance.
- **master_2_instance_dns**: The public DNS address of the `master_2` EC2 instance.
- **master_2_instance_id**: The instance ID of the `master_2` EC2 instance.
- **master_2_instance_public_ip**: The public IP address of the `master_2` EC2 instance.
- **master_2_instance_private_ip**: The private IP address of the `master_2` EC2 instance.
- **master_2_instance_availability_zone**: The Availability Zone of the `master_2` EC2 instance.
- **master_2_instance_tags**: Tags associated with the `master_2` EC2 instance.
- **master_2_instance_security_groups**: The security groups associated with the `master_2` EC2 instance.

### Step 7: Destroy the Resources

If you no longer need the provisioned resources, you can destroy them with the following command:

```bash
terraform destroy
```

Terraform will prompt you to confirm the deletion of resources. Type `yes` to proceed.

## License

This module is licensed under the [MIT License](LICENSE).
