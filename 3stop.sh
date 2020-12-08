#!/bin/bash

if [[ ${#} -ne 1 || ! -f doli${1}/docker-compose.yml ]]; then
	echo "Wrong syntax or project not found. Exiting.
	
Stop dolibarr on Docker. 

Usage: 
  ${0} mode		
        Stops the container group called 'dolimode' 
        (preffixed the 'doli' word).
        i.e.: mode = { prod | devel | other-doli*-folder-created }.
        The file dolimode/docker-compose.yml must exist before running this 
        script."
else
	docker-compose --file doli${1}/docker-compose.yml stop 
fi
