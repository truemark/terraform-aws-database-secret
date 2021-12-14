variable "create" {
  description = "Set to false to turn off creation of this resource."
  type = bool
  default = true
}

variable "host" {
  description = "Host where database resides."
  type = string
}

variable "name" {
  description = "Name for the credentials."
  type = string
}

variable "port" {
  description = "Port to connect to database."
  type = string
}

variable "username" {
  description = "Optional username. If null, name is used as the username."
  type = string
  default = null
}

variable "dbname" {
  description = "Optional name of the database the credentials are for. If null, name is used."
  type = string
  default = null
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "password_length" {
  description = "Length of the password to generate."
  type = number
  default = 12
}

variable "connect_string" {
  description = "Optional connect string to connect to db."
  type = string
  default = null
}

variable "service_name" {
  description = "Optional service name to connect to db."
  type = string
  default = null
}
