require 'pg'

DATABASE = PG.connect(dbname: 'postgres', host: 'database',  user: 'postgres', password: 'pass')