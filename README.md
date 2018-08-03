# Gradebook
*Viget Sample Application*

A bare-bones Rails application for organizing semester grades. Contains separate views for administrators, teachers, and students. Teachers are able to manage their class rosters as well as change their students' grades. Below are some short notes on this project that might be helpful to read before the review.

## Running the gradebook
* Clone this repository or unzip the tarball.
* Run ```bundle && rails db:migrate && rails db:seed && rails server```. This will install dependecies, create and migrate the database, seed the database (for aesthetic purposes, since there isn't any real data), and then start the server.
* Once the server is started, you can find the web app at ```localhost:3000```. Here are three possible logins that demonstrate the different possible views based on user type:
**User Type** | **Email**    | **Password**
--------------|--------------|------------
student       | student0@school.edu | password
teacher       | teacher0@school.edu | password
All types (including administrator) | master@school.edu | password

## Note on the style
There is little to no styling here since I wanted to focus my time on the aspects of the project that are more relevant to the Application Developer position. However, if you want to see some of my previous styling work, see [here](https://github.com/malcolmsgroves/chess-js) and [here](https://github.com/malcolmsgroves/buck-tagger).

## Tests
This application includes model and controller tests. If you want to see some integration tests I have written for a previous project, see [here](https://github.com/malcolmsgroves/buck-tagger).

## User Authentication
The **Devise** gem is used to authenticate the users and maintain a secure login. Users cannot access any part of the gradebook without first logging in. Then the following pages and actions are accessible depending on the user:

**User Type** | **Pages and Actions**
--------------|----------------------
student       | View courses, grades, and GPA
teacher       | View list of classes they teach, class rosters with grades, and can edit rosters and grades
administrator | View all courses with enrollment counts and average class grades

## Model Design
The database has three models: User, Grade, and Course. User and Course are related by the teacher. Grades connect the students to the courses and also store the actual grade value. Grade is indexed by *course_id* and *student_id* for quick lookup and calculations.

## Controllers
Two controllers do all the heavy lifting. The courses controller renders each of the different course index routes and also gives the teacher course view. The grades controller is in charge of CRUD actions on the grades.

