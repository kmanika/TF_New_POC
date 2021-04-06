#!/bin/bash
sudo su
cat << 'EOF' > /etc/environment
LANG=en_US.utf-8
LC_ALL=en_US.utf-8
EOF
sudo yum update -y
sudo yum install -y awslogs
sudo systemctl start awslogsd
yum -y install httpd
cat << 'EOF' > /var/www/html/index.html
<!DOCTYPE html>
<html>
<title>Demo</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<body>

<!-- Header -->
<header class="w3-display-container w3-content w3-wide" style="max-width:1500px;" id="home">
  <img class="w3-image" src="https://my-demo-pvk.s3.ap-south-1.amazonaws.com/architect.jpeg" alt="Architecture" width="1500" height="800">
  <div class="w3-display-middle w3-margin-top w3-center">
    <h1 class="w3-xxlarge w3-text-white"><span class="w3-padding w3-black w3-opacity-min"><b>Terraform</b></span> <span class="w3-hide-small w3-text-light-grey">Demo</span></h1>
  </div>
  <div class="w3-top">
  <div class="w3-bar w3-white w3-wide w3-padding w3-card">
    <!-- Float links to the right. Hide them on small screens -->
    <div class="w3-right w3-hide-small">
      <a href="#about" class="w3-bar-item w3-button">About</a>
    </div>
  </div>
</div>
  <div class="w3-container w3-padding-32" id="about">
    <h3 class="w3-border-bottom w3-border-light-grey w3-padding-16">About</h3>
    <p>This website is created by terraform.
    </p>
  </div>
</header>
EOF
sudo systemctl enable httpd
sudo systemctl start httpd
cat << 'EOF' > /tmp/test.sh
i=1
while [ $i -le 1000000 ]
do
        echo $i >> res.txt
        i=$(($i+1))
done
EOF