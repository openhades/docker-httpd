FROM centos:centos7
MAINTAINER Konrad Mosoń <morsik@darkserver.it>

RUN rpm --import http://mirror.centos.org/centos/7/os/x86_64/RPM-GPG-KEY-CentOS-7 && \
    yum update -y && \
    yum install -y httpd && \
    yum clean all

WORKDIR /etc/httpd

CMD ["/usr/sbin/apachectl", "-DFOREGROUND"]

EXPOSE 80



