provider "aws" {
  region = var.region
}

resource "aws_instance" "ubuntu" {
  ami           = "ami-08e93a9522bbe6df6"
  instance_type = var.instance_type

  network_interface {
    network_interface_id = aws_network_interface.nic.id
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "unlimited"
  }
  tags = {
    Name    = "tf-cloud-learning"
    tooling = "tf-cloud"
  }
}

resource "aws_vpc" "tf_cloud_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name    = "tf-cloud-learning"
    tooling = "tf-cloud"
  }
}
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.tf_cloud_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name    = "tf-cloud-learning"
    tooling = "tf-cloud"
  }
}

resource "aws_network_interface" "nic" {
  subnet_id   = aws_subnet.private_subnet.id
  private_ips = ["172.16.10.100"]

  tags = {
    Name    = "tf-cloud-learning"
    tooling = "tf-cloud"
  }
}
