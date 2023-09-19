variable "access_grant" {
  type        = string
  sensitive   = true
  description = "The root access grant that we should derive the new access grant from."
}

variable "allow_delete" {
  type        = bool
  default     = false
  description = "Allow deletes to occur when using the derived grant."
}

variable "allow_download" {
  type        = bool
  default     = false
  description = "Allow downloads to occur when using the derived grant."
}

variable "allow_list" {
  type        = bool
  default     = false
  description = "Allow list operations to occur when using the derived grant."
}

variable "allow_upload" {
  type        = bool
  default     = false
  description = "Allow uploads to occur when using the derived grant."
}

variable "bucket" {
  type = set(object({
    name  = string
    paths = set(string)
  }))
  description = "The list of buckets and associated prefixes the derived access grant should allow access to."
}
