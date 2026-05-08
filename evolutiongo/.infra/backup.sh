#!/bin/bash

set -e

APP="evolutiongo"
APP_DIR="/home/apps/evolutiongo"
DATE=$(date +%Y-%m-%d_%H-%M)

# Carrega variáveis do Restic
set -a
source /opt/restic/restic.env
set +a

echo "📦 Iniciando backup: $APP"

# Dump do banco (IMPORTANTE pro Postgres)
echo "🟡 Gerando dump do Postgres..."

docker exec evolutiongo-postgres pg_dumpall -U postgres \
  > $APP_DIR/backups/postgres-$DATE.sql

# Backup com Restic
echo "🟢 Enviando para Restic..."

restic backup $APP_DIR \
  --tag $APP \
  --tag "docker" \
  --tag "$DATE" \
  --exclude "$APP_DIR/app/node_modules" \
  --exclude "$APP_DIR/app/vendor"

# Retenção
echo "🧹 Limpando snapshots antigos..."

restic forget \
  --tag $APP \
  --keep-daily 7 \
  --keep-weekly 4 \
  --keep-monthly 3 \
  --prune

echo "✅ Backup finalizado: $APP"

cat > /home/apps/evolutiongo/.infra/backup.sh <<'EOF'
#!/bin/bash

set -e

APP="evolutiongo"
APP_DIR="/home/apps/evolutiongo"
DATE=$(date +%Y-%m-%d_%H-%M)

# Carrega variáveis do Restic
set -a
source /opt/restic/restic.env
set +a

echo "📦 Iniciando backup: $APP"

# Dump do banco (IMPORTANTE pro Postgres)
echo "🟡 Gerando dump do Postgres..."

docker exec evolutiongo-postgres pg_dumpall -U postgres \
  > $APP_DIR/backups/postgres-$DATE.sql

# Backup com Restic
echo "🟢 Enviando para Restic..."

restic backup $APP_DIR \
  --tag $APP \
  --tag "docker" \
  --tag "$DATE" \
  --exclude "$APP_DIR/app/node_modules" \
  --exclude "$APP_DIR/app/vendor"

# Retenção
echo "🧹 Limpando snapshots antigos..."

restic forget \
  --tag $APP \
  --keep-daily 7 \
  --keep-weekly 4 \
  --keep-monthly 3 \
  --prune

echo "✅ Backup finalizado: $APP"
EOF