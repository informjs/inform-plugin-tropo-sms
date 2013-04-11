CC=coffee
OUT=lib/tropo-sms
IN=src/

all: lib/tropo-sms
	${CC} -o ${OUT} -c ${IN}

lib/tropo-sms:
	mkdir -p "${OUT}"

