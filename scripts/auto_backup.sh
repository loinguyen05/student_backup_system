#!/bin/bash

BASE_DIR="$(dirname "$(dirname "$(realpath "$0")")")"

BACKUP_DIR="$BASE_DIR/backups"
LOG_DIR="$BASE_DIR/logs"

GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

backup_now() {
    bash "$BASE_DIR/scripts/backup_cron.sh"
    echo -e "${GREEN}Backup thành công!${NC}"
}

show_backups() {
    echo "===== DANH SÁCH BACKUP ====="
    ls -lh "$BACKUP_DIR"
}

show_logs() {
    echo "===== BACKUP LOG ====="
    cat "$LOG_DIR/backup.log"
}

check_internet() {

    if ping -c 1 google.com >/dev/null 2>&1
    then
        echo -e "${GREEN}Internet: OK${NC}"
    else
        echo -e "${RED}Internet: FAILED${NC}"
    fi
}

while true
do
    clear

    echo -e "${BLUE}"
    echo "================================"
    echo " STUDENT BACKUP SYSTEM"
    echo "================================"
    echo "1. Backup dữ liệu"
    echo "2. Xem danh sách backup"
    echo "3. Xem log"
    echo "4. Kiểm tra Internet"
    echo "5. Thoát"
    echo -e "${NC}"

    read -p "Chọn chức năng: " choice

    case $choice in

        1)
            backup_now
            ;;

        2)
            show_backups
            ;;

        3)
            show_logs
            ;;

        4)
            check_internet
            ;;

        5)
            exit 0
            ;;

        *)
            echo "Lựa chọn không hợp lệ"
            ;;
    esac

    echo
    read -p "Nhấn Enter để tiếp tục..."
done
