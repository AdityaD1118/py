# Use Tomcat 10 base image
FROM tomcat:10.1-jdk17

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR into Tomcat as ROOT.war
COPY course.war /usr/local/tomcat/webapps/ROOT.war

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
