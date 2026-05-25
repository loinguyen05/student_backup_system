#!/bin/bash

BASE_DIR="$(dirname "$(dirname "$(realpath "$0")")")"

DATA_DIR="$BASE_DIR/data"
BACKUP_DIR="$BASE_DIR/backups"
LOG_DIR="$BASE_DIR/logs"

mkdir -p "$BACKUP_DIR"
mkdir -p "$LOG_DIR"

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

BACKUP_FILE="$BACKUP_DIR/data_backup_$TIMESTAMP.tar.gz"

tar -czf "$BACKUP_FILE" "$DATA_DIR"

echo "$(date '+%Y-%m-%d %H:%M:%S') : Backup thành công -> $(basename "$BACKUP_FILE")" >> "$LOG_DIR/backup.log"

# Chỉ giữ 5 file mới nhất
ls -tp "$BACKUP_DIR"/*.tar.gz 2>/dev/null | tail -n +6 | xargs -r rm --

echo "$(date '+%Y-%m-%d %H:%M:%S') : Cron backup completed" >> "$LOG_DIR/cron.log"

# Chuyển đến thư mục project
cd "$BASE_DIR" || exit

# Thêm các thay đổi
git add .

# Commit nếu có thay đổi
git commit -m "Auto backup $(date '+%Y-%m-%d %H:%M:%S')" >/dev/null 2>&1

# Push lên GitHub
git push origin main >/dev/null 2>&1

echo "$(date '+%Y-%m-%d %H:%M:%S') : GitHub push completed" >> "$LOG_DIR/cron.log"
