# ExpenseTracker - work in progress ⚠️

The purpose of this project is creating a full application to track expenses. User can add his own categories, which can contain expenses. Each category is described by name and emoji. But expenses are described by name, amount, currency, expense's date and flag, which means if expense is necessary or optional.

## Technology stack
1. This repo contains service, which share REST API. Spring Boot is used to write it.
2. Mobile application is written in Swift, in details using SwiftUI, which means is only available for iOS platform.
3. Used database is PostgreSQL Database, which run in docker container.


## Run Locally

Clone the project

```bash
  git clone https://github.com/ale-gen/ExpenseTracker.git
```

Go to the project directory

```bash
  cd ExpenseTracker
```

Build and run docker containers for backend and database

```bash
  docker-compose up --build
```

Open XCode

```bash
  open -a Xcode
```

Run app on iOS simulator with shortcut <kbd>COMMAND+R</kbd>


