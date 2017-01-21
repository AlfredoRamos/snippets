#!/bin/bash --

# A simple script to backup my databases using cronie
# https://github.com/AlfredoRamos/snippets/tree/master/bash/mysql-dump

# Configuration
args=("$@")
declare -A mysql
declare -A backup

# Generate filename
# ${1}	Database/file name
# ${2}	Timestamp format
# ${3}	Prefix string
# ${4}	Suffix string
gen_filename() {
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

parse_args() {
	# Default values
	mysql[host]='localhost'
	mysql[port]=3306
	mysql[databases]=''
	mysql[user]=''
	mysql[password]=''

	# Directories
	backup[root]="$(pwd)"
	backup[path]="${backup[root]}"/backup

	# Parse arguments
	for arg in "${args[@]}"; do
		case "${arg}" in
			--mysql-host=*)
				if [[ ! -z "${arg#*=}" ]]; then
					mysql[host]="${arg#*=}"
				fi
				;;
			--mysql-port=*)
				if [[ ! -z "${arg#*=}" ]]; then
					mysql[port]="${arg#*=}"
				fi
				;;
			--mysql-databases=*)
				if [[ ! -z "${arg#*=}" ]]; then
					mysql[databases]="${arg#*=}"
				fi
				;;
			--mysql-user=*)
				if [[ ! -z "${arg#*=}" ]]; then
					mysql[user]="${arg#*=}"
				fi
				;;
			--mysql-password=*)
				if [[ ! -z "${arg#*=}" ]]; then
					mysql[password]="${arg#*=}"
				fi
				;;
			--backup-path=*)
				if [[ ! -z "${arg#*=}" ]]; then
					backup[path]="${arg#*=}"
				fi
				;;
			*)
		esac
	done
}

create_backups() {
	# Convert databases string to array
	if [[ ! -z "${mysql[databases]}" ]]; then
		readarray -t databases <<< "$(printf "${mysql[databases]}" | tr ',' "\n")"
	else
		databases=()
	fi

	# Create backup paths
	if [[ "${#databases[@]}" -gt 0 ]]; then
		mkdir -m 755 -p "${backup[path]}"

		# Change working directory
		cd "${backup[path]}"
	fi

	# Create backups
	for database in "${databases[@]}"; do
		# Schema backup
		mysqldump \
			--log-error="$(gen_filename 'schema' '%F').log" \
			--host="${mysql[host]}" \
			--port=${mysql[port]} \
			--user="${mysql[user]}" \
			--password="${mysql[password]}" \
			--result-file="$(gen_filename ${database} '' 'schema').sql" \
			--databases "${database}" \
			--no-data

		# Data backup
		mysqldump \
			--log-error="$(gen_filename 'data' '%F').log" \
			--host="${mysql[host]}" \
			--port=${mysql[port]} \
			--user="${mysql[user]}" \
			--password="${mysql[password]}" \
			--result-file="$(gen_filename ${database} '' 'data').sql" \
			--databases "${database}" \
			--single-transaction \
			--quick \
			--add-drop-table \
			--replace \
			--no-create-db \
			--no-create-info
	done
}

# ${1}	string	Directories to compress
compress_backups() {
	# Change working directory
	if [[ -f "${backup[path]}" ]]; then
		cd "${backup[path]}"
	fi

	if [[ $(find . -maxdepth 1 -type f -name '*.sql' | wc -l) -gt 0 ]]; then
		local tar_file="$(gen_filename 'backup').tar.xz"

		# SHA512
		sha512sum *.sql > "$(gen_filename 'checksums').sha512"

		# XZ
		tar cJf "${tar_file}" *.sql *.sha512

		# Delete unneeded files
		if [[ -f "${tar_file}" ]]; then
			rm -f *.sql *.sha512
		fi
	fi
}

main() {
	# Read arguments
	parse_args

	# Create *.sql files
	create_backups

	# Compress generated files
	compress_backups
}

# Call main function
main
