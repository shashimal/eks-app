variable "app_name" {
  description = "Application name"
  type = string
}

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
}

variable "cors_rule" {
  description = "List of maps containing rules for Cross-Origin Resource Sharing for S3 bucket."
  type        = any
  default     = {
    cors_rule = {
      allowed_headers = ["*"]
      allowed_methods = ["PUT", "POST", "GET", "DELETE"]
      allowed_origins = ["*"]
      expose_headers  = ["ETag"]
      max_age_seconds = 3000
    }
  }
}

variable "control_object_ownership" {
  description = "Whether to manage S3 Bucket Ownership Controls on this bucket."
  type        = bool
  default     = true
}

variable "object_ownership" {
  description = "Object ownership. Valid values: BucketOwnerEnforced, BucketOwnerPreferred or ObjectWriter. 'BucketOwnerEnforced': ACLs are disabled, and the bucket owner automatically owns and has full control over every object in the bucket. 'BucketOwnerPreferred': Objects uploaded to the bucket change ownership to the bucket owner if the objects are uploaded with the bucket-owner-full-control canned ACL. 'ObjectWriter': The uploading account will own the object if the object is uploaded with the bucket-owner-full-control canned ACL."
  type        = string
  default     = "BucketOwnerEnforced"
}

variable "website" {
  description = "Map containing static web-site hosting or redirect configuration."
  type        = any # map(string)
  default     = {}
}

#ACM

variable "domain_name" {
  description = "Domain name"
  type        = string
}

variable "zone_id" {
  description = "Zone Id"
  type        = string
}

variable "subject_alternative_names" {
  description = "Subject alternative names"
  type        = list(string)
}

variable "wait_for_validation" {
  description = "Wait for validation"
  type        = bool
  default     = false
}

variable "create_certificate" {
  description = "Whether you need to create ACM certificate"
  type = bool
  default = false
}

variable "create_route53_records" {
  description = "Whether you want to create route53 records"
  type = bool
  default = false
}

variable "aliases" {
  description = "Other domain names"
  type = list(string)
  default = []
}

variable "tags" {
  description = "Tags"
  type        = any
  default     = {}
}