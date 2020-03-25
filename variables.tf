variable "automation_key" {}
variable "enrollment_token" {}
variable "sas_token" {}
variable "buildticket" {}
variable "ad_password" {}
 
 variable "vm_names" {
  description = "Create IAM users with these names"
  type        = list(string)
  default     = ["TESTAPP06G", "TESTAPP07G", "TESTAPP08G", "TESTAPP09G"]
}
 
variable "location" {
  description = "Region to build into"
  default     = "East US 2"
}
