variable "zones_map" {
  description = "Map of Route53 zone parameters"
  type        = any
  default     = {}
}

variable "tags" {
  description = "Tags added to all zones. Will take precedence over tags from the 'zones' variable"
  type        = map(any)
  default     = {}
}