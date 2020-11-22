resource "aws_key_pair" "demo" {
  key_name   = "demo_class_key"
  public_key = file("demo_class_key.pub")
}
