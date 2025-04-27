output "instance_dns" {
  description = "Public DNS address of the EC2 instance"
  value       = aws_instance.machine.public_dns
}

output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.machine.id
}

output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.machine.public_ip
}

output "instance_private_ip" {
  description = "The private IP address of the EC2 instance"
  value       = aws_instance.machine.private_ip
}

output "instance_availability_zone" {
  description = "The Availability Zone of the EC2 instance"
  value       = aws_instance.machine.availability_zone
}
output "instance_tags" {
  description = "Tags associated with the EC2 instance"
  value = tomap({
    for key, value in aws_instance.machine.tags : key => value
  })
}

output "instance_security_groups" {
  description = "The security groups associated with the EC2 instance"
  value = toset([
    for sg in aws_instance.machine.security_groups : sg
  ])
}
