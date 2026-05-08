# Comando para criar pastas de volumes
mkdir -p /home/apps/evolutiongo/{.infra,postgres,app,backups,logs}
chown -R 999:999 /home/apps/evolutiongo/postgres

# Cron para backup
0 2 * * * /home/apps/evolutiongo/.infra/backup.sh >> /var/log/evolutiongo-backup.log 2>&1