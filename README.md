# Telomeres | TFG
### Herramienta de Pentesting Automatizado

Trabajo Fin de Grado hecho en colaboración con la empresa Orbik Cybersecurity.
Este repositorio es una herramienta de pentesting para una máquina en red local.
Esta pensada para que un usuario sin experiencia ni conocimientos de ciberseguridad pueda usarla satisfactoriamente.

## Requisitos

La aplicación se ejecuta en un contenedor Docker; tener Docker es el único requisito para usarla.
No es necesaria la instalación de softwares de terceros más allá de Docker.

En el repositorio no se incluye la imagen, pero sí el Dockerfile para crearla.
Una vez montada, la imagen pesa casi 700 MB.
Se recomienda ejecutar en usuario administrador (o equivalente) para evitar conflictos de permisos.

## Manual de Uso

Antes de usar el software, tal y como se ha mencionado en el apartado anterior, es necesario compilar la imagen de Docker.
Descargado el repositorio, en una terminal navegamos hasta el directorio raíz y compilamos la imagen:

    docker build -t telomeres .

Compilada la imagen, desplegamos y corremos el contenedor:

    docker run -p 3000:3000 -it telomeres

Una vez dentro del contenedor, podemos empezar a usar la aplicación. Hay dos modos de uso: modo aplicación web, y modo terminal.
La aplicación web está desarrollada con Nodejs, y para acceder a ella se puede hacer mediante el puerto 3000 en cualquier navegador web.
En el caso de la ejecución mediante la terminal, se lanza el script "launcher.sh". Hay dos formas de ejecución; modo interactivo y modo parametrizado.

### Aplicación Web

Lanzado el contenedor, estando en el directorio /webapp (el contenedor por defecto se encuentra ahí) para arrancar el servidor web:

    npm start

Mediante cualquier navegador web, ahora se puede acceder a la aplicación web:

    localhost:3000

Una vez estamos en la web, introducida la IP, se comprueba la conexión la máquina objetivo, y tras eso se detectan sus servicios y puertos disponibles.
Terminado ese proceso, se muestra una pantalla con los protocolos y servicios detectados. Los nombres de estos servicios funcionan como botones, los cuales se pueden pulsar para acceder a las opciones de análisis de cada uno.
Hecha la selección del análsis deseada, se presiona el botón "Start" para comenzar el análisis (botón "Cancel" para volver al menú). Cuando termine la ejecución, se podrá descargar el resultado en un fichero de formato JSON.

### Modo terminal

Lanzado el contenedor, estando en el directorio /webapp (el contenedor por defecto se encuentra ahí), podemos ver las opciones de ejecución:

    ./launcher.sh

La ejecución interactiva pide la configuración del análisis parámetro a parámetro, paso a paso, protocolo a protocolo. Para hacer uso de este modo:

    ./launcher.sh -it

La ejecución parametrizada coge la configuración del análisis mediante argumentos. El parámetro de la IP tiene que ser obligatoriamente el primero. Ejemplos de ejecución:

    Análisis configurado para FTP, SQL, SAMBA     
    ./launcher.sh --ip 192.168.0.1 --ftp --sql --samba

    Análisis configurado para SAMBA, DNS, XSS a URL individual
    ./launcher.sh --ip 192.168.0.1 --samba --dns ejemplo.com --xssurl https://brutelogic.com.br/gym.php

En ambos casos, el resultado será un fichero de formato JSON, de nombre "global.json", y se creará en /webapp/Analysis-app/general/global.json
