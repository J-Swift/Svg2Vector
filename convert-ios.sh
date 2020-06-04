#/usr/bin/env bash

set -euo pipefail

readonly in_dir="${1:-mounts/input}"
readonly out_dir="${2-mounts/output}/ios"

if [ ! -d "${in_dir}" ]; then
    echo "ERROR: input directory [${in_dir}] doesnt exist!"
    exit 1
fi

################################################################################
# Helpers
################################################################################

# filename = mounts/input/ic_foo.svg
# echos "ic_foo"
function get_name_without_extension() {
    local -r filename="${1%.*}"

    echo "$(basename "${filename}")"
}

# infile = mounts/input/ic_foo.svg
# out_basename = ic_foo
function convert_to_pdf() {
    local -r infile="${1}"
    local -r out_basename="${2}"

    local -r tmp_file=$( mktemp )
    mv "${tmp_file}" "${tmp_file}.pdf"

    GDK_BACKEND=x11 inkscape --export-filename="${tmp_file}.pdf" "${infile}"
    write_imageset "${tmp_file}.pdf" "${out_basename}"
}

# infile = /tmp/foo.j2ojaoi.pdf
# out_basename = ic_foo
function write_imageset() {
    local -r infile="${1}"
    local -r out_basename="${2}"

    local -r imageset_path="${out_dir}/${out_basename}.imageset"
    mkdir -p "${imageset_path}"
    cat << EOF > "${imageset_path}/Contents.json"
{
  "images": [
    {
      "filename": "${out_basename}.pdf",
      "idiom": "universal"
    }
  ],
  "info": {
    "version": 1,
    "author": "Svg2Vector"
  },
  "properties": {
    "preserves-vector-representation": true
  }
}
EOF
    mv "${infile}" "${imageset_path}/${out_basename}.pdf"
}


################################################################################
# DO WORK SON
################################################################################

function main() {
    for filename in "${in_dir}"/*.svg; do
        local raw_name=$(get_name_without_extension "${filename}")

        local asset_name="${raw_name}.imageset"

        if [ -f "${out_dir}/${asset_name}" ] || [ -d "${out_dir}/${asset_name}" ]; then
            echo "[${asset_name}] already exists... skipping"
            continue
        fi

        echo -n "Converting [$(basename ${filename})] to [${asset_name}]..."
        convert_to_pdf "${filename}" "${raw_name}"
        echo " done"
    done

    echo ""
    echo 'Done!'
}

main
