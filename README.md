# Alicloud CEN Terraform Module On Alibaba Cloud terraform-alicloud-cen-instance

Terraform module which creates CEN instance, attach child instance to it and publish a specified route of the child instance on Alibaba Cloud.

These types of resources are supported:

- [instance](https://github.com/terraform-providers/terraform-provider-alicloud/blob/master/website/docs/r/cen_instance.html.markdown)
- [instance attachment](https://github.com/terraform-providers/terraform-provider-alicloud/blob/master/website/docs/r/cen_instance_attachment.html.markdown)
- [cen_route entry](https://github.com/terraform-providers/terraform-provider-alicloud/blob/master/website/docs/r/cen_route_entry.html.markdown)


## Usage

You can use this in your terraform template with the following steps.

1. Adding a module resource to your template, e.g. main.tf

   ```
   module "cen_instance" {
      source = "terraform-alicloud-modules/cen-instance/alicloud"
   
      name                     = "cen-instance-name"
      description = "cen-example"
      instances_attachment = [
        {
          "vpc_id": "vpc-abc123",
          "vpc_name": "my-prod",
          "vpc_owner_id": "123456",
          "vpc_region_id": "cn-shanghai"
        }
      ]
   }
   ```

2. Setting `access_key` and `secret_key` values through environment variables:

   - ALICLOUD_ACCESS_KEY
   - ALICLOUD_SECRET_KEY
   - ALICLOUD_REGION

# Input

| Name                     | Description                                               | Type   | Default                     | Required |
| :----------------------- | :-------------------------------------------------------- | ------ | --------------------------- | -------- |
| name                     | Name of the CEN instance                                  | string | null                        | yes      |
| description              | The description of the CEN instance.                      | string | null                        | no       |
| new_instance             | Whether to create a CEN instance.                         | int    | 1                           | no       |
| instance_id              | The ID of the CEN instance to attach.                     | string | null                        | no       |
| child_instance_id        | The ID of the child instance.                             | string | null                        | yes      |
| child_instance_region_id | The region ID of the child instance                       | string | null                        | yes      |
| attach_instance          | Whether to attach the child instance to one cen instance. | boolean| false                       | no       |
| route_table_id           | The route table of the attached VBR or VPC.               | string | null                        | yes      |
| cidr_block               | The destination CIDR block of the route entry to publish. | string | null                        | yes      |
| publish_route_entry      | Whether to publish the route entry to the cen.            | boolean| false                       | no       |
~>**Note:** If set instance_id with new_instance true, the cen_instance_attachment module and cen_route_entry module will use the instance_id you specified. Otherwise, the instance_id created by module cen_instance will be used.


## Output

| Name                   | Description                  |
| ---------------------- | ---------------------------- |
| this_instance_id       | The ID of CEN instance       |
| this_child_instance_id | The ID of CEN child instance |
| this_route_table_id | The route table of the attached VBR or VPC.               |
| this_cidr_block     | The destination CIDR block of the route entry to publish. |

## Notes
From the version v1.2.0, the module has removed the following `provider` setting:

```hcl
provider "alicloud" {
   version              = ">=1.80.0"
   region               = var.region != "" ? var.region : null
   configuration_source = "terraform-alicloud-modules/cen-instance"
}
```

If you still want to use the `provider` setting to apply this module, you can specify a supported version, like 1.1.0:

```hcl
module "cen_instance" {
   source      = "terraform-alicloud-modules/cen-instance/alicloud"
   version     = "1.1.0"
   region      = "cn-beijing"
   name        = "cen-instance-name"
   description = "cen-example"
   // ...
}
```

If you want to upgrade the module to 1.2.0 or higher in-place, you can define a provider which same region with
previous region:

```hcl
provider "alicloud" {
   region = "cn-beijing"
}
module "cen_instance" {
   source      = "terraform-alicloud-modules/cen-instance/alicloud"
   name        = "cen-instance-name"
   description = "cen-example"
   // ...
}
```
or specify an alias provider with a defined region to the module using `providers`:

```hcl
provider "alicloud" {
   region = "cn-beijing"
   alias  = "bj"
}
module "cen_instance" {
   source      = "terraform-alicloud-modules/cen-instance/alicloud"
   providers   = {
      alicloud = alicloud.bj
   }
   name        = "cen-instance-name"
   description = "cen-example"
   // ...
}
```

and then run `terraform init` and `terraform apply` to make the defined provider effect to the existing module state.

More details see [How to use provider in the module](https://www.terraform.io/docs/language/modules/develop/providers.html#passing-providers-explicitly)

## Terraform versions

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.80.0 |

Authors
-------
Created and maintained by Alibaba Cloud Terraform Team(terraform@alibabacloud.com)

License
----
Apache 2 Licensed. See LICENSE for full details.
Reference
---------
* [Terraform-Provider-Alicloud Github](https://github.com/terraform-providers/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://www.terraform.io/docs/providers/alicloud/index.html)