exec &> >(tee -a log.out)  # Redirect stdout and stderr to file
exec &> /dev/tty           # Reset stdout and stderr

exec 3<> filename  # Open FD
exec 3>&-          # Close FD
exec 4>&3          # Copy FD 3 to 4
echo "foo" >&3     # Write to FD
cat <&3            # Read from FD
