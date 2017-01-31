FROM centos:centos7
MAINTAINER Konrad Mosoń <morsik@darkserver.it>

RUN yum update -y && \
    yum install -y httpd && \
    yum clean all && \
    echo "# This file was cleaned when building Docker image" > /etc/httpd/conf.d/welcome.conf

WORKDIR /etc/httpd

EXPOSE 80

ADD entrypoint.sh /entrypoint
RUN chmod +x /entrypoint
CMD ["/entrypoint"]
