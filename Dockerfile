# Utiliza la imagen base de Alpine Linux con Node.js preinstalado
FROM alpine:3.16

RUN apk add --no-cache build-base

# Establece el directorio de trabajo en /app
WORKDIR /webapp

# Copia los archivos de la aplicación en el contenedor
COPY Web-app/ /webapp

RUN apk add --update nodejs npm

# instalar dependencias y utilidades
RUN apk add --no-cache \
    bash \
    nano \
    bind-tools \
    perl \
    ruby \
    git \
    make \
    python3 \
    samba \
    nmap \
    nmap-scripts \
    openssh-client-common \
    curl

# Copiar configuración de samba
COPY Web-app/Analysis-app/SAMBA/smb.conf /etc/samba/smb.conf

# Exponer puertos samba, servicio web
EXPOSE 22 139 445 3000

# dependencias metasploit
RUN apk add --no-cache ncurses ncurses-terminfo

RUN apk add --no-cache \
    libffi-dev \
    #libressl-dev \
    ncurses-dev \
    readline-dev \
    postgresql-dev \
    libpcap-dev \
    zlib-dev \
    postgresql-libs

# Instalar Ruby
RUN apk add --no-cache ruby ruby-dev ruby-irb ruby-rdoc

# Instalar bundler de Ruby
RUN gem install bundler -v 2.2.17

# Instalar Metasploit
#RUN git clone --depth 1 https://github.com/rapid7/metasploit-framework.git /opt/metasploit
COPY Web-app/Dependencies/utils/metasploit-framework-master /opt/metasploit

# Cambiar al directorio del repositorio de Metasploit
WORKDIR /opt/metasploit

# Instalar las gemas de Ruby requeridas por Metasploit
RUN bundle install --jobs=4 --without test development

# Establecer el entorno para Metasploit
ENV PATH="/opt/metasploit/msf3:${PATH}"

RUN cp /usr/bin/perl /bin/perl

# copiar archivos de la VM a la imagen
COPY Web-app/Dependencies/perl/Net-IP-1.26 /root/.cpan/build/Net-IP-1.26
COPY Web-app/Dependencies/perl/Net-DNS-1.38-0 /root/.cpan/build/Net-DNS-1.38-0
COPY Web-app/Dependencies/perl/Net-Netmask-2.0002 /root/.cpan/build/Net-Netmask-2.0002
COPY Web-app/Dependencies/perl/XML-Writer-0.900 /root/.cpan/build/XML-Writer-0.900
COPY Web-app/Dependencies/perl/Module-Build-0.4234 /root/.cpan/build/Module-Build-0.4234
COPY Web-app/Dependencies/perl/String-Random-0.32 /root/.cpan/build/String-Random-0.32
COPY Web-app/Dependencies/perl/Net-Whois-IP-1.19 /root/.cpan/build/Net-Whois-IP-1.19
COPY Web-app/Dependencies/perl/WWW-Mechanize-2.17 /root/.cpan/build/WWW-Mechanize-2.17
COPY Web-app/Dependencies/perl/Parse-Yapp-1.21 /root/.cpan/build/Parse-Yapp-1.21
COPY Web-app/Dependencies/utils/enum4linux-master /opt/enum4linux
COPY Web-app/Dependencies/utils/dnsenum-master /opt/dnsenum
#COPY build-utils/samba-4.17.5 /opt/samba

# instalar modulos de perl
RUN cd /root/.cpan/build/Net-IP-1.26/ && perl ./Makefile.PL && make && make install
RUN cd /root/.cpan/build/Net-DNS-1.38-0/ && perl ./Makefile.PL && make && make install
RUN cd /root/.cpan/build/Net-Netmask-2.0002/ && perl ./Makefile.PL && make && make install
RUN cd /root/.cpan/build/XML-Writer-0.900/ && perl ./Makefile.PL && make && make install
RUN cd /root/.cpan/build/Module-Build-0.4234/ && perl ./Makefile.PL && make && make install
RUN cd /root/.cpan/build/String-Random-0.32/ && perl ./Build.PL && ./Build install
RUN cd /root/.cpan/build/Net-Whois-IP-1.19/ && perl ./Makefile.PL && make && make install
RUN cd /root/.cpan/build/WWW-Mechanize-2.17/ && perl ./Makefile.PL && make && make install
RUN cd /root/.cpan/build/Parse-Yapp-1.21/ && perl ./Makefile.PL && make && make install

RUN apk add python3-dev py3-pip build-base

RUN pip install paramiko

RUN cp /usr/bin/nmap /bin/nmap

RUN cp /opt/dnsenum/dnsenum.pl /bin/dnsenum
RUN chmod 777 /bin/dnsenum

RUN cp /usr/bin/python3 /bin/python3
RUN cp /opt/enum4linux/enum4linux.pl /bin/enum4linux

WORKDIR /webapp

# Define el comando que se ejecutará cuando el contenedor se inicie
#CMD ["npm", "start"]