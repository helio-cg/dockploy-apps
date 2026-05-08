#!/bin/bash

set -e

APP="evolutiongo"
APP_DIR="/home/apps/evolutiongo"

set -a
source /opt/restic/restic.env
set +a

echo "📥 Snapshots do app: $APP"
restic snapshots --tag $APP

echo ""
echo "🔁 Restaurando último snapshot..."

restic restore latest \
  --target $APP_DIR

echo "✅ Restore concluído"