terraform {
  required_providers {
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
      version = "1.5.0"
    }
  }
}

provider "mongodbatlas" {
  # Configuration options
}

