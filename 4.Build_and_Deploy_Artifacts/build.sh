#!/bin/bash

# Check Maven version
mvn -version

# Check AWS CLI version
aws --version

# Build the Maven project
mvn install

# Configure AWS CLI (interactive)
aws configure

# Upload the WAR file to S3
aws s3 cp target/vprofile-v2.war s3://ls.aws/vprofile-v2.war

# SSH to app01 and deploy
ssh app01 << 'EOF'
sudo -i
snap install aws-cli --classic
aws --version
aws s3 cp s3://ls.aws/vprofile-v2.war /tmp/vprofile-v2.war
systemctl stop tomcat10
systemctl daemon-reload
rm -rf /var/lib/tomcat10/webapps/ROOT
cp /tmp/vprofile-v2.war /var/lib/tomcat10/webapps/ROOT.war
systemctl start tomcat10
EOF