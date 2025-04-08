data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20250327"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] 
}


data "aws_ami" "linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.20250405.0-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] 
}






resource "aws_instance" "ubuntu" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  user_data = file("apache.sh")
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  subnet_id = aws_subnet.public2.id

  tags = {
    Name = "Ubuntu"
  }
}



resource "aws_instance" "linux" {
  ami           = data.aws_ami.linux.id
  instance_type = "t2.micro"
  user_data = file("httpd.sh")
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  subnet_id = aws_subnet.public1.id

  tags = {
    Name = "Amazon"
  }
}