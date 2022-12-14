
##################################################################################
# DATA
##################################################################################


data "aws_availability_zones" "available" {}
##################################################################################
# RESOURCES
##################################################################################




# NETWORKING #
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cider_block
  enable_dns_hostnames = var.vpc_enable_dns_hostname

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-vpc"
  })

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-igw"
  })

}

resource "aws_subnet" "subnet" {
  cidr_block              = var.vpc_subnet_cidr_block
  vpc_id                  = aws_vpc.vpc.id
  map_public_ip_on_launch = var.map_public_ip_on_launch
  availability_zone       = data.aws_availability_zones.available.names[0]

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-subnet"
  })
}


# ROUTING #
resource "aws_route_table" "rtb" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-rtb"
  })
}

resource "aws_route_table_association" "rta-subnets" {
  subnet_id      = aws_subnet.subnet.id
  route_table_id = aws_route_table.rtb.id
}


# SECURITY GROUPS #
# Nginx security group 
resource "aws_security_group" "nginx-sg" {
  name   = "${local.name_prefix}-nginx-sg"
  vpc_id = aws_vpc.vpc.id

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # # SSH access from anywhere
  # ingress {
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.common_tags
}


