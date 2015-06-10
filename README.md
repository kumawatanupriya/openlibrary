openlibrary
===========

![](https://raw.github.com/TWChennai/openlibrary/master/public/img/screenshot.png)


This is a Sinatra based app to track library books.

Setup Instructions :
After the repo has been cloned and gems installed (bundle install), here are the steps :

1. Create a mysql database named openlibrary_dev
2. For creating tables in db :
    rake db:migrate
3. Import data for users and books from the CSVs using following :
    MODEL=Book ruby scripts/load_csv.rb data/books.csv
    MODEL=User ruby scripts/load_csv.rb data/users.csv
4. To run the app use
    shotgun
5. The app can be accessed at localhost:9393

