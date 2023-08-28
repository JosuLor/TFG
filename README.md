# Telomeres - Herramienta de Pentesting Automatizada - TFG

Trabajo Fin de Grado hecho en colaboración con la empresa Orbik Cybersecurity.
Este repositorio es una herramienta de pentesting para una máquina en red local.
Esta pensada para que un usuario sin experiencia ni conocimientos de ciberseguridad pueda usarla satisfactoriamente.

## Requisitos

La aplicación se ejecuta en un contenedor Docker; tener Docker es el único requisito para usarla.
En el repositorio no se incluye la imagen, pero sí el Dockerfile para crearla.
No es necesaria la instalación de softwares de terceros más allá de Docker.
Una vez montada, la imagen pesa casi 700 MB.
Se recomienda ejecutar en usuario administrador (o equivalente) para evitar conflictos de permisos.

## Manual de Uso

Antes de usar el software, tal y como se ha mencionado en el apartado anterior, es necesario compilar la imagen de Docker.
Descargado el repositorio, en una terminal navegamos hasta el directorio raíz y compilamos la imagen:

    docker build -t telomeres .

Compilada la imagen, desplegamos y corremos el contenedor:

    docker run -p 3000:3000 -it telomeres

Una vez dentro del contenedor, podemos empezar a usar la aplicación. Hay dos modos de uso: modo aplicación web, y modo terminal.
