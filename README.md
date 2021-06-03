# Plataforma de datos ITP: Deploy

## Descripción

El presente repositorio tiene como objetivo recopilar los archivos y configuraciones requeridas para el completo proceso de deploy del sitio ITP Producción, desarrollado por ITP y Datawheel, en los servidores institucionales correspondientes, lo que permitirá al equipo reconstruir el sitio por completo, en caso de ser necesario.

## Estructura del Repositorio

El repositorio actual se encuentra estructurado de la siguiente forma:

### roles/

Recopilación de operaciones a ejecutar durante el proceso de deploy. Cada subcarpeta contenida en el directorio roles corresponde a la serie de comandos y configuraciones que son aplicadas durante el proceso de deploy, cuyo resultado es un sitio completamente operativo y funcional en los servidores indicados. Entre las principales operaciones incluidas se encuentra la configuración de las bases de datos a utilizar (PostgreSQL y Clickhouse), la instalación de dependencias requeridas, la ejecución de los pipelines de ingestión, la configuración de la base de datos de CMS, entre otros procesos.

### vars/

Recopilación de las variables a ser utilizadas en los múltiples roles a ejecutar durante el proceso de deploy del sitio. Cada archivo corresponde a las variables requeridas por cada servidor a configurar, en este caso, un archivo de configuración para un servidor de backend y un archivo de configuración para un servidor de frontend.

### .gitignore

Archivo git que permite establecer rutas de archivos o extensiones de archivos no deseadas, las cuales son excluidas del proceso de gestión de cambios dentro del repositorio.

### deploy-prod.yaml

Archivo de ejecución del proceso de deploy. Dentro de este archivo es posible encontrar cada servidor a configurar y los roles a ejecutar en cada servidor. Al modificar este archivo, se pueden modificar las tareas a realizar en cada configuración de servidor.

### hosts

Archivo de configuración de servidores a ser configurados.

### requirements.yml

Archivo de requerimientos necesarios para la ejecución del script de deploy.

## Setup

El presente script desarrollado responde a la configuración de un servidor de backend y frontend de especificaciones mínimas según lo establecido en las siguientes tablas. Cualquier configuración de especificaciones por debajo de lo recomendado puede resultar en inestabilidad en el servicio en instancias de producción.

### Especificaciones mínimas del servidor backend

| Propiedad              | Requisitos Mínimos     |
| ---------------------- |------------------------|
| Distribución           | Ubuntu 20.04 (LTS) x64 |
| Memoria RAM            | 64 GBs                 |
| CPU                    | 16 CPUs                |
| Disco Duro             | 100 GBs SSD            |

### Especificaciones mínimas del servidor frontend

| Propiedad              | Requisitos Mínimos     |
| ---------------------- |------------------------|
| Distribución           | Ubuntu 20.04 (LTS) x64 |
| Memoria RAM            | 32 GBs                 |
| CPU                    | 8 CPUs                 |
| Disco Duro             | 100 GBs SSD            |

## Ansible
[Ansible](https://www.ansible.com/) es un motor de automatización de IT que automatiza el aprovisionamiento en la nube, la administración, la implementación de aplicaciones y muchas otras necesidades que son frecuentemente requeridas durante el proceso de deployment en un servidor. Posee la virtud de que divide la instalación total de librerias y ejecuciónes de scripts (playbook) en distintas tareas (tasks), las cuales son ejecutadas cada una con un fin especifico, pudiendo ser reutilizadas para diferentes servidores y/o descargadas desde internet desde [ansible galaxy](https://galaxy.ansible.com/).

Para el sitio ITP Producción se ha automatizado las instalación de dependencias claves para el funcionamiento del proyecto, la implementación de scripts de ingestión de datos y creación de builds para el frontend a través de la aplicación de Ansible, cuya configuración y requerimientos se encuentran ya configurados en el presente repositorio.

### Instalando los paquetes necesarios

Ansible posee una [documentacion](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) bastante extensa para la instalación de la libreria en variados sistemas operativos. Recomendamos seguir la guía correspondiente a su sistema operativo para evitar problemas de instalación.

### Descarga de Archivos Privados

Previo a la ejecución del script de ansible, es necesario descargar los archivos requeridos, los cuales se encuentran actualmente en el archivo [files.zip](https://drive.google.com/file/d/1N5NrkH8uZy3f93u0BfyB8XtChglePr6I/view?usp=sharing). Estos archivos poseen configuraciones de paquetes, servicios y documentos privados que no pueden ser almacenados al igual que el resto del codigo en GitHub por temas de seguridad. Luego de descargar el archivo .zip, este debe ser descomprimido dentro de la carpeta `./dataperu-deploy/files`.

## Variables de entorno requeridas

Adicionalmente a lo anteriormente mencionado, es necesario que el usuario establezca una serie de variables de entorno que permitirán ejecutar el script de deploy sin la necesidad de establecer dichas variables dentro del script desarrollado. Dichas variables corresponden a:

| Variable de entorno    | Correspondencia                                                      |
| ---------------------- |------------------------                                              |
| USER_NAME              | Nombre de usuario del servidor de ejecución (ej: sadmin)             |
| USER_PASS              | Contraseña de usuario del servidor de frontend                       |
| USER_PASS_BACKEND      | Contraseña de usuario del servidor de backend                        |
| PSQL_USER              | Nombre de usuario de base de datos de PostgreSQL                     |
| PSQL_PASS              | Contraseña de usuario de base de datos de PostgreSQL                 |
| SERVER_PASS            | Contraseña de usuario del servidor de frontend                       |
| CLICKHOUSE_URL         | IP de gestor de base de datos ClickHouse (ej: localhost o 127.0.0.1) |
| CLICKHOUSE_USERNAME    | Nombre de usuario de base de datos de ClickHouse                     |
| CLICKHOUSE_DATABASE    | Nombre de base de datos de ClickHouse                                |
| CLICKHOUSE_PASSWORD    | Contraseña de usuario de base de datos de ClickHouse                 |

Se recomienda que estas variables sean exportadas a través de un archivo .env al entorno de trabajo correspondiente.

### Ejecución del Script

Para su ejecución, posterior a la instalación de Ansible, la descarga de los archivos correspondiente y la definición de las variables de entorno correspondientes, es necesario ejecutar el siguiente comando, el cual inicializará el archvio `deploy-prod.yaml` con base en el archivo `hosts` establecido. Es necesario considerar que el proceso de deploy corresponde a la configuración de los servidores de backend y frontend, por lo que el proceso puede tardar al rededor de 5~6 horas aproximadamente. Es posible obtener un registro de mayor profundidad durante la ejecución del script correspondiente ingresando el parámetro `-vvv` dentro del comando de ejecución de Ansible.

```
ansible-playbook -i hosts deploy-prod.yaml
```
