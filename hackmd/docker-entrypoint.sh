#!/bin/sh

# Ensure database has been migrated
node_modules/.bin/sequelize db:migrate

# Wait for database startup
sleep 3

# Run the app
node app.js
