variable "region"{
  default = "ap-south-1"
}
variable "vpc_cidr" {
  default = "10.0.0.0/24"
}
variable "sub1_cidr" {
  default = "10.0.0.0/26"
}
variable "sub2_cidr" {
  default = "10.0.0.64/26"
}
variable "sub3_cidr" {
  default = "10.0.0.128/26"
}
variable "sub4_cidr" {
  default = "10.0.0.192/26"
}
variable "env" {
  default = "stage"
}
