# Customized Jenkins docker image.

FROM jenkins/jenkins:lts-jdk11

# Skip setup wizard and protection.
ENV JAVA_OPTS "-Djenkins.install.runSetupWizard=false"
ENV CASC_JENKINS_CONFIG /var/jenkins_home/casc.yaml

# Add Jenkins plugins from separate file
COPY --chown=jenkins:jenkins plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli -f /usr/share/jenkins/ref/plugins.txt

# Setup Configuration as Code
#COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
#RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
COPY jenkins_config.yaml /var/jenkins_home/casc.yaml
