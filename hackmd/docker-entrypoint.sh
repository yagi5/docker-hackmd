#!/bin/sh

if [ -f .sequelizerc ]; then
    node_modules/.bin/sequelize db:migrate
fi

# wait for db up
sleep 3

# run
exec node app.js
