# Icinga-Linux-SSH-Whoami-Check
This Icinga check establishes an SSH connection to a remote Linux host and runs whoami. It suppresses SSH errors and verifies the user is "core." If SSH succeeds and the user is "core," it returns 0 (OK). If either condition fails, it returns 2 (Critical).
