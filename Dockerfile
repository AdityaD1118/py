# Use official Tomcat image with Java 17
FROM tomcat:11.0-jdk17

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your webapp into Tomcat ROOT folder
COPY course/src/main/webapp /usr/local/tomcat/webapps/ROOT

# Expose Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]