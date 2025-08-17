# 22ug2-0119_CCS3308_Assignment1
## Deployment Requirements
-Docker

-Docker Compose

-Git
## Aplication Decription
This application demonstrates containerized deployment with muliple services

  -Web Services (Flask app): Provides a simple web interface.
  
  -Database Services(MySQL): Stores application data in a persistent volume.
## Network and Volume Details
-Network: 'app-network' for inter-container communication

-Volume: 'db-data' for persistent MySQL data storage
## Container Configuration
Web Service (Flask)

-image: Custom image built from Dockerfile (Python + Flask)

-Port: Exposes 5000:5000

-Environment Variables:

    -DB_HOST=db
    
    -DB_USER=root
    
    -DB_PASSWORD=example
    
    -DB_NAME=appdb
    
-Restart Policy: always

Database Sevice (MySQL)

  -image: mysql:8.0 (from Docker Hub)
  
  -Port: Exposes 3306:3306.
  
  -Environment Variables:
  
    - MYSQL_ROOT_PASSWORD=example
    
    - MYSQL_DATABASE=appdb
    
  -Volume: db_data:/var/lib/mysql
  
  -Restart Policy: always
  ## Container List
  
   Cotainer
   
     -web
     
        image: custom Flask image
        
        Role: Web front-end
        
        Port: 5000
        
        Volume: None
        
     -db

        image: mysql:8.0

        Role: Database backend

        Port: 3306

        Volume: db_data
## Instructions
1. Prepare application resources

   ./prepare-app.sh

2. Start application

   ./start-app.sh

   This starts containers.

   The application will be available at:

   http://localhost:5000

3. Stop application

   ./stop-app.sh

4. Remove application

   ./remove-app.sh

## Example Workflow

1. Create application resources
 
      ./prepare-app.sh

       Preparing app...

2. Run the application
 
     ./start-app.sh

      Running app...

      The app is available at http://localhost:5000

3. Open a web browser and access the application

4. Stop the application

     ./stop-app.sh

      Stopping app...

5. Remove all resources

      ./remove-app.sh

      Removed app.


   



        
  
