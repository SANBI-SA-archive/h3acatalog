service postgresql start
su postgres
psql -c "ALTER USER postgres WITH PASSWORD 'postgres'"
tail
