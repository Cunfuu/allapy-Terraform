provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name        = "Project hepapi VPC"
    Environment = "Production"
  }
}

resource "aws_instance" "my_instance" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.my_subnet.id
  tags = {
    Name        = "Project hepapi Instance"
    Environment = "Production"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  tags = {
    Name        = "Project hepapi Subnet"
    Environment = "Production"
  }
}

resource "aws_security_group" "my_security_group" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name        = "Project hepapi Security Group"
    Environment = "Production"
  }
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "project-hepapi-bucket"
  tags = {
    Name        = "Project hepapi S3 Bucket"
    Environment = "Production"
  }
}


resource "aws_db_instance" "my_database" {
  engine           = "mysql"
  instance_class   = "db.t2.micro"
  allocated_storage = 20
  storage_type     = "gp2"
  username         = "admin"
  password         = "password"
  name             = "mydatabase"
  tags = {
    Name        = "Project hepapi Database"
    Environment = "Production"
  }
}

resource "aws_security_group" "database_sg" {
  name        = "database-sg"
  description = "Security group for the database"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "Project hepapi Database SG"
    Environment = "Production"
  }
}
