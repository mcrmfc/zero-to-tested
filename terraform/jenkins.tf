# ===========
# CREDENTIALS
# ===========
provider "aws" {
    access_key  = "${var.access_key}"
    secret_key  = "${var.secret_key}"
    region      = "eu-west-1"
}

# =====================
# CREATE VPC AND SUBNET
# =====================
resource "aws_vpc" "main" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
}

resource "aws_internet_gateway" "gw" {
    vpc_id = "${aws_vpc.main.id}"

    tags {
        Name = "main"
    }
}

resource "aws_route_table" "routes" {
    vpc_id = "${aws_vpc.main.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.gw.id}"
    }

    tags {
        Name = "main"
    }
}

resource "aws_route_table_association" "rta" {
    subnet_id = "${aws_subnet.main.id}"
    route_table_id = "${aws_route_table.routes.id}"
}

resource "aws_subnet" "main" {
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    tags {
        Name = "Main"
    }
}

# =======================
# CREATE JENKINS INSTANCE
# =======================
resource "aws_instance" "jenkins" {
    ami = "ami-e19f0b92"
    instance_type = "t1.micro"
    subnet_id = "${aws_subnet.main.id}"
    private_ip = "10.0.1.100"
    security_groups = ["${aws_security_group.jenkins_rules.id}"]
}

# =============================
# SECURITY GROUPS AND IAM ROLES
# =============================
resource "aws_security_group" "jenkins_rules" {
  name = "jenkins_public"
  description = "Allow all inbound traffic to Jenkins 8080"
  vpc_id = "${aws_vpc.main.id}"

  ingress {
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  # http
  egress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  # https
  egress {
      from_port = 443
      to_port = 443
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  # gpg
  egress {
      from_port = 11371
      to_port = 11371
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
}
