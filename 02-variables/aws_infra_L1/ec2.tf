# create an EC2 instance
resource "aws_instance" "ubuntu" {
  ami           = var.ubuntu_ami
  instance_type = var.instance_type 
  tags = {
    Name = var.instance_name
  }
}

