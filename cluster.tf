####################3###################################
### MONGODB ATLAS CLUSTER IN THE PROJECT
####################3###################################

resource "mongodbatlas_cluster" "cluster" {
  project_id                   = mongodbatlas_project.project.id
  name                         = var.cluster_name
  provider_name                = var.instance_type == "M0" ? "TENANT" : local.cloud_provider
  backing_provider_name        = var.instance_type == "M0" ? "AWS" : ""
  provider_region_name         = var.region
  provider_instance_size_name  = var.instance_type
  mongo_db_major_version       = var.mongodb_major_ver
  cluster_type                 = var.cluster_type
  num_shards                   = var.instance_type == "M0" ? 1 : var.num_shards
  cloud_backup                 = var.cloud_backup
  pit_enabled                  = var.pit_enabled
  disk_size_gb                 = var.instance_type == "M0" ? null : var.disk_size_gb
  auto_scaling_disk_gb_enabled = var.instance_type == "M0" ? false : var.auto_scaling_disk_gb_enabled
  provider_volume_type         = var.instance_type == "M0" ? "" : var.volume_type
  provider_disk_iops           = var.volume_type == "STANDARD" ? null : var.provider_disk_iops
}