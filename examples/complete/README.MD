Sure! Here's a more professional version of the `README.md` that is clean, structured, and concise, suitable for a Terraform module:


# Terraform AWS EC2 Master Module

## Overview

This Terraform module provisions an AWS EC2 instance in the `ap-south-1` region with configurable parameters such as instance type, AMI, key pair, and security group rules. The module outputs key information about the instance, including public DNS, private IP, instance state, and more.

## Features

- Launches an EC2 instance with customizable parameters.
- Automatically sets up security group rules (SSH and HTTP).
- Outputs essential details about the EC2 instance:
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

You can source the `master` module from the relative path. Below is an example `main.tf` for using the module:

```hcl
provider "aws" {
  region = "ap-south-1"
}

module "master" {
  source                       = "../../modules/master"  # Update the path accordingly
  instance_name                = "master-instance"
  env                          = "test"
  instance_key_pair_location   = "./test.pub"
  instance_key_pair            = "test-key"
  associate_public_ip_address  = true
  instance_volume_type         = "gp2"
  instance_type                = "t3.large"
  instance_ami                 = "ami-12345678"  # Replace with your desired AMI ID
  instance_storage             = 29
  instance_security_group_name = "master-sg"
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
```

### Step 4: Initialize Terraform

Run the following command to initialize your Terraform working directory:

```bash
terraform init
```

### Step 5: Apply the Configuration

Run the following command to apply the configuration and create the EC2 instance:

```bash
terraform apply
```

Review the plan and type `yes` to confirm the creation of resources.

### Step 6: Access Outputs

After the successful creation of the resources, Terraform will output information about the EC2 instance, including:

- **master_instance_dns**: The public DNS address of the EC2 instance.
- **master_instance_id**: The instance ID of the EC2 instance.
- **master_instance_public_ip**: The public IP address of the EC2 instance.
- **master_instance_private_ip**: The private IP address of the EC2 instance.
- **master_instance_availability_zone**: The Availability Zone of the EC2 instance.
- **master_instance_tags**: Tags associated with the EC2 instance.
- **master_instance_security_groups**: The security groups associated with the EC2 instance.

## Destroying the Resources

If you no longer need the provisioned resources, you can destroy them with the following command:

```bash
terraform destroy
```

Terraform will prompt you to confirm the deletion of resources. Type `yes` to proceed.

## Outputs

The following outputs will be available after successful application:

- `master_instance_dns`: The public DNS address of the master EC2 instance.
- `master_instance_id`: The EC2 instance ID.
- `master_instance_public_ip`: The public IP address of the master EC2 instance.
- `master_instance_private_ip`: The private IP address of the master EC2 instance.
- `master_instance_availability_zone`: The availability zone of the EC2 instance.
- `master_instance_tags`: Tags associated with the EC2 instance.
- `master_instance_security_groups`: The security groups associated with the EC2 instance.

## Variables

### `instance_name` (string)

The name of the EC2 instance.

### `env` (string)

The environment for the instance (e.g., `test`, `prod`).

### `instance_key_pair` (string)

The key pair name for SSH access to the EC2 instance.

### `instance_key_pair_location` (string)

Path to the public key file for the EC2 instance.

### `associate_public_ip_address` (bool)

Whether to associate a public IP address with the instance (default: `true`).

### `instance_volume_type` (string)

The volume type for the instance’s root block device (e.g., `gp2`, `io1`).

### `instance_type` (string)

The instance type (e.g., `t3.large`, `t2.micro`).

### `instance_ami` (string)

The AMI ID for the EC2 instance.

### `instance_storage` (number)

The size (in GB) of the instance's root block device.

### `instance_security_group_name` (string)

The name of the security group to be associated with the instance.

### `ingress_rules` (list)

A list of ingress rules to be applied to the security group. Each rule is an object with:

- `from_port`: The starting port range.
- `to_port`: The ending port range.
- `protocol`: The protocol (e.g., `tcp`, `udp`).
- `cidr_blocks`: List of allowed IP ranges in CIDR notation.
- `description`: A description of the rule.

### `subnet_id` (string)

The ID of the subnet in which to launch the EC2 instance.

### `vpc_id` (string)

The VPC ID in which to launch the EC2 instance.

## License

This module is licensed under the [MIT License](../../LICENSE).

