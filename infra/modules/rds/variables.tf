variable "identifier" {
  description = "Database identifier"
  type = string
}

variable "engine" {
  description = "Database engine"
  type = string
  default = "mysql"
}

variable "engine_version" {
  description = "Engine version"
  type = string
  default = "8.0"
}

variable "family" {
  description = "Family"
  type = string
  default = "mysql8.0"
}

variable "major_engine_version" {
  description = "Major engine version"
  type = string
  default = "8.0"
}

variable "instance_class" {
  description = "DB instance class"
  type = string
  default = "db.t2.micro"
}

variable "vpc_id" {
  description = "VPC Id"
  type = string
}

variable "database_subnet_group" {
  description = "Database subnet group"
  type = string
}

variable "vpc_cidr" {
  description = "VPC cidr"
  type = string
}