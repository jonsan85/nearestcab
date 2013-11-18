nearestcab
==========

Thanks for checking out nearestcab. This web application is written in Java using Spring Roo.
Spring Roo greatly simplifies the Model-View-Controller pattern.

This project has been created with Eclipse, although it can be created entirely from 
command line with Spring Roo and maven installation.

==================
SETUP Instructions
==================
1. Install Eclipse Kepler 
2. Install Spring Tools Suite from within Eclipse Marketplace
3. Install Maven-Eclipse plugin m2e-WTP from within Eclipse Marketplace
4. Install PostgreSQL database
4. Make sure mvn is installed in the system and added to path
5. Make sure roo is installed in the system and added to path. Binary can be obtained from:
   http://docs.spring.io/downloads/nightly/snapshot-download.php?project=ROO
6. Make sure java is installed in the system (jdk1.6_xx)

7. From eclipse, import project into workspace.


Alternatively, download the zip file, run

- make sure export DATABASE_URL=postgres://[username]:[password]@localhost:5432/[databaseName]
- mvn clean install
- java -jar target/dependency/jetty-runner.jar target/*.war
