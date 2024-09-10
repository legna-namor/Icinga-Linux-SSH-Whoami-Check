# Explanation:
1. Check Execution: The script tries to establish an SSH connection.
2. The command $(...) is used to capture the output of the ssh command.
3. 2>/dev/null is added to suppress any SSH error messages.
4. [ $? -eq 0 ] checks if the SSH command succeeded.
5. [ "$output" = "$USERNAME" ] compares the output of whoami to the string $USERNAME.
6. The script exits with a status code of 0 if both conditions are true (SSH succeeded and user is $USERNAME). Otherwise, it exits with a status code of 2.
* * *
# Usage in Icinga:
* Make sure the script is executable: 
```shell
chmod 755 check_ssh_whoaami.sh
chmod +x check_ssh_whoaami.sh
```
* Place the script in your Icinga check command directory (/usr/lib64/nagios/plugins/).
* Define a new check command in Icinga’s configuration:
```icinga
object CheckCommand "check_ssh_whoaami" {
    command = [ "/usr/lib/nagios/plugins/check_ssh_whoaami.sh" ]
    arguments = {
        "-H" = {
            required = true
            value = "$hostname$"
        }
        "-U" = {
            required = true
            value = "$username$"
        }
    }
}
```
* Use this check command in a service definition for a host.
* Adjust the script and command definition according to your environment's needs (e.g., handling multiple arguments or specific options).
* * *
# SSH KEYS
* Place id_rsa and id_rsa at: /usr/lib64/nagios/.ssh
* Make sure the have the correct permissions: 
```shell
chmod -R 600 /usr/lib64/nagios/.ssh
chown -R icinga:icinga /usr/lib64/nagios/.ssh
```
