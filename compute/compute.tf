data "aws_ami" "server_ami" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
}

resource "aws_key_pair" "k3_key" {
  key_name   = "k3-key"
  public_key = file(var.public_key_path)
}

resource "aws_instance" "k3_control_plane" {
  ami                    = data.aws_ami.server_ami.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [var.public_sg]
  subnet_id              = var.public_subnet[count.index]

  root_block_device {
    volume_size = var.volume_size
  }

  key_name = aws_key_pair.k3_key.id
  user_data = templatefile(var.user_data_path, {
    nodename    = "k3ec2"
    db_endpoint = var.db_endpoint
    dbuser      = var.dbuser
    dbname      = var.dbname
    dbpass      = var.dbpass
  })


  tags = {
    company = "k3_ec2"
  }
}