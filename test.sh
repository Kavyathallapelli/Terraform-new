resource "aws_subnet" "public_subnet_1" {
 vpc_id              = aws_vpc.my_vpc.id
 cidr_block          = "10.0.1.0/24"
 availability_zone   = "us-east-2a"
 tags  = {
   Name = "public_subnet_1"
   Subnet-Type  = "public"
   }
}

resource "aws_subnet" "public_subnet_2" {
 vpc_id              = aws_vpc.my_vpc.id
 cidr_block          = "10.0.2.0/24"
 availability_zone   = "us-east-2b"
 tags  = {
   Name = "public_subnet_2"
   Subnet-Type  = "public"
   }
}



resource "aws_subnet" "private_subnet_1" {
 vpc_id              = aws_vpc.my_vpc.id
 cidr_block          = "10.0.3.0/24"
 availability_zone   = "us-east-2a"
 tags  = {
   Name = "private_subnet_1"
   Subnet-Type  = "private"
   }
}


resource "aws_subnet" "private_subnet_2" {
 vpc_id              = aws_vpc.my_vpc.id
 cidr_block          = "10.0.4.0/24"
 availability_zone   = "us-east-2b"
 tags  = {
   Name = "private_subnet_2"
   Subnet-Type  = "private"
   }
}


resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "IG"
  }
}


resource "aws_route_table" "public_route_table" {
  vpc_id  =  aws_vpc.my_vpc.id

    route {
cidr_block   =  "0.0.0.0/0"
     gateway_id   =  aws_internet_gateway.my_igw.id
   }

   tags = {
    Name  = "public route table"
}
}


resource "aws_route_table" "private_route_table" {
  vpc_id  =  aws_vpc.my_vpc.id

   tags = {
    Name  = "private route table"
}
}


resource "aws_route_table_association" "public_subnet_association_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}


resource "aws_route_table_association" "public_subnet_association_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_instance" "public_subnet_1" {
  ami           = ""
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet_1.id
  key_name      = ""
  tags = {
     Name = "PublicInstance"
  }
}
