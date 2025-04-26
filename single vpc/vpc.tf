resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "myvpc"
  }
}

resource "aws_subnet" "private_subnet" {
  count      = length(var.private_subnet_cidrs)
  cidr_block = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
  vpc_id     = aws_vpc.myvpc.id
  tags = {
    Name = "private_subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "public_subnet" {
  count      = length(var.public_subnet_cidrs)
  cidr_block = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)
  vpc_id     = aws_vpc.myvpc.id
  tags = {
    Name = "public_subnet-${count.index + 1}"
  }
}

resource "aws_internet_gateway" "myvpc-gw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "myvpc-gw"
  }
}

resource "aws_nat_gateway" "mynat-gw" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = element(aws_subnet.public_subnet[*].id, 0)
}

resource "aws_eip" "nat-eip" {
  depends_on = [aws_internet_gateway.myvpc-gw]
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.myvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.myvpc-gw.id
    }
    tags = {
    Name = "Public RT Table"
    }
}

resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.myvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.mynat-gw.id
    }
    tags = {
    Name = "Private RT Table"
    }
}

resource "aws_route_table_association" "public_subnet_association" {
    count = length(var.public_subnet_cidrs)
    subnet_id = element(aws_subnet.public_subnet[*].id, count.index)
    route_table_id = aws_route_table.public_rt.id
  
}

resource "aws_route_table_association" "private_subnet_association" {
    count = length(var.private_subnet_cidrs)
    subnet_id = element(aws_subnet.private_subnet[*].id, count.index)
    route_table_id = aws_route_table.private_rt.id
  
}