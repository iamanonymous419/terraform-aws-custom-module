provider "aws" {
  region = "ap-south-1"
}

module "master" {
  source                       = "../../"
  instance_name                = "master"
  env                          = "test"
  instance_key_pair_location   = "./test.pub"
  instance_key_pair            = "test"
  associate_public_ip_address  = true
  instance_volume_type         = "gp2"
  instance_type                = "t3.large"
  instance_ami                 = "ami-12345678" # Replace with your AMI ID
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


# second machine
module "master_2" {
  source                       = "../../"
  instance_name                = "master_@"
  env                          = "test"
  instance_key_pair_location   = "./test.pub"
  instance_key_pair            = "test"
  associate_public_ip_address  = true
  instance_volume_type         = "gp2"
  instance_type                = "t2.large"
  instance_ami                 = "ami-12345678" # Replace with your AMI ID
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