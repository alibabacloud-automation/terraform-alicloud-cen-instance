# ----------------------------------------------------------------------------------------------------------------------
# REQUIRE A SPECIFIC TERRAFORM VERSION OR HIGHER
# This module has been updated with 0.12 syntax, which means it is no longer compatible with any versions below 0.12.
# ----------------------------------------------------------------------------------------------------------------------
terraform {
  required_version = ">= 0.12"
}

provider "alicloud" {
  version              = ">=1.80.0"
  region               = var.region != "" ? var.region : null
  configuration_source = "terraform-alicloud-modules/cen-instance"
}

###############
# CEN instance
###############
resource "alicloud_cen_instance" "this" {
  name        = var.name
  description = var.description
  tags = merge(
    {
      "Name" = format("%s", var.name)
    },
    var.tags,
    var.cen_tags,
  )
}

###############
# CEN attachments
###############
resource "alicloud_cen_instance_attachment" "this" {

  for_each                 = { for i, this in var.instances_attachment : i=> this }
  instance_id              = alicloud_cen_instance.this.id
  child_instance_id        = each.value.vpc_id
  child_instance_region_id = each.value.vpc_region_id
  child_instance_owner_id  = each.value.vpc_owner_id != "" ? each.value.vpc_owner_id : null
  child_instance_type      = each.value.vpc_network_type
}
