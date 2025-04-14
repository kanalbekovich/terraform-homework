resource "aws_instance" "linux" {
  ami                    = var.ec2[0].ami
  instance_type          = var.ec2[0].type
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  subnet_id              = aws_subnet.main1.id
  tags                   = local.tags
}

resource "aws_instance" "ubuntu" {
  ami                    = var.ec2[1].ami
  instance_type          = var.ec2[1].type
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  subnet_id              = aws_subnet.main2.id
  tags                   = local.tags
}

resource "aws_key_pair" "deployer" {
  key_name   = var.key_pair
  public_key = file("~/.ssh/id_rsa.pub")
  tags       = local.tags
}

