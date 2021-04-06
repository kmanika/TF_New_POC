variable "test_subnet_id" {
  type = string
  default = "subnet-0a643fcb0ff87897a"
}
variable "Cred_file" {
  type = string
  default = "/Users/mani/.aws/credentials"
}
variable "SG_Group" {
  type = string
  default = "sg-079eafc4ccd59760e"
}
variable "user_data_file" {
  type = string
  default = "/Users/mani/Downloads/TF_POC/userdata.sh"
}
variable "SNS_Name" {
  type = string
  default = "EC2-Alarm"
}
variable "AMI_ID" {
  type = string
  default = "ami-0742b4e673072066f"
}
variable "Inst_Type" {
  type = string
  default = "t2.micro"
}
variable "Role_Name" {
  type = string
  default = "CWRole-LinuxLog"
}
variable "Key_details" {
  type = string
  default = "demo_Keys"
}
variable "DD_API_Key" {
  type = string
  default = "539dffcf4d8c1a2f9957082485cc6aa0"
}
variable "DD_APP_Key" {
  type = string
  default = "d1160c7c5a3aecaa4159a1e35f7a344f9ea1db16"
}
variable "DD_Host" {
  type = string
  default = "i-09f4177bb1bc0d41d"
}
variable "DD_query" {
  type = string
  default = "sum:system.cpu.user{*}"
}