resource "storj_access_grant" "this" {
  access_grant   = var.access_grant
  allow_delete   = var.allow_delete
  allow_download = var.allow_download
  allow_list     = var.allow_list
  allow_upload   = var.allow_upload

  dynamic "bucket" {
    for_each = var.bucket
    content {
      name  = bucket.value.name
      paths = bucket.value.paths
    }
  }
}
