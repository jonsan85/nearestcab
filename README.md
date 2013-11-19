Nearest Cab Challenge
=====================

Thanks for checking out Nearest Cab Challenge. This web application is written in Java using Spring Roo.


Setup Instructions
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

+ make sure export DATABASE_URL=postgres://[username]:[password]@localhost:5432/[databaseName]
+ mvn clean install
+ java -jar target/dependency/jetty-runner.jar target/*.war


Production deployment
=====================
1. The application was deployed to heroku:
   http://gentle-garden-4541.herokuapp.com/


Usage examples
==============
The left menu shows 2 sections: CAB and VIEW

CAB
===
1. This renders the Create new Cab and List all Cabs. 
2. Create new cab shows a form that user can input to create a cab. 
3. It utilizes POST and mimetype header application/xml.
4. List all Cabs shows all cabs allowing an optional results per page.
5. It utilizes GET and mimetype header application/xml.

VIEW
====
1. This renders the Web Service Test.
2. The mimetype header is application/json.
3. All supported method and urls below. The normal response is 200 OK:

   [PUT]
   /cabs/3  Content: { Latitude: 12.812534, Longitude: -87.342345 }
   The id attribute in json is ignored in preference of the /{id}.
   If id=3 does not exist, this will create a new cab at specified latitude and longitude.
   Otherwise, it will update the cab with id=3.  

   [PUT]
   /cabs    Content: [{}, {}]  "json array"
   Perform create/update on each item. 
   
   [GET]
   /cabs/3  
   Retrieve json string of cab with id=3. 

   [GET]
   /cabs?latitude=37.763658&longitude=-122.427521&radius=1000000&limit=15  
   Retrieve json array of cabs whose distance from the given latitude and longitude is less than the specified radius.
   The distance is calculated from the haversine formula and is in meters.
   Latitude and longitude are the only required parameters. By default, it will limit the number of cabs to 8.
   
   [Delete]
   /cabs/3
   Remove the cab with id=3
   
   [Delete]
   /cabs
   Remove all cabs
   
   [GET]
   http://gentle-garden-4541.herokuapp.com/cabs?latitude=37.763658&longitude=-122.427521&radius=1000000&limit=15
   Return html result as table.
   A maximum of 15 cabs, each with distance no more than 1 km away from given latitude and longitude will be returned.
   
   [GET]
   http://gentle-garden-4541.herokuapp.com/cabs?page=1&size=10
   Return html result as table with scrollable pages. Page 1 is shown. Each page shows a maximum of 10 cabs.
   
   



