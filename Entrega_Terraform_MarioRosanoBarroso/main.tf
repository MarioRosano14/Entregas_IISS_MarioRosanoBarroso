terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {
  host = "npipe:////./pipe/docker_engine"
}

# Definir la red Docker
resource "docker_network" "wordpress_network" {
  name = "wordpress_network"
}

# Volumen persistente para MariaDB
resource "docker_volume" "mariadb_data" {
  name = "mariadb_data"
}

# Contenedor de MariaDB
resource "docker_container" "mariadb" {
  name  = "mariadb"
  image = "mariadb:latest"
  env   = [
    "MYSQL_ROOT_PASSWORD=${var.mariadb_root_password}",
    "MYSQL_DATABASE=${var.mariadb_db_name}",
    "MYSQL_USER=${var.mariadb_user}",
    "MYSQL_PASSWORD=${var.mariadb_user_password}"
  ]
  networks_advanced {
    name = docker_network.wordpress_network.name
  }
  volumes {
    volume_name = docker_volume.mariadb_data.name
    container_path = "/var/lib/mysql"
  }
  restart = "always"
}

# Contenedor de WordPress
resource "docker_container" "wordpress" {
  name  = "wordpress"
  image = "wordpress:latest"
  env   = [
    "WORDPRESS_DB_HOST=${docker_container.mariadb.name}:3306",
    "WORDPRESS_DB_NAME=${var.mariadb_db_name}",
    "WORDPRESS_DB_USER=${var.mariadb_user}",
    "WORDPRESS_DB_PASSWORD=${var.mariadb_user_password}"
  ]
  networks_advanced {
    name = docker_network.wordpress_network.name
  }
  ports {
    internal = 80
    external = 8080
  }
  restart = "always"
}
