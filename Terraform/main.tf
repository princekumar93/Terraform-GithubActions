provider "aws" {
    region = "us-east-1"
}


resource "aws_instance" "testInstance" {
  ami = "ami-02b972fec07f1e659"
  instance_type = "t2.micro"
  tags = {
    Name = "terraformEC2"
  }
}
