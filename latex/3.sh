# Print PATH environment variable, one folder per line (instead of ':')
echo "${PATH//:/$'\n'}"
