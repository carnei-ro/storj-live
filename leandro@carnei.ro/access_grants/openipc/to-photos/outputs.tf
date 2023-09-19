output "id" {
  value = storj_access_grant.this.id
}

output "derived_access_grant" {
  value     = storj_access_grant.this.derived_access_grant
  sensitive = true
}
