# GetirTodo

* A To Do app, written in Swift for iOS.
* Project is build on MVVM architecture.

## Project structure:

* The project has two view controllers, all embedded in a navigation controller.

## Project flow

* The first view controller shows the list of all To Do list. A "+" button to add new To Do. Added a delete button on the list to remove the To Dos.
* On tap of To Do, it redirects to detail screen of To Do where it shows To Do title and description. There are buttons for Updating and Deleting the To Do.
* Used Realm for storing the To Do data locally in app.
* Used IQKeyBoardManager for managing the keyboard and it's controls.
