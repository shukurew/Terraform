provider "aws" {
    region = "eu-west-3"
    access_key = "AKIA33YOQVV5ORIOPCNH"
    secret_key = "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"

}

variable "subnet_cidr_block"{
    description = "subnet cidr block"
    default = "10.0.10.0/24"
    type = string
}

variable "vpc_cidr_block"{
    description = "vpc cidr block"
}


variable "environment"{
    description = "deployment enviroment"
}


resource "aws_vpc" "development-vpc"{
    cidr_block = var.vpc_cidr_block
    # "10.0.0.0/16"
    tags = {
        Name: var.environment,
        vpc_env: "dev"
      
}   

}

resource "aws_subnet" "dev-subnet-1"{
    vpc_id = aws_vpc.development-vpc.id
    cidr_block = var.subnet_cidr_block
     tags = { 
         name: "development_subnet"
      
}
}

data "aws_vpc" "existing_vpc"{
    default = true
    

}

resource "aws_subnet" "dev-subnet-2"{
    vpc_id = data.aws_vpc.existing_vpc.id
    cidr_block = "172.31.128.0/20"
    availability_zone = "eu-west-3a"
    tags = { 
        Name: "development_subnet2"
      
}
}

output "dev-vpc-id" {
    value = aws_vpc.development-vpc.id
}

output "dev-subnet-id" {
    value = aws_subnet.dev-subnet-2.id
}
