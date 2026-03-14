# Use official Tomcat image
FROM tomcat:11.0-jdk17

# Remove default webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your project webapp into Tomcat
COPY course/src/main/webapp /usr/local/tomcat/webapps/ROOT

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
