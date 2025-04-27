resource "aws_key_pair" "ssh_key" {
  key_name   = "my-key"
  public_key = file("~/.ssh/id_rsa.pub") 
}


data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "bastion" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  subnet_id     = module.network.public_subnet_ids[0]
  key_name      = aws_key_pair.ssh_key. key_name

  tags = {
    Name = "${var.env_name}-bastion-n"
  }

  provisioner "local-exec" {
    command = "echo Bastion Public IP: ${self.public_ip}"
  }
}
