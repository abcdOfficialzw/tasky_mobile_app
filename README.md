
# Taskyy Mobile Application

An Android and iOS application built with Flutter to allow users to record their tasks. The application features an offline first approach which allows users to create tasks while offline. The application the syncs the tasks once it has access to the internet


## Authors

- [@abcdOfficialzw](https://github.com/abcdOfficialzw)


## Instructions for installing

Inorder to successfully run the application you need to run the backend service and forward port 7111 to a public IP address. If you're running the backend service on a local machine you can use [ngrok](https://ngrok.com) to tunnell the connection to a public IP.

### 1. Change the BASE_URL
After running the backend service and getting the public IP address, replace the BASE_URL in lib/utils/constants/app_urls.dart of the application repository
![example of line to change](https://github.com/abcdOfficialzw/tasky_mobile_app/blob/main/assets/readme%20examples/Screenshot%202025-01-07%20at%2010.00.09.png?raw=true)

### 2. Running the application
Run the application as you would any other application.

The application uses flutter version 3.22.0, run the command ```fvm use 3.22.0``` . If you do not have version 3.22.0 downloaded it will be downloaded and installed. You may want to restart your IDE for changes to take effect.
## Using the Application

After installing the application on your device no additional setup is required.

1. Launch Screen
   ![Tasky Launch Screen](https://github.com/abcdOfficialzw/tasky_mobile_app/blob/main/assets/readme%20examples/launchpage.PNG?raw=true)
2. Landing Page
   ![Tasky Landing Page](https://github.com/abcdOfficialzw/tasky_mobile_app/blob/main/assets/readme%20examples/landing_page.PNG?raw=true)
3. Sign in Page
- Use the details username: ```takutitus``` and password ```ruj*33hk``` to sign in.
  ![Tasky Sign in Page](https://github.com/abcdOfficialzw/tasky_mobile_app/blob/main/assets/readme%20examples/signin_page.PNG?raw=true)
4. Sign up
   If you don't have an account tap on the Get Started link from the sign in page.
   ![Tasky Sign up Page](https://github.com/abcdOfficialzw/tasky_mobile_app/blob/main/assets/readme%20examples/signup_page.PNG?raw=true)
5. Home Page
   ![Tasky Home Page](https://github.com/abcdOfficialzw/tasky_mobile_app/blob/main/assets/readme%20examples/home_page.PNG?raw=true)
6. Creating a task
- To create a task tap on the Floating Action Button.
  ![Tasky Create Task Page](https://github.com/abcdOfficialzw/tasky_mobile_app/blob/main/assets/readme%20examples/create_task_page.PNG?raw=true)
  ![Tasky Select Custom Date](https://github.com/abcdOfficialzw/tasky_mobile_app/blob/main/assets/readme%20examples/create_task_select_date.PNG?raw=true)
7. Searching a task
- To search a task use the search bar at the top.
8. Viewing a task
- To view a task tap on it.

9. Editing a task
- To edit a task, tap on the task, and tap on the field you want to edit.
  ![Tasky Edit task](https://github.com/abcdOfficialzw/tasky_mobile_app/blob/main/assets/readme%20examples/edit_task.PNG?raw=true)
10. Syncing tasks
- Tasks are synced automatically in 1 minute interval, refresh the screen by pulling down from the top.
  ![Refresh task](https://github.com/abcdOfficialzw/tasky_mobile_app/blob/main/assets/readme%20examples/refresh_task.PNG?raw=true)
- Synced tasks will have a green cloud icon.
  ![Tasky Synced task](https://github.com/abcdOfficialzw/tasky_mobile_app/blob/main/assets/readme%20examples/task_synced.PNG?raw=true)