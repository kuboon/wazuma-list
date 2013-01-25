run "heroku create #{@app_name}"

run 'heroku addons:add cleardb'

git :add => "."
git :commit => "-a -m 'heroku'"

git push heroku master
heroku run rake db:migrate
heroku run rake assets:precompile
