# task_manager_test
# Test Project: Task Manager App
The application begins with a login interface where users can authenticate themselves. Once logged in, users are directed to a user interface displaying the list of users. This page includes pagination functionality and a logout option.
In the second interface, the Tasks section showcases the tasks added by the user. Users can modify, delete, and sort tasks based on their date and status. Additionally, there is an option to add a new task, which redirects users to another page where they can provide the task details.

# Installation
1. Clone the repository to your local machine.
2. Open a terminal and navigate to the project directory.
3. Run the following command to install dependencies: "flutter pub get".
4. Run the app on an emulator or physical device using the following command: "flutter run".

# State Management
I used Bloc for state Management in this app.

# Local Storage
I used shared preferences for Local Storage in this app.

# Unit Tests
Unit tests are created to test all functionality from initial state to creating a new task, updating the task, and deleting the task.

# Features
1. User Authentication using "https://reqres.in/api/login"
   I created login page for the user to enter his email and password and we checked authentication using the API "https://reqres.in/api/login".
2. Pagination using "https://reqres.in/api/users?page=$page"
   I created users page to display users using the API "https://reqres.in/api/users?page=$page" and app performs Pagination when the user scrolls down.
3. Task Management
   I created task page to display all the tasks stored in SharePreference. The task can be deleted or edited through the edit page.

# Additional Features
1. Filter tasks
   Filter tasks by date or completion status.
2. Search in tasks
   Search in tasks using keywords.
3. Log out user
   Log out user and delete all their data in SharedPreference.
4. Set the start and end time of the task
   Set the start and end time of the task via intuitive user interface.
5. Error Handling
   The application includes error handling mechanisms to handle errors and display them safely to users, states provide details about errors encountered during data loading, creation, updates.

# Challenges Faced
The 'https://reqres.in/' API provides limited functionality for retrieving users. However, it does not support adding, deleting, or modifying data, even though it returns a StatusCode of 200. Additionally, when logging in, any existing email can be used with a random password, which is a logical error. Furthermore, the API fetches all users but does not retrieve user-related tasks.

To overcome these issues and align the API with the application's requirements, I have taken the following steps:

1. I fetched users from the API and implemented pagination functionality to retrieve users. I also utilized the API for user authentication, demonstrating that these features (1+3 in the quiz) can be achieved if the API functions correctly.

2. To Consider application requirements of task management and local storage (features 2+4 in the quiz), I implemented adding, deleting, modifying, and viewing tasks using SharedPreference. This showcases that these features can be accomplished either through the API or local storage.

By taking these steps, I have ensured that all procedures are carried out logically and that each required feature can be utilized as if the API were functioning properly. This approach also allows the application to maintain its task management logic.