variable "subscription_id" { type = string }
variable "tenant_id"       { type = string }

variable "location"   { type = string, default = "eastus" }
variable "name_prefix"{
  description = "Short, lowercase prefix"
  type        = string
  default     = "devopsdemo"
}
variable "kubernetes_version" { type = string, default = null }
variable "node_size"          { type = string, default = "Standard_DS2_v2" }
variable "node_count"         { type = number, default = 2 }
