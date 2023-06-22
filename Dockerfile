# Use the official Ubuntu base image
FROM ubuntu

# Update the package lists
RUN apt-get update

# Install Apache web server
RUN apt-get install -y apache2

# Copy the yogast-html files to the Apache web root directory
COPY ./ /var/www/html/

# Expose port 80 for the Apache web server
EXPOSE 80 

# Start the Apache web server in the foreground
CMD ["apache2ctl", "-D", "FOREGROUND"]

