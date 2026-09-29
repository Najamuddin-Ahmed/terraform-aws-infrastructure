# create a variable for the AMI ID
variable "ubuntu_ami" {
  description = "The AMI ID for Ubuntu"
  type        = string
  default     = "ami-0f8a61b66d1accaee" # Example AMI ID, replace with a valid one for your region
}

# create a instance type variable
variable "instance_type" {
  description = "The type of instance to use"
  type        = string
  default     = "t3.micro"
}
# create a name variable for the instance
variable "instance_name" {
  description = "The name of the instance"
  type        = string
  default     = "test-instance"
}