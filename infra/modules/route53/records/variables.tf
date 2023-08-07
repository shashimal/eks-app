variable "zone_name" {
  description = "Zone name"
  type = string
  default = null
}
variable "records" {
  description = "Route53 records"
  type = any
  default = []
}