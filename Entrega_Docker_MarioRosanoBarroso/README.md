# Explicación de las configuraciones Docker-Compose

## Parte 1: Drupal + MySQL

Este `docker-compose.yml` define dos servicios: `mysql` y `drupal`, permitiendo la ejecución de un sitio Drupal con una base de datos MySQL.

### Configuración de `mysql`
- Usa la imagen `mysql:latest`.
- Define credenciales de acceso con variables de entorno (`MYSQL_ROOT_PASSWORD`, `MYSQL_DATABASE`, `MYSQL_USER`, `MYSQL_PASSWORD`).
- Almacena los datos en un volumen `mysql_data` para persistencia.
- Conectado a la red `parte1_net`.

### Configuración de `drupal`
- Usa la imagen `drupal:latest`.
- Expone el servicio en el puerto `81` (mapeando al puerto 80 del contenedor).
- Depende de `mysql` para asegurar que la base de datos esté lista antes de iniciar.
- Usa un volumen `drupal_data` para persistir los archivos de Drupal.
- Se conecta a la red `parte1_net`.

---

## Parte 2: WordPress + MariaDB

Este `docker-compose.yml` define dos servicios: `mariadb` y `wordpress`, permitiendo la ejecución de un sitio WordPress con una base de datos MariaDB.

### Configuración de `mariadb`
- Usa la imagen `mariadb:latest`.
- Define credenciales de acceso con las mismas variables de entorno que MySQL (MariaDB es compatible).
- Almacena los datos en un volumen `mariadb_data` para persistencia.
- Conectado a la red `parte2_net`.

### Configuración de `wordpress`
- Usa la imagen `wordpress:latest`.
- Expone el servicio en el puerto `82` (mapeando al puerto 80 del contenedor).
- Depende de `mariadb` para asegurarse de que la base de datos esté disponible.
- Define variables de entorno para conectar con la base de datos (`WORDPRESS_DB_HOST`, `WORDPRESS_DB_USER`, etc.).
- Usa un volumen `wordpress_data` para persistir archivos de WordPress.
- Conectado a la red `parte2_net`.

---

Ambos archivos `docker-compose.yml` permiten levantar entornos completos para CMS con bases de datos, asegurando persistencia de datos y redes aisladas para cada aplicación.

