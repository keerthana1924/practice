#! /bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo service httpd start  
sudo systemctl enable httpd
echo "<h1>Welcome to your dream world of Technology with love ! </h1>" > /var/www/html/index.html
