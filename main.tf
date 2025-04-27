resource "aws_instance" "machine" {
  key_name                    = aws_key_pair.key_pair.key_name
  vpc_security_group_ids      = [aws_security_group.security.id]
  instance_type               = var.instance_type
  ami                         = var.instance_ami
  depends_on                  = [aws_key_pair.key_pair, aws_security_group.security, var.vpc_id]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = var.associate_public_ip_address

  tags = {
    Name        = var.instance_name
    Environment = var.env
  }

  lifecycle {
    create_before_destroy = true
  }

  root_block_device {
    volume_size           = var.instance_storage
    volume_type           = var.instance_volume_type
    delete_on_termination = true
  }
}
