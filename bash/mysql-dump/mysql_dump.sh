#!/bin/bash --

#
# A simple script to backup my databases using cronie
# https://github.com/AlfredoRamos/snippets/tree/master/bash/mysql-dump
#

# MySQL config
MYSQL_HOST=''
MYSQL_PORT=3306
MYSQL_DATABASES=()
MYSQL_USER=''
MYSQL_PASSWORD=''

# Backup config
BASE_DIR="$(pwd)"
BACKUP_DIR="${BASE_DIR}"/backup

# Generate filename
# ${1}	Database/file name
# ${2}	Timestamp format
# ${3}	Prefix string
# ${4}	Suffix string
get_filename() {
	local filename="${1}"
	local timestamp="${2}"
	local prefix="${3}"
	local suffix="${4}"
	local name=''

	if [[ -z "${timestamp}" ]]; then
		timestamp='%F %T%z'
	fi

	if [[ ! -z "${prefix}" && ! -z "${suffix}" ]]; then
		name="${prefix} ${filename} ${suffix}"
	elif [[ ! -z "${prefix}" && -z "${suffix}" ]]; then
		name="${prefix} ${filename}"
	elif [[ -z "${prefix}" && ! -z "${suffix}" ]]; then
		name="${filename} ${suffix}"
	else
		name="${filename}"
	fi

	printf "$(date +"${timestamp}") ${name}" | sed -r 's/[-+:]//g;s/ /_/g'
}

# Create writable backup directory
if [[ "${#MYSQL_DATABASES[@]}" -gt 0 ]]; then
	if [[ ! -d "${BACKUP_DIR}" ]]; then
		mkdir -m 755 -p "${BACKUP_DIR}"
	else
		chmod 755 "${BACKUP_DIR}"
	fi

	# Change current working directory
	cd "${BACKUP_DIR}"
fi

# Backup database schema
for database in "${MYSQL_DATABASES[@]}"; do
	mysqldump \
		--log-error="$(get_filename 'schema' '%F').log" \
		--host="${MYSQL_HOST}" \
		--port=${MYSQL_PORT} \
		--user="${MYSQL_USER}" \
		--password="${MYSQL_PASSWORD}" \
		--result-file="$(get_filename ${database} '' 'schema').sql" \
		--databases "${database}" \
		--no-data
done

# Backup database data
for database in "${MYSQL_DATABASES[@]}"; do
	mysqldump \
		--log-error="$(get_filename 'data' '%F').log" \
		--host="${MYSQL_HOST}" \
		--port=${MYSQL_PORT} \
		--user="${MYSQL_USER}" \
		--password="${MYSQL_PASSWORD}" \
		--result-file="$(get_filename ${database} '' 'data').sql" \
		--databases "${database}" \
		--single-transaction \
		--quick \
		--add-drop-table \
		--replace \
		--no-create-db \
		--no-create-info
done

# Compress backup
if [[ $(find . -maxdepth 1 -type f -name '*.sql' | wc -l) -gt 0 ]]; then
	name="$(get_filename 'backup')"

	# SHA512
	sha512sum *.sql > "$(get_filename 'sha512sums').txt"

	# XZ
	tar cJf "${name}.tar.xz" *.sql *.txt

	# Delete unneeded files
	if [[ -f "${name}.tar.xz" ]]; then
		rm -f *.sql *.txt
	fi
fi
