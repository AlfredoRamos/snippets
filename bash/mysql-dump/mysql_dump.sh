#!/bin/sh --

# MySQL config
MYSQL_HOST=<HOST>
MYSQL_PORT=3306
MYSQL_DATABASE=<DATABASE>
MYSQL_USER=<USER>
MYSQL_PASSWORD=<PASSWORD>
MYSQL_LOG=mysql_dump.log

# Backup config
BASE_DIR=$(pwd)
BACKUP_DIR=${BASE_DIR}/backup
BACKUP_TIMESTAMP="$(date +'%F %T %z')"
BACKUP_FILENAME="$(printf "%s" "${MYSQL_DATABASE} ${BACKUP_TIMESTAMP}" | sed -e 's/[-:]//g' -e 's/ /_/g')"

# Create writable backup directory
if [[  ! -d ${BACKUP_DIR} ]]; then
	mkdir -m 755 -p ${BACKUP_DIR}
fi

# Change current working directory
cd ${BACKUP_DIR}

# Create backup
mysqldump --single-transaction --quick --add-drop-table --replace --log-error=${BASE_DIR}/${MYSQL_LOG} --host=${MYSQL_HOST} --port=${MYSQL_PORT} --user=${MYSQL_USER} --password=${MYSQL_PASSWORD} --result-file=${BACKUP_FILENAME}.sql ${MYSQL_DATABASE}

if [[ -f ${BACKUP_FILENAME}.sql ]]; then
	# Create SHA512 file
	echo "; ${BACKUP_TIMESTAMP}" > ${BACKUP_FILENAME}.sql.sha512
	sha512sum ${BACKUP_FILENAME}.sql >> ${BACKUP_FILENAME}.sql.sha512

	# Compress backup file (XZ)
	tar cJf ${BACKUP_FILENAME}.tar.xz ${BACKUP_FILENAME}.sql*
	
	# Delete SQL and SHA512 file
	rm -f ${BACKUP_FILENAME}.sql*
fi