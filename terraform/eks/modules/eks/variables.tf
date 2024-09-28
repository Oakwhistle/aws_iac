variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "vpc_subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}

variable "vpc_name" {
  description = "Name of the VPC where the EKS cluster will be deployed"
  type        = string
}

variable "node_group_name" {
  description = "Name of the node group"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the node group"
  type        = string
}

variable "node_count" {
  description = "Number of nodes in the node group"
  type        = number
}

variable "max_capacity" {
  description = "Maximum capacity for the node group"
  type        = number
}

variable "min_capacity" {
  description = "Minimum capacity for the node group"
  type        = number
}

variable "strategy" {
  description = "Strategy for the node group (e.g., spot, on_demand, mixed)"
  type        = string
}


variable "visibility" {
  description = "Cluster visibility, either public or private"
  type        = string
}

variable "cluster_mode" {
  description = "Cluster mode, e.g., BOTH, PUBLIC, PRIVATE"
  type        = string
}

variable "alb_listener_http" {
  description = "HTTP Listener configuration for ALB"
  type = object({
    port     = number
    protocol = string
  })
}

variable "alb_target_group" {
  description = "Target Group configuration for ALB"
  type = object({
    port     = number
    protocol = string
    vpc_id   = string
  })
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
}
