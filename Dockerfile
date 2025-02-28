# Use the official Tomcat image from DockerHub
FROM tomcat:9.0-jdk15

# Copy your HTML and images into the default Tomcat webapps folder
COPY . /usr/local/tomcat/webapps/ROOT/

# Expose port 8080
EXPOSE 8080

# Start Tomcat server
CMD ["catalina.sh", "run"]
