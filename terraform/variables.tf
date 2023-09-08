variable "project" {
  type        = string
  description = "GCP project ID"
}

variable "region" {
  type        = string
  description = "The main region where the resources are created"
}

variable "todo_app_name" {
  type        = string
  description = "name of the todo app"
}

variable "todo_app_image" {
  type        = string
  description = "URL of the Container image in docker hub that hosts the todo app image"
}

variable "service_run" {
  type        = string
  description = "Name of the Service"
}

variable "role" {
  type        = string
  description = "The role that should be applied"
}