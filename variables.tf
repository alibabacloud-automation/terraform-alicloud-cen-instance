variable "region" {
  description = "(Deprecated from version 1.2.0) The region used to launch this module resources."
  default     = ""
}

variable "name" {
  description = "Name of the CEN instance"
}

variable "description" {
  description = "The description of the CEN instance"
  default     = "TF"
}

variable "create_cen" {
  description = "Controls if CEN should be created"
  type        = bool
  default     = true
}

// Tags
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "cen_tags" {
  description = "Additional tags for the CEN"
  type        = map(string)
  default     = {}
}

# VPCs created in an account different from the CEN instance must have the vpc_owner_id specified
# The vpc_owner_id is only needed when a VPC is in a different Alicloud account than the CEN
variable "instances_attachment" {
  description = "Map of VPCs to grant access to the Alibaba account which hosts the CEN"
  type        = map(object({ vpc_id = string, vpc_region_id = string, vpc_owner_id = string }))
  default     = {}
}