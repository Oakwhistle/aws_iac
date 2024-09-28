variable "subnet_ids" {
  type = map(string)
  default = {}
} 

variable "name_prefix" {
  type    = string
  default = null
}

variable "tags" {
  type = map(string)
  default = {}
}