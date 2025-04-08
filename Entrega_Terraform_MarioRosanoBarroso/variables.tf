variable "mariadb_root_password" {
  description = "La contraseña del usuario root de MariaDB"
  type        = string
}

variable "mariadb_db_name" {
  description = "El nombre de la base de datos para WordPress"
  type        = string
  default     = "wordpress_db"
}

variable "mariadb_user" {
  description = "El nombre de usuario para MariaDB"
  type        = string
  default     = "wordpress_user"
}

variable "mariadb_user_password" {
  description = "La contraseña del usuario de la base de datos"
  type        = string
}
