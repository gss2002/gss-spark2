# gss-spark2
## Spark2 Maven RPM Generation Package
This is used to generate Spark2 RPM for distributions such as Hortonworks HDP. This maven build specifically handles HDP 2.5.x

How to:
Install RPM Build tools on Centos/RHEL Node:
yum install rpm-build 
cd gss-spark2
./apache-maven-3.5.4/bin/mvn package -Drpm.version=2.2.2 -Drpm.release=1
