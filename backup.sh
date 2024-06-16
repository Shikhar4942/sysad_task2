#!/bin/bash
set -x  
DB_HOST="localhost"
DB_USER="shikhar"
DB_PASS="shikhar100"
DB_NAME="taskdb"


BACKUP_DIR="/home/core/cronjob"


[ ! -d "$BACKUP_DIR" ] && mkdir -p "$BACKUP_DIR"

DATE=$(date +%Y%m%d_%H%M%S)


BACKUP_FILE="$BACKUP_DIR/$DB_NAME-$DATE.sql"


HOUR=$(date +%H)
MINUTE=$(date +%M)
DAY_OF_MONTH=$(date +%d)
DAY_OF_WEEK=$(date +%u) # 1=Monday, 2=Tuesday, ..., 7=Sunday
MONTH=$(date +%m)


FIRST_DAY=$(date -d "$(date +%Y-%m-01) +$(( (DAY_OF_WEEK-$(date -d $(date +%Y-%m-01) +%u) + 7) % 7 )) days")
DAY_OF_WEEK_OCCURRENCES=()
for (( i=0; i<5; i++ )); do
    OCCURRENCE=$(date -d "$FIRST_DAY +$(( i * 7 )) days" +%d)
    if [ $(date -d "$FIRST_DAY +$(( i * 7 )) days" +%m) -eq $MONTH ]; then
        DAY_OF_WEEK_OCCURRENCES+=($OCCURRENCE)
    fi
done
IS_SECOND_OCCURRENCE=$(echo ${DAY_OF_WEEK_OCCURRENCES[1]})

echo "Backup starting at $(date)"
echo "Current conditions: HOUR=$HOUR, MINUTE=$MINUTE, DAY_OF_MONTH=$DAY_OF_MONTH, DAY_OF_WEEK=$DAY_OF_WEEK, MONTH=$MONTH"

if ([ "$HOUR" -ge 5 ] && [ "$HOUR" -le 8 ] && [ "$MINUTE" -eq 3 ]) || \
   ([ "$HOUR" -eq 15 ] && [ "$DAY_OF_MONTH" -eq 1 ] && [ "$MINUTE" -eq 3 ]) || \
   ([ "$DAY_OF_MONTH" -eq "$IS_SECOND_OCCURRENCE" ] && [ "$MONTH" -ge 1 ] && [ "$MONTH" -le 7 ] && [ "$HOUR" -eq 3 ] && [ "$MINUTE" -eq 3 ]); then
   echo "Backup conditions met. Starting mysqldump..."
   docker exec condescending_margulis mysqldump -u $DB_USER -p$DB_PASS $DB_NAME > $BACKUP_FILE
   echo "Backup completed: $BACKUP_FILE"
else
   echo "Backup conditions not met. No backup performed."
fi


