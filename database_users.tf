########################################
### RANDOM PASSWORD FOR DATABASE USERS
########################################
resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "_%!+"
}

resource "mongodbatlas_database_user" "user" {
  for_each           = local.db_users_flat
  username           = each.value.username
  password           = random_password.password.result
  project_id         = mongodbatlas_project.project.id
  auth_database_name = "admin"
  dynamic "roles" {
    for_each = range(length(each.value.cluster.db_name))
    content {
      database_name = each.value.cluster.db_name[roles.key]
      role_name     = each.value.cluster.db_role[roles.key]
    }
  }
  dynamic "scopes" {
    for_each = range(length(each.value.cluster.db_type))
    content {
      name = each.value.clustername
      type = each.value.cluster.db_type[scopes.key]
    }
  }
}