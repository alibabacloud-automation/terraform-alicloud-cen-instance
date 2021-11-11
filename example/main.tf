module "cen" {
  source       = "../"
  name         = "cen-instance-name"
  description = "cen-example"

  instances_attachment = [
        {
          "vpc_id": "vpc-uf6aobl3quw6i4gm0y514",
          "vpc_name": "tf_test_foo1",
          "vpc_owner_id": "123456",
          "vpc_region_id": "cn-shanghai",
          "vpc_network_type": "VPC"
        },
        {
          "vpc_id": "vpc-uf6055dryqesgbzstrvbr",
          "vpc_name": "tf_test_foo2",
          "vpc_owner_id": "098765",
          "vpc_region_id": "cn-shanghai",
          "vpc_network_type": "VPC"
        }
  ]



}

