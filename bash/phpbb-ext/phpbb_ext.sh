#!/bin/bash --

# A script to package a phpBB extension
# https://github.com/AlfredoRamos/snippets/tree/master/bash/phpbb-ext

# ${1}	Extension directory
# ${2}	Key of the composer.json file
get_json_data() {
	local data=""
	local json="${1}/composer.json"

	if [[ -f "${json}" ]]; then
		data=$(php -r "\$data = json_decode(file_get_contents(\"${json}\"), true); \
			printf('%s', !empty(\$data['${2}']) ? \$data['${2}'] : '');")
	fi

	printf "${data}"
}

# ${1}	Extension directory
# ${2}	Output directory
generate_package() {
	local old_dir="$(pwd)"
	local input_dir="${1}"
	local output_dir="${2}"
	local extension_path="$(get_json_data "${1}" 'name')"
	local vendor_name="$(dirname "${extension_path}")"
	local extension_name="$(basename "${extension_path}")"
	local extension_version="$(get_json_data "${1}" 'version')"
	local file_name="${vendor_name}_${extension_name}_${extension_version}"
	local excluded_files=(
		'tests/'
		'travis/'
		'build.xml'
		'phpunit.xml.dist'
		'LICENSE'
		'README.md'
		'.travis.yml'
		'.git*'
	)

	# Create extension directory
	if [[ ! -d "${output_dir}/${extension_path}" ]]; then
		mkdir -m 755 -p "${output_dir}/${extension_path}"
	fi

	# Copy data
	cp -R "${input_dir}"/* "${output_dir}/${extension_path}/"

	# Remove unneeded files
	for file in "${excluded_files[@]}"; do
		rm -fR "${output_dir}/${extension_path}/${file}"
	done

	# Fix license
	# http://stackoverflow.com/a/1120952
	local php_files=()

	while IFS= read -r -d $'\0' f; do
		php_files+=("${f}")
	done < <(find "${output_dir}/${extension_path}" -type f -path "*.php" -print0)

	for file in "${php_files[@]}"; do
		sed -ri 's|(GPL-)3\.0\+|\12\.0|' "${file}"
	done

	sed -ri 's|(GPL-)3\.0\+|\12\.0|' "${output_dir}/${extension_path}/composer.json"
	cp -f "${old_dir}/license.txt" "${output_dir}/${extension_path}/"

	# Create zip file
	cd "${output_dir}"
	zip -FSr "${file_name}.zip" "${extension_path}"

	# Create checksums
	sha512sum *.zip > checksums.sha512

	# Delete unneeded files
	if [[ -f "${file_name}.zip" ]]; then
		rm -fR "${vendor_name}"
	fi
}

if [[ ! -z "${1}" && ! -z "${2}" ]]; then
	generate_package "${1}" "${2}"
else
	printf 'You need to specify both input and output directory:\n'
	printf "${0} \"dir\" \"dir\"\n"
fi
