# Help
# crontab -e
# 0 0 * * * /path/to/dump.sh db_name  /path/to/backup > /dev/null 2>&1

umask 377

database=$1
path=$2

psql -d $database -c "vacuum full"
psql -d $database -c "reindex database $database"
psql -d $database -c "analyze"
find $path -ctime +5 -delete
pg_dump $database | gzip > $path/$database-$(date "+%Y-%m-%d").sql.gz

