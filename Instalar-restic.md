apt install restic -y

mkdir -p /opt/restic

nano /opt/restic/restic.env

export AWS_ACCESS_KEY_ID="SUA_KEY"
export AWS_SECRET_ACCESS_KEY="SEU_SECRET"
export RESTIC_REPOSITORY="s3:https://SEU_ACCOUNT_ID.r2.cloudflarestorage.com/NOME_BUCKET"
export RESTIC_PASSWORD="SENHA_FORTE_BACKUP"

source /opt/restic/restic.env

chmod 600 /opt/restic/restic.env

restic init (só exceuta a primeira vez no primeiro backup, se for reaturar não exceutar)

==============
TEstes temporário, apagar:

export AWS_ACCESS_KEY_ID="23a7d6e59951e0824593ac1c0b634fd7"
export AWS_SECRET_ACCESS_KEY="b134e7e1e5c9f406b56867e1a725ecc125d1a9f4247d0675ff6b78c0f3abaca8"
export RESTIC_REPOSITORY="s3:https://b1763df2f28b6849b45ed9f161e170dd.r2.cloudflarestorage.com/dokploy"
export RESTIC_PASSWORD="5c9f406b56867e1a725e"