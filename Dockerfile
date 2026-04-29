# Use Tomcat base image
FROM tomcat:9.0

# Remove default apps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy WAR file into Tomcat
COPY target/facebookapp-1.0.0.war /usr/local/tomcat/webapps/ROOT.war

# Expose Tomcat port
EXPOSE 8090

# Start Tomcat
CMD ["catalina.sh", "run"]
