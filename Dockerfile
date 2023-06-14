# Utiliza la imagen base Alpine Linux
FROM alpine:3.16

# Copia los archivos de la aplicación en el contenedor
COPY Web-app/ /webapp

# instalar dependencias y utilidades
RUN apk add --no-cache \
    build-base \
    nodejs \
    npm \
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
    curl \
    ncurses \
    ncurses-terminfo \
    libffi-dev \
    ncurses-dev \
    readline-dev \
    postgresql-dev \
    libpcap-dev \
    zlib-dev \
    postgresql-libs \
    ruby \
    ruby-dev \
    ruby-irb \
    ruby-rdoc \
    python3-dev \
    py3-pip

RUN pip install paramiko

# Configurar Samba
RUN cp /webapp/Analysis-app/SAMBA/smb.conf /etc/samba/smb.conf

# Instalar y configurar Metasploit
RUN gem install bundler -v 2.2.17
RUN cp -R /webapp/Dependencies/utils/metasploit-framework-master /opt/metasploit
WORKDIR /opt/metasploit
RUN bundle install --jobs=4 --without test development
ENV PATH="/opt/metasploit/msf3:${PATH}"

# instalar modulos de perl
RUN cp /usr/bin/perl /bin/perl
RUN cd /webapp/Dependencies/perl/Net-IP-1.26/           && perl ./Makefile.PL && make && make install
RUN cd /webapp/Dependencies/perl/Net-DNS-1.38-0/        && perl ./Makefile.PL && make && make install
RUN cd /webapp/Dependencies/perl/Net-Netmask-2.0002/    && perl ./Makefile.PL && make && make install
RUN cd /webapp/Dependencies/perl/XML-Writer-0.900/      && perl ./Makefile.PL && make && make install
RUN cd /webapp/Dependencies/perl/Module-Build-0.4234/   && perl ./Makefile.PL && make && make install
RUN cd /webapp/Dependencies/perl/String-Random-0.32/    && perl ./Build.PL && ./Build install
RUN cd /webapp/Dependencies/perl/Net-Whois-IP-1.19/     && perl ./Makefile.PL && make && make install
RUN cd /webapp/Dependencies/perl/WWW-Mechanize-2.17/    && perl ./Makefile.PL && make && make install
RUN cd /webapp/Dependencies/perl/Parse-Yapp-1.21/       && perl ./Makefile.PL && make && make install

# copiar ejecutables en /bin
RUN cp /usr/bin/nmap /bin/nmap
RUN cp /usr/bin/python3 /bin/python3
RUN cp /webapp/Dependencies/utils/enum4linux-master/enum4linux.pl /bin/enum4linux
RUN cp /webapp/Dependencies/utils/dnsenum-master/dnsenum.pl /bin/dnsenum
RUN chmod 777 /bin/dnsenum

# Exponer puertos
EXPOSE 3000

WORKDIR /webapp
# Define el comando que se ejecutará cuando el contenedor se inicie
CMD ["npm", "start"]