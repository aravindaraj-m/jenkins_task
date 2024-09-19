#!/bin/bash


input_file="$1"
output_file="$2"


awk 'NR < 5 { print; next } /welcome/ {gsub(/give/,"learning") }1'  "$input_file" > "$output_file"

echo "Replacement completed check the $output_file"
