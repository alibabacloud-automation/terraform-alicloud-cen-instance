variable "name" {
  description = "Name of the CEN instance"
  type        = string
  default     = "cen-instance-name"
}

variable "description" {
  description = "The description of the CEN instance"
  type        = string
  default     = "cen-example"
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default = {
    test_tags = "tags"
  }
}

variable "cen_tags" {
  description = "A map of tags to add to the CEN"
  type        = map(string)
  default = {
    cen_test_tags = "cen_tags"
  }

}