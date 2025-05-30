# Use the Official CentOS 7 Base Image
FROM centos:centos7

# Update DNS resolver and configure repositories
RUN sed -i 's|mirrorlist=http://mirrorlist.centos.org|#mirrorlist=http://mirrorlist.centos.org|g' /etc/yum.repos.d/CentOS-Base.repo && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Base.repo


#  Install the Apache HTTP server package from the CentOS Repository
RUN yum install httpd -y

# Copy the index.html file from the Docket build context to the default Apache document root directory in the container
COPY index.html /var/www/html/
COPY getbucketContents.html /var/www/html/
COPY getbucketStyles.css /var/www/html/
COPY uploadstyle.css /var/www/html/

# Specify the command to run when the container starts, which starts the Apache HTTP Server in the foreground
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

#Expose port 80 to allow incoming HTTP traffic to the container
EXPOSE 80

#TO RUN DOCKER FINE, NAVIGATE TO THE DIRECTORY AND RUN - docker build -t myimage .
