resource "aws_instance" "bastion" {
  ami           = "ami-026669ec456129a70"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.sub1.id
  vpc_security_group_ids = [aws_security_group.bastion.id]
  key_name = aws_key_pair.demo.key_name
  tags = {
    Name = "BASTION"
    Environment = "stage"
  }
}
resource "aws_instance" "app1" {
  ami           = "ami-026669ec456129a70"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.sub2.id
  vpc_security_group_ids = [aws_security_group.app.id]
  key_name = aws_key_pair.demo.key_name
  user_data = file("app.sh")
  tags = {
    Name = "APP1"
    Environment = "stage"
  }
}
resource "aws_instance" "app2" {
  ami           = "ami-026669ec456129a70"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.sub4.id
  vpc_security_group_ids = [aws_security_group.app.id]
  key_name = aws_key_pair.demo.key_name
  user_data = file("app.sh")
  tags = {
    Name = "APP2"
    Environment = "stage"
