module "main-vpc" {
  source = "github.com/alex-berbeha/terraform-modules.git/AWS/modules/VPC"
  vpc_tags = {
    Name = "temy-vpc"
  }
  vpc_cidr = var.main_vpc_cidr
  igw_tags = {
    Name = "temy-vpc-IGW"
  }
}

module "public-subnet" {
  source            = "github.com/alex-berbeha/terraform-modules.git/AWS/modules/subnet"
  main_vpc          = module.main-vpc.VPC_id
  subnet_cidr       = var.public_subnet_cidr
  availability_zone = "${var.region}a"
  subnet_tags = {
    Name = "public-subnet"
  }
}

resource "aws_route_table" "public_RT" {
  vpc_id = module.main-vpc.VPC_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = module.main-vpc.igw_id
  }

  tags = {
    Name = "public-subnet-RT"
  }
}

resource "aws_route_table_association" "public_subnet" {
  route_table_id = aws_route_table.public_RT.id
  subnet_id      = module.public-subnet.subnet_id
}

module "security_groups" {
  source               = "github.com/alex-berbeha/terraform-modules.git/AWS/modules/security_groups"
  sg_name              = "allow ssh and http ingress"
  vpc_id               = module.main-vpc.VPC_id
  ingress_allows_ports = [22, 80]
  protocol             = "tcp"
  cidr_list            = ["0.0.0.0/0"]
  sg_tags = {
    Name = "allow ssh and http ingress"
  }

}

resource "aws_eip" "eip" {
  vpc = true
}