module "main-vpc" {
  source                  = "github.com/alex-berbeha/terraform-modules.git/AWS/modules/VPC"
  vpc_tags                = {
      Name = "temy-vpc"
  }

  vpc_cidr = var.main_vpc_cidr
}