ps1='\e[1;31mroot\e[0m@\e[1;32msaltmaster\e[0m~# '
trap 'printf "$ps1$BASH_COMMAND"; read' DEBUG
