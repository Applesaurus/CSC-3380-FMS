#!/bin/bash

#based off an example init script for fastcgi w/ php provided by NGiNX, adopted for c++

BIND=127.0.0.1:9000
CPP_FCGI_CHILDREN=    #not sure yet
CPP_FCGI_MAX_REQUESTS= 

#arguments for running the files, may need to change some of them
CPP_CGI=/usr/bin/cpp-cgi
CPP_CGI_NAME= ``
CPP_CGI_ARGS="- USER=$USER PATH=/usr/bin CPP_FCGI_CHILDREN=$CPP_FCGI_CHILDREN CPP_MAX_REQUESTS=$CPP_FCGI_MAX_REQUESTS $CPP_CGI -b $BIND"
RETVAL=0

start() {
	echo -n "Starting CPP FastCGI: "
	start-stop-daemon --quiet --start --background --chuid "$USER" --exec /usr/bin/env -- $CPP_CGI_ARGS
	RETVAL=$?
	echo "$CPP_CGI_NAME."
}

stop () {
	echo -n "Stopping CPP FastCGI: "
	killall -q -w -u $USER $CPP_CGI
	RETVAL=$?
	echo "$PHP_CGI_NAME."
}

case "$1" in
	start)
	        start
        ;;
        stop)
		stop
	;;
        restart)
		stop
		start
	;;
        *)
		echo "Usage: cpp-fastcgi {start|stop|restart)"
		exit 1
	;;
esac
exit $RETVAL
