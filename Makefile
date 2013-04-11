CC=coffee
OUT=lib/inform-plugin-tropo-sms
IN=src/

all: lib/inform-plugin-tropo-sms
	${CC} -o ${OUT} -c ${IN}

lib/inform-plugin-tropo-sms:
	mkdir -p "${OUT}"

