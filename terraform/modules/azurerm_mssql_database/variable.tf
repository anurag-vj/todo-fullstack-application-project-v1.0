variable "mssql_database_name" {
  type = string
}

variable "server_id" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
