## Environment Setup

Install RVM

    curl -L https://get.rvm.io | bash -s stable --ruby

Install ruby 1.9.3-p327

    rvm install ruby-1.9.3-p327

Create gemset (should happen automatically)

    rvm gemset create xxx

Install required gems

    bundle install

Setup database

    rake db:migrate
    RACK_ENV=test rake db:migrate

Start server

    rake server

Start server (without refresh, but cached sentiment)

    rackup -p 3000

Start console

    rake console
