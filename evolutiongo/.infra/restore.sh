#!/bin/bash

set -e

APP="evolutiongo"
APP_DIR="/home/apps/evolutiongo"
RESTORE_DIR="/tmp/restore-$APP"

set -a
source /opt/restic/restic.env
set +a

echo "📥 Snapshots do app: $APP"
restic snapshots --tag "$APP"

echo ""
echo "🔁 Restaurando último snapshot do app (seguro em staging)..."

# limpa restore anterior se existir
rm -rf "$RESTORE_DIR"
mkdir -p "$RESTORE_DIR"

# restore com filtro correto
restic restore latest \
  --tag "$APP" \
  --target "$RESTORE_DIR"

echo ""
echo "📦 Aplicando restore no diretório final..."

rsync -a "$RESTORE_DIR/" "$APP_DIR/"

echo ""
echo "🧹 Limpando staging..."
rm -rf "$RESTORE_DIR"

echo ""
echo "✅ Restore concluído com sucesso"

cat > /home/apps/evolutiongo/.infra/restore.sh <<'EOF'
#!/bin/bash

set -e

APP="evolutiongo"
APP_DIR="/home/apps/evolutiongo"
RESTORE_DIR="/tmp/restore-$APP"

set -a
source /opt/restic/restic.env
set +a

echo "📥 Snapshots do app: $APP"
restic snapshots --tag "$APP"

echo ""
echo "🔁 Restaurando último snapshot do app (seguro em staging)..."

# limpa restore anterior se existir
rm -rf "$RESTORE_DIR"
mkdir -p "$RESTORE_DIR"

# restore com filtro correto
restic restore latest \
  --tag "$APP" \
  --target "$RESTORE_DIR"

echo ""
echo "📦 Aplicando restore no diretório final..."

rsync -a "$RESTORE_DIR/" "$APP_DIR/"

echo ""
echo "🧹 Limpando staging..."
rm -rf "$RESTORE_DIR"

echo ""
echo "✅ Restore concluído com sucesso"
EOF