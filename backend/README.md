# Symfony App Skeleton 🚧
*Note: .env file and private-public keys not enclosed.*
## Project setup

1) Composer thing
```
composer update
```

2) Database setup

First, add the following correct connection string to the _.env_ file:
`DATABASE_URL=mysql://root@127.0.0.1:3306/barterDB?serverVersion=5.7`

Second, create the database:
```
php bin/console doctrine:database:create
```

After that, make the required migration:
```
php bin/console make:migration
```

Finally, run the migration in order to create the tables:
```
php bin/console doctrine:migration:migrate
```
----


### APIs Guide
* [Account](#account)
* [File Upload](#file-upload) 
* [Main](#main)
* [Category](#category)
* [Services](#services)
* [Swap](#swap) 
* [Rating](#rating)

### Account
#### Create a new user, and a new profile
```
/user
methods: POST
```
#### Login
```
/login_check
methods: POST
```
#### Update signed-in user's profile
```
/userprofile
methods: PUT
```
#### Get user profile by userID
```
/userprofile
methods: GET
```
#### Get user profile by serviceID
```
/userprofile/serviceID
methods: GET
```
****

### File Upload
#### Upload an image
```
/uploadfile
methods: POST
```
****

### Main
#### Get all members, either personal or company accounts
```
/members
methods: GET
```
****

### Category
#### Create a new category
```
/category
methods: POST
```
#### Update existing category
```
/category
methods: PUT
```
#### Delete existing category by id
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
****

### Services
#### Create a new service
```
/service
methods: POST
```
#### Update existing service
```
/service
methods: PUT
```
#### Delete existing service by id
```
/service/{id}
methods: DELETE
```
#### Get services of a specific category
```
/services/{categoryID}
methods: GET
```
#### Get services of signed-in user
_Authenticated only for members_ 
```
/myservices
methods: GET
```
#### Get services of personal/company account by service ID
```
/servicesbyid/{serviceID}
methods: GET
```
#### Search services by either categoryID or name or both
```
/searchservices
methods: POST
```
****

### Swap
#### Create a new swap
```
/swap
methods: POST
```
#### Get all swaps
```
/swap
methods: GET
```
#### Get swap by id
```
/swapbyid/{id}
methods: GET
```
#### Delete existing swap 
```
/swap/{id}
methods: DELETE
```
#### Update existing swap by id
```
/swap 
methods: PUT
```
#### Get all swaps of signed-in user
```
/swapbyuserID 
methods: GET
```
****

### Rating
#### Create new rating for an account or for a service.
_Note: entityType takes one of two chars 'A' or 'S', where 'A' refers to Account or 'S' refers to Service. While entityID takes the serviceID exclusively._ 
```
/rating
methods: POST
```
#### Get average rating for an account or for a service.
```
/rating/{entityID}
methods: GET
```

this edited by tools repository for more information about this repository please visit https://yes-soft.de/category/blog/
