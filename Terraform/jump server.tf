resource "aws_instance" "my-jump-server" {
  ami           = "ami-0557a15b87f6559cf"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  subnet_id = aws_subnet.pub-sub1.id
  vpc_security_group_ids = [aws_security_group.pub-secgroup.id]
  key_name = "key"
  user_data = "${file("Install_kubectl.sh")}"
  tags = {
    Name = "my-jump-server"
  }
  
}