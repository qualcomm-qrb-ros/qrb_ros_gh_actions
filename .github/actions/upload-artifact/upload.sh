#!/bin/bash
# Copyright (c) Qualcomm Innovation Center, Inc. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause
set -e

# Inputs from environment (set by action.yml via env:)
# INPUT_PATH, INPUT_DESTINATION, INPUT_S3_BUCKET, INPUT_RETENTION,
# INPUT_FILESERVER_URL, INPUT_WRITE_SUMMARY

check_credentials() {
  if ! aws sts get-caller-identity >/dev/null 2>&1; then
    echo "AWS credentials are missing or invalid."
    exit 1
  fi
}

# Upload a single file. Writes "ok:<rel>" or "fail:<rel>" to $1 (results file).
upload_file() {
  local results_file="$1" file="$2" key="$3" rel="$4"
  echo "Uploading: $file -> s3://${INPUT_S3_BUCKET}/${key}"
  if aws s3api put-object \
    --bucket "$INPUT_S3_BUCKET" \
    --key "$key" \
    --body "$file" \
    --tagging "retention=${INPUT_RETENTION}"; then
    echo "ok:${rel}" >> "$results_file"
  else
    echo "fail:${rel}" >> "$results_file"
  fi
}

# Upload all files under INPUT_PATH, recording results to a temp file.
run_uploads() {
  local results_file="$1" input_path="${INPUT_PATH%/}"
  if [ -f "$input_path" ]; then
    local rel; rel="$(basename "$input_path")"
    upload_file "$results_file" "$input_path" "${INPUT_DESTINATION}${rel}" "$rel"
  else
    while IFS= read -r file; do
      local rel="${file#${input_path}/}"
      upload_file "$results_file" "$file" "${INPUT_DESTINATION}${rel}" "$rel"
    done < <(find "$input_path" -type f)
  fi
}

# Write $GITHUB_OUTPUT from results file. Returns 1 if any uploads failed.
generate_output() {
  local results_file="$1" base_url="$2"
  echo "url=${base_url}" >> "$GITHUB_OUTPUT"
  echo "files<<__EOF__" >> "$GITHUB_OUTPUT"
  grep '^ok:' "$results_file" | sed 's/^ok://' >> "$GITHUB_OUTPUT"
  echo "__EOF__" >> "$GITHUB_OUTPUT"
  if grep -q '^fail:' "$results_file"; then
    grep '^fail:' "$results_file" | sed 's/^fail://' | while IFS= read -r rel; do
      echo "::warning::Failed to upload $rel"
    done
    return 1
  fi
}

# Write $GITHUB_STEP_SUMMARY from results file (only if WRITE_SUMMARY=true).
generate_summary() {
  local results_file="$1" base_url="$2"
  [ "$INPUT_WRITE_SUMMARY" = "true" ] || return 0
  printf '\n## Uploaded Artifacts\n' >> "$GITHUB_STEP_SUMMARY"
  grep '^ok:' "$results_file" | sed 's/^ok://' | while IFS= read -r rel; do
    echo "- [${rel}](${base_url}${rel})" >> "$GITHUB_STEP_SUMMARY"
  done
  grep '^fail:' "$results_file" | sed 's/^fail://' | while IFS= read -r rel; do
    echo "- :x: **${rel}** — upload failed" >> "$GITHUB_STEP_SUMMARY"
  done
}

main() {
  local results_file; results_file="$(mktemp)"
  trap 'rm -f "$results_file"' EXIT
  local base_url="${INPUT_FILESERVER_URL}/${INPUT_S3_BUCKET}/${INPUT_DESTINATION}"
  check_credentials
  run_uploads "$results_file"
  generate_summary "$results_file" "$base_url"
  generate_output "$results_file" "$base_url"
}

main
