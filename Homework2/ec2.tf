data "aws_availability_zones" "available" {}

resource "aws_instance" "web" {
  count         = 3
  ami           = "ami-03f8acd418785369b"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  key_name = aws_key_pair.deployer.key_name
  user_data = file("apache.sh")
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  

  tags = {
    Name = "web-${count.index + 1}"
  }
}

