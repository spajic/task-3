web: bin/rails s -e local_production -b 'ssl://127.0.0.1:3000?key=./config/certs/localhost.key&cert=./config/certs/localhost.crt'
job: bin/rake jobs:work
