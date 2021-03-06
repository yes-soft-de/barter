# Symfony App Skeleton 🚧
*. env file and private-public keys not enclosed .*
## Project setup

### Composer thing
```
composer update
```
### Database setup
First add to** .env** file correct connection string
`DATABASE_URL=mysql://root@127.0.0.1:3306/barterDB?serverVersion=5.7`

Then create database
```
php bin/console doctrine:database:create
```

After that make migration
```
php bin/console make:migration
```

Finaly run migration versions to create tables
```
php bin/console doctrine:migration:migrate
```

### APIs Guide
* [Account](#account)
* [Main](#main)
* [Category](#category)
* [Services](#services)

### Account
#### Create new user
```
/user
methods: POST
```
#### login
```
/login_check
methods: POST
```
#### Update user profile
```
/userprofile
methods: PUT
```
#### Get user profile by userID
```
/userprofile
methods: GET
```

### Main
#### Get all members
```
/members
methods: GET
```

### Category
#### Create new category
```
/category
methods: POST
```
#### Update existing category
```
/category
methods: PUT
```
#### Delete existing category
```
/category/{id}
methods: DELETE
```
#### Get all categories
```
/categories
methods: GET
```
#### Get category by id
```
/category/{id}
methods: GET
```

### Services
#### Create new service
```
/service
methods: POST
```
#### Update existing service
```
/service
methods: PUT
```
#### Delete existing service
```
/service/{id}
methods: DELETE
```
#### Get services of a category
```
/services/{categoryID}
methods: GET
```
#### Get services of signed in user
```
/myservices
methods: GET
```
#### Get services of personal/company account by service ID
```
servicesbyid/{serviceID}
methods: GET
```
#### Search services by either categoryID or name or both
```
searchservices
methods: POST
```

this edited by tools repository for more informatin about this repository please visit https://yes-soft.de/category/blog/
