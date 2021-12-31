###############
# CEN instance
###############
resource "alicloud_cen_instance" "this" {
  cen_instance_name = var.name
  description       = var.description
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
  for_each                 = var.instances_attachment
  instance_id              = alicloud_cen_instance.this.id
  child_instance_id        = each.value.vpc_id
  child_instance_region_id = each.value.vpc_region_id
  child_instance_owner_id  = each.value.vpc_owner_id != "" ? each.value.vpc_owner_id : null
  child_instance_type      = "VPC"
}
