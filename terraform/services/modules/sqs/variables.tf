variable "sqs_queue" {
  type = map(object({
    name                       = string
    delay_seconds              = number
    max_message_size           = number
    message_retention_seconds  = number
    receive_wait_time_seconds  = number
    visibility_timeout_seconds = number
  }))
  default = {}
}

variable "name_prefix" {
  type    = string
  default = null
}

variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = {}
}