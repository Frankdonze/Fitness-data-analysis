##############################
#S3 configuration
##############################

resource "aws_s3_bucket" "s3-data" {
	bucket = "bron-silv-data"
}

##############################
#Network configuration
##############################


resource "aws_vpc" "dataprj" {
        cidr_block = "10.20.0.0/16"

	tags = {
		Name = "dataprj-vpc"
	}
}

resource "aws_subnet" "dataprj-public-sub" {
	vpc_id = aws_vpc.dataprj.id
	cidr_block = "10.20.1.0/24"
	map_public_ip_on_launch = true	
	
	tags = {
		Name = "dataprj-vpc-pubsub"
	}

}

resource "aws_internet_gateway" "igw-dataprj" {
	vpc_id = aws_vpc.dataprj.id
}

####       Route table and  Routes         #####
data "aws_route_table" "dataprj-vpc-rt" {
	vpc_id = aws_vpc.dataprj.id
}

resource "aws_route" "internet-access" {
		route_table_id = data.aws_route_table.dataprj-vpc-rt.id
		destination_cidr_block = "0.0.0.0/0"
		gateway_id = aws_internet_gateway.igw-dataprj.id
}

###############################
#Security Groups
###############################

resource "aws_security_group" "allow-ssh" {
	name = "allow-ssh-sg"
	description = "Allow SSH to connect to Instances"
	vpc_id = aws_vpc.dataprj.id

	ingress {
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}

	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}



}

###############################
#Compute configuration
###############################
resource "aws_instance" "cloudworkspace" {
	ami = "ami-0ecb62995f68bb549"
	instance_type = "t2.micro"
	key_name = "keypair"
	subnet_id = aws_subnet.dataprj-public-sub.id

	vpc_security_group_ids = [
		aws_security_group.allow-ssh.id
	]

	tags = {
		Name = "cloudworkspace"
	}

}
