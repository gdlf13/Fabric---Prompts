#!/bin/bash

# Run this script once you've run `poetry install` for getting dependencies

# It will create aliases (command nicknames) for the python binaries to be known
# by your OS

# List of commands to check and add alias for
commands=("fabric" "fabric-api" "fabric-webui")

# List of shell configuration files to update
config_files=(~/.bashrc ~/.zshrc)

for config_file in "${config_files[@]}"; do
  # Check if the configuration file exists
  if [ -f "$config_file" ]; then
    echo "Updating $config_file"
    for cmd in "${commands[@]}"; do
      # Get the path of the command
      CMD_PATH=$(poetry run which $cmd)

      # Check if the config file contains an alias for the command
      if grep -q "alias $cmd=" "$config_file"; then
        echo "Alias for $cmd already exists in $config_file."
      else
        # If not, add the alias to the config file
        echo "Adding alias for $cmd to $config_file."
        echo "alias $cmd='$CMD_PATH'" >> "$config_file"
      fi
    done
  else
    echo "$config_file does not exist."
  fi
done