data "alicloud_account" "default" {
}

data "alicloud_vpcs" "default" {
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "172.16.0.0/12"
}

module "cen" {
  source      = "../.."
  name        = var.name
  description = var.description
  tags        = var.tags
  cen_tags    = var.cen_tags

  instances_attachment = {
    "cen" = {
      "vpc_id" : alicloud_vpc.default.id
      "vpc_name" : alicloud_vpc.default.name
      "vpc_owner_id" : data.alicloud_account.default.id
      "vpc_region_id" : data.alicloud_vpcs.default.vpcs.0.region_id
    }
  }

}
