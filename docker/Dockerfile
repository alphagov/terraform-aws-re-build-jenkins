ARG JENKINS_VERSION
FROM jenkins/jenkins:${JENKINS_VERSION}

# 80 = nginx
# 8080 = jenkins
# 50000 = jenkins workers
EXPOSE 80 8080 50000

# set a health check to make sure jenkins is working
HEALTHCHECK CMD nc -zv 127.0.0.1 80 || exit 1

# Install build tools
USER root

# Copy new entrypoint file
COPY files/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY files/start-jenkins.sh /start-jenkins.sh
RUN chmod +x /start-jenkins.sh

# copy list of plugins
COPY files/plugins.txt /usr/share/jenkins/ref/plugins.txt

# enable logging
COPY files/log.properties /usr/share/jenkins/ref/log.properties

# copy jenkins groovy configuration
COPY files/groovy/*.groovy /usr/share/jenkins/ref/init.groovy.d/

# fix permissions
RUN chown -R jenkins:jenkins /usr/share/jenkins/ref

# install nginx
RUN apt-get update
RUN apt-get install -y nginx
COPY files/nginx-jenkins /etc/nginx/sites-enabled/jenkins
RUN rm -rf /etc/nginx/sites-enabled/default

# install nc for healthcheck
RUN apt-get install -y netcat

# drop back to jenkins user
USER jenkins

# install plugins and disable "install plugins banner"
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state

ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false -Djava.util.logging.config.file=/var/jenkins_home/log.properties"

# start the wrapper script as user root
USER root
ENTRYPOINT ["/entrypoint.sh", "/start-jenkins.sh"]
