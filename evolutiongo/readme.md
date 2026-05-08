# Comando para criar pastas de volumes
mkdir -p /home/apps/evolutiongo/{.infra,postgres,app,backups,logs}
chown -R 999:999 /home/apps/evolutiongo/postgres

# Nos script tem comando cat para criar os sh

# Veja comando no .sh para criar os arquivos e de as permissões de execução
chmod +x /home/apps/evolutiongo/.infra/*.sh

# Cron para backup
0 2 * * * /home/apps/evolutiongo/.infra/backup.sh >> /var/log/evolutiongo-backup.log 2>&1